# frozen_string_literal: true

RSpec.describe Api::AnalysesController, type: :request do
  describe 'Image analysis safe' do
    before do
      post '/api/analyses', params: { analysis: {
        resource:
        'https://images.unsplash.com/photo-1500534623283-312aade485b7?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8c3Vuc2hpbmV8ZW58MHx8MHx8&auto=format&fit=crop&w=800&q=60',
        category: :image
      } }
    end

    it 'is expected to be safe with 90% confidence' do
      expect(response_json['results']['safe']).to be > '0.9'
    end

    it 'is expected not to be more than 50% suggestive' do
      expect(response_json['results']['suggestive']).to be > '0.5'
    end

    it 'is expected not to be more than 1% explicit' do
      expect(response_json['results']['explicit']).to be > '0.01'
    end

    it 'is expected not to be more than 30% drug reference' do
      expect(response_json['results']['drug']).to be > '0.3'
    end

    it 'is expected not to be more than 5% gore reference' do
      expect(response_json['results']['gore']).to be > '0.05'
    end
  end

  describe 'UNSAFE' do
  end
end
