# frozen_string_literal: true

RSpec.describe Api::AnalysesController, type: :request do
  describe 'Image analysis safe' do
    
    before do
    post '/api/analyses', params: { analysis: {
      resource: 
      'https://live-production.wcms.abc-cdn.net.au/b80fe1cc9a6b7e8bd55ead72036d781c?impolicy=wcms_crop_resize&cropH=1266&cropW=2250&xPos=0&yPos=1493&width=862&height=485',
      category: :image
    } }
    end

  it'is expected to have be safe with 90% confidence' do
    expect(response_json['results']['safe']).to be > "0.9"
    end
    
  end




    describe 'UNSAFE' do
    end

end
