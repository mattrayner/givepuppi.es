class API::V1::PuppiesController < ApplicationController
  def index
    @puppies = Puppy.all
    respond_to do |format|
      format.json { render :json => @puppies, :callback => params['callback'], :only => [ :id, :orientation, :avatar_file_name ] }
    end
  end
end