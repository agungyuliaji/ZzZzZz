require 'rails_helper'

RSpec.describe "SleepRecords::Feeds", type: :request do
  describe "GET /my_records" do
    it "returns http success" do
      get "/sleep_records/feed/my_records"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /following_records" do
    it "returns http success" do
      get "/sleep_records/feed/following_records"
      expect(response).to have_http_status(:success)
    end
  end

end
