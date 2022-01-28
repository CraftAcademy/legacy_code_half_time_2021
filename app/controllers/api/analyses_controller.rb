# frozen_string_literal: true

class Api::AnalysesController < ApplicationController
  before_action :analyze_resource, only: [:create]

  def create
    analysis = Analysis.create(analysis_params
                                   .merge!(results: @results,
                                           request_ip: request.remote_ip))

    if analysis.persisted? && analysis.results['error'] == 'false'
      render json: analysis
    elsif analysis.persisted? && analysis.results['error'] == 'true'
      render json: analysis.results.error, status: 400
    else
      render json: analysis.errors.full_messages, status: 422
    end
  end

  private

  def analysis_params
    params.require(:analysis).permit!
  end

  def analyze_resource
    resource = analysis_params[:resource]
    if analysis_category == :image
      @results = image_analysis(resource)
    elsif analysis_category == :text
      @results = text_analysis(resource)
    end
  end

  def text_analysis(text)
    text_as_array = []
    text_as_array << text
    text_as_array.flatten!
    binding.pry
    model_id = 'cl_KFXhoTdt' # Profanity & Abuse Detection
    response = Monkeylearn.classifiers.classify(model_id, text_as_array)
    response.body[0]
  end

  def image_analysis(url)
    Clarifai::Rails::Detector
      .new(url)
      .image
      .concepts_with_percent
  rescue StandardError => e
    { message: e.message, error: 'true' }
  end

  def analysis_category
    analysis_params[:category].to_sym
  end
end
