require 'rails_helper'

RSpec.describe "Api::V1::Users", type: :request do

  describe "GET /index" do
    xit "returns http success" do
      get "/api/v1/user/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    xit "returns http success" do
      get "/api/v1/user/show"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /create" do
    xit "returns http success" do
      get "/api/v1/user/create"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /update" do
    xit "returns http success" do
      get "/api/v1/user/update"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /destroy" do
    xit "returns http success" do
      get "/api/v1/user/destroy"
      expect(response).to have_http_status(:success)
    end
  end

end
