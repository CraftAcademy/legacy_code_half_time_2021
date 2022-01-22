# frozen_string_literal: true

RSpec.describe Api::AnalysesController, type: :request do
  describe 'Image analysiss' do
    describe 'SAFE' do
      before do
        post'/api/analyses', params: {
          'analysis':{
            'resource':'https://hips.hearstapps.com/countryliving.cdnds.net/17/47/2048x1365/gallery-1511194376-cavachon-puppy-christmas.jpg?resize=980:*',
            'category':'image'
          }
        }
      end
         it 'is expected to return a 200 status'do
         expect(response.status).to eq 200
         end
         it 'is expected to check if image is safe' do
          
          expect(JSON.parse(response.body)['results']['safe'].to_i
          ).to eq 1
           
         end
    end


   
  

    describe 'UNSAFE' do
    end
  end
end
