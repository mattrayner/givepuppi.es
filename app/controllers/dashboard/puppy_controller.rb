class Dashboard::PuppyController < DashboardController
  def index
  end

  def new
    @puppy = Puppy.new
  end

  def create
    @puppy = Puppy.new

    if @puppy.update(puppy_params)
      redirect_to dashboard_puppies
    else
      flash[:alert] = "There was an issue updating the puppy. Please try again later"
    end
  end
end
