require 'rails_helper'

RSpec.describe 'Achievements API', type: :request do
  it 'sends public achievements' do
    public_achievement = FactoryBot.create(:public_achievement, title: 'My achievement')
    private_achievement = FactoryBot.create(:private_achievement)

    get '/api/achievements', params: nil, headers: { 'Content-Type': 'application/vnd.api+json' }

    expect(response.status).to eq(200)
    json = JSON.parse(response.body)

    expect(json['data'].count).to eq(1)
    expect(json['data'][0]['type']).to eq('achievements')
    expect(json['data'][0]['attributes']['title']).to eq('My achievement')
  end
end
