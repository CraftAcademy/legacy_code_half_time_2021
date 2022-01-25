# frozen_string_literal: true

RSpec.describe Api::AnalysesController, type: :request do
  describe 'Text analysis' do
    before do
      post '/api/analyses', params: {
        analysis: {
          resource: 'Hi there, did you bring your coat?',
          category: 'text'
        }
      }
    end

    it 'is expected to return a 200 status code' do
      expect(response.status).to eq 200
    end

    it 'is expected to classify the text as clean' do
      expect(eval(JSON.parse(response.body)['results']['classifications'])[0]['tag_name']).to eq 'clean'
    end
  end
end
