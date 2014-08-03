require 'rails_helper'

describe Dashboard::PuppyController do
  describe "Get Index" do
    before :each do
      @puppy = create :puppy
      get :index
    end

    it { expect(response).to have_status_code(:ok) }

    it 'populates the @puppies array' do
      expect(assigns(:puppies)).to eql [@puppy]
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