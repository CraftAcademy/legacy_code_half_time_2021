RSpec.describe Api::AnalysesController, type: :request do
  describe "Text analysis" do
    describe 'successfully' do
      
    
    before do
      post "/api/analyses", params: {
       analysis: { resource: "This is awesome",
       category: :text },
       }
    end
    it " is expected to respond with status code" do
      expect(response.status).to eq 200
  
    end
    it 'is expected to respond with degree of profinity' do
      #binding.pry
      expect(eval(JSON.parse(response.body)['results']['classifications'])[0]['tag_name']
      ).to eq 'clean'
      
    end
   end
   describe 'unsuccesfully ' do
     describe 'when there is no paramenter' do
       before do
        post "/api/analyses", params: {
         analysis: { resource: "",
         category: :'' },
         }
       end
       it 'is expect to return no result' do
        binding.pry
        expect(response.body['results'].nil?).to eq true
       end
        
      end
      
    
    
      describe 'when the category param is set to image' do
      end
      
    end
  
  end
end
