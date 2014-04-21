class PuppyController < ApplicationController
  def new
    @puppy = Puppy.new
  end

  def create
    @puppy = Puppy.new

    if @puppy.update(puppy_params)

    else
      flash[:alert] = "There was an issue updating the puppy. Please try again later"

      redirect_to dashboard_puppies
    end
  end
end
