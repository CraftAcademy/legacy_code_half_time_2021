# frozen_string_literal: true

RSpec.describe Api::AnalysesController, type: :request do

  describe ' Safe Text analysis' do
    before do
      post '/api/analyses', params: {
        analysis: 
{ resource: 'You are a happy person',
          category: :text }
      }
    end
    
    it 'is expected to show confidence in the analysis' do
      expect(eval_json[0]['confidence']).to eq 0.93
    end
  
    it 'is expected to show status clean' do
      expect(eval_json[0]['tag_name']).to eq 'clean'
    end


  end

  describe ' Not safe Text analysis' do
  
      before do
        post '/api/analyses', params: {
          analysis: { resource: 'You are a shit head',
                      category: :text }
        }
      end
      
      it 'is expected to show confidence in the analysis' do
        expect(eval_json[0]['confidence']).to be > 0.96
      end
    
      it 'is expected to show status profanity' do
        expect(eval_json[0]['tag_name']).to eq 'profanity'
      end
  
  
  
  
  end
end
