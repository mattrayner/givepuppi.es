require 'rails_helper'

describe API::V1::PuppyController do
  describe "GET index" do
    before :each do
      @puppy = create :puppy
      get :index, format: :json
    end

    it { expect(response).to have_http_status(:ok) }

    it "should populate @puppies" do
      expect(assigns(:puppies)).to eq([@puppy])
    end

    it "renders the correct JSON values" do
      expected_json = [{
          id: @puppy.id,
          orientation: @puppy.orientation
      }].to_json

      expect(response.body).to eql expected_json
    end
  end
end