class UsersController < ApplicationController
  protect_from_forgery with: :exception
  before_action :authenticate_user!

  def create
  end

  def index
  end

end
