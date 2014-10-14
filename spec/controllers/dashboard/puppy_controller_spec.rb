require 'rails_helper'

describe Dashboard::PuppyController do
  before :each do
    @user = create :user
    sign_in @user
  end

  describe '#index' do
    before :each do
      @puppy = create :puppy
      get :index
    end

    it { expect(response).to have_http_status(:ok) }
  end

  describe '#new' do
    before :each do
      get :new
    end

    it { expect(response).to be_ok }
    it { expect(response).to render_template(partial: '_form') }

    it 'should create the @puppy instance variable' do
      expect(controller.instance_variable_get(:@puppy)).to be_an_instance_of Puppy
    end
  end

  describe '#create' do
    context 'with valid data' do
      before :each do
        @count = Puppy.all.count

        @file = fixture_file_upload('rails.jpg', 'image/jpeg')
        post :create, puppy: {image: @file}
      end

      it 'adds a new puppy to the database' do
        expect(Puppy.all.count).to eql @count+1
      end

      it 'has an accessable image' do
        expect(Puppy.last.image).to exist
      end

      it { expect(response).to redirect_to edit_dashboard_puppy_url(Puppy.last) }
    end

    context 'with invalid data' do
      before :each do
        @count = Puppy.all.count

        post :create, puppy: {image: nil}
      end

      it { expect(response).not_to be_ok }
      it { expect(response).to render_template 'new' }
    end
  end

  describe '#toggle_disabled' do
    before :each do
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

  describe '#edit' do
    before :each do
      @puppy = create :puppy_with_image

      get :edit, {id: @puppy.id}
    end

    it { expect(response).to be_ok }
    it { expect(response).to render_template(partial: '_form') }

    it 'should create the @puppy instance variable' do
      expect(controller.instance_variable_get(:@puppy)).to be_an_instance_of Puppy
      expect(controller.instance_variable_get(:@puppy)).to eql @puppy
    end
  end

  describe '#update' do
    before :each do
      @puppy = create :puppy_with_image
    end

    context 'valid image' do
      before :each do
        @file = fixture_file_upload('ring.png', 'image/jpeg')
        put :update, id: @puppy.id, puppy: {image: @file}
      end

      it { expect(response).to redirect_to edit_dashboard_puppy_url }

      it 'does not set any FLASH messages' do
        expect(flash[:notice]).to be_nil
        expect(flash[:alert]).to be_nil
      end
    end

    context 'invalid image' do
      before :each do
        put :update, id: @puppy.id, puppy: {image: nil}
      end

      it 'has a response code of 422' do
        expect(response.code).to eql '422'
      end

      it 'sets a notice FLASH messages' do
        expect(flash[:notice]).not_to be_nil
        expect(flash[:alert]).to be_nil
      end
    end
  end

  describe '#destroy' do
    before :each do
      @puppy = create :puppy
    end

    context 'the puppy exists' do
      it 'returns status code OK' do
        xhr :delete, :destroy, {id: @puppy.id}

        expect(response).to be_ok
      end

      it 'removes one puppy from the database' do
        count = Puppy.all.count

        expect(count).to eql 1

        xhr :delete, :destroy, {id: @puppy.id}

        expect(Puppy.all.count).to eql (count-1)
      end
    end

    context 'the puppy does not exist' do
      it 'returns a 422 unprocessable code' do
        xhr :delete, :destroy, {id: 1000}

        expect(response.code).to eql '422'
      end
    end
  end
end