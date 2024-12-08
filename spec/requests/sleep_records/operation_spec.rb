require 'rails_helper'

RSpec.describe "SleepRecords::Operations", type: :request do
  describe "GET /sleep" do
    it "returns http success" do
      get "/sleep_records/operation/sleep"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /wake_up" do
    it "returns http success" do
      get "/sleep_records/operation/wake_up"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /reset" do
    it "returns http success" do
      get "/sleep_records/operation/reset"
      expect(response).to have_http_status(:success)
    end
  end

end
