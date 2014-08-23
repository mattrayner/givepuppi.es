require 'rails_helper'

describe Dashboard::WelcomeController do
  describe "Authentication" do
    before :each do
      @user = create :user
    end

    it 'redirects a not signed in session' do
      get :index
      expect(response).to have_http_status 302
    end

    it 'displays for a signed in user' do
      sign_in @user
      get :index
      expect(response).to have_http_status 200
    end
  end
  describe "Get Index" do
    before :each do
      @user = create :user
      sign_in @user
      @puppy = create :puppy
      get :index
    end

    it 'populates the @puppies array' do
      expect(controller.instance_variable_get(:@puppies).size).to eql 1
    end

    describe 'displays a puppy table' do
      before :each do
        @puppy2 = create :puppy
        get :index
      end

      it 'renders the correct partial' do
        expect(response).to render_template(partial: 'dashboard/shared/_puppy_table')
      end

      it 'renders a row for each of our puppies' do
        expect(response).to have_rendered(partial: "dashboard/shared/_puppy_row", count: 2)
      end
    end
  end
end