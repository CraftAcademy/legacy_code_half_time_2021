# frozen_string_literal: true

RSpec.describe Api::AnalysesController, type: :request do
  describe 'Text analysis' do
    describe 'Successfully' do
      describe 'For a single query' do
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
      describe 'For several queries' do
        before do
          post '/api/analyses', params: {
            analysis: {
              resource: ['Hi there, did you bring your coat?', 'Nice weather we are having'],
              category: 'text'
            }
          }
        end
        it 'is expected to do something' do
          binding.pry
        end
        
      end
    end
    describe 'Unsuccessfully' do
      describe 'when the parameters are set to empty strings' do
        before do
          post '/api/analyses', params: { analysis: { resource: '', category: '' } }
        end

        it 'is expted to return nil results' do
          expect(JSON.parse(response.body)['results'].nil?).to eq true
        end
      end
      describe 'when the category paramete is set to image' do
        before do
          post '/api/analyses', params: { analysis: { resource: 'This is a string sentence', category: :image } }
        end

        it 'is expected to return an error message' do
          expect(JSON.parse(response.body)['results']['error']).to eq '400 Bad Request'
        end
      end
    end
  end
end
