class API::V1::PuppyController < ApplicationController
  def index
    @puppies = Puppy.all
    respond_to do |format|
      format.json { render :json => @puppies, :callback => params['callback'], :only => [ :id, :orientation, :image ] }
    end
  end
end