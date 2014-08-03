require 'rails_helper'

RSpec.describe User do
  before :each do
    @user = create :user
  end

  it 'returns a concatenated name with .full_name' do
    expect(@user.full_name).to eql 'Matt Rayner'
  end
end