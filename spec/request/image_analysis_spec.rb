# frozen_string_literal: true

RSpec.describe Api::AnalysesController, type: :request do
  describe 'Image analysiss' do
    post '/api/analyses', params: { analysis: {
      resource: 'https://c.tadst.com/gfx/1200x630/sunrise-sunset-sun-calculator.jpg?1',
      category: :image
    } }
  end


    describe 'UNSAFE' do
    end

end
