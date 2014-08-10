require 'rails_helper'

describe Dashboard::PuppyController do
  describe 'Get Index' do
    before :each do
      @user = create :user
      sign_in @user
      @puppy = create :puppy
      get :index
    end

    it { expect(response).to have_http_status(:ok) }
  end

  describe 'Create Puppy' do
    before :each do
      @user = create :user
      sign_in @user

      get :new
    end

    it { expect(response).to render_template(partial: '_form') }
  end

  describe 'Toggle Disabled' do
    before :each do
      @user = create :user
      sign_in @user

      @puppy = create :puppy
    end

    it 'has a 200 (ok) status code' do
      xhr :get, :toggle_disabled, {id: @puppy.id}
      expect(response).to have_http_status :ok
    end

    it 'disables an enabled puppy' do
      expect(@puppy.disabled).to be false

      xhr :get, :toggle_disabled, {id: @puppy.id}

      expect(@puppy.reload.disabled).to be true
    end

    it 'enables a disabled puppy' do
      @puppy.update disabled: true

      expect(@puppy.disabled).to be true

      xhr :get, :toggle_disabled, {id: @puppy.id}

      expect(@puppy.reload.disabled).to be false
    end
  end
end