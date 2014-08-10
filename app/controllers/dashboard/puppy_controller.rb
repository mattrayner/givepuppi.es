class Dashboard::PuppyController < Dashboard::DashboardController
  def index
    @enabled_puppies = Puppy.enabled
    @disabled_puppies = Puppy.disabled
  end

  def new
    @puppy = Puppy.new
  end

  def create
    @puppy = Puppy.new
    @puppy.image = puppy_params[:image]
    @puppy.orientation = 'bbb'

    if @puppy.save
      redirect_to dashboard_puppies_path
    else
      flash[:alert] = "There was an issue updating the puppy. Please try again later"
      render :new
    end
  end

  def edit
    @puppy = Puppy.find(params[:id])
  end

  def toggle_disabled
    puppy = Puppy.find(params[:id])

    if puppy.nil?
      flash[:alert] = "The puppy you are attempting to disable does not exist."
    else
      puppy.toggle(:disabled).save
    end
  end

  private
    def puppy_params
      params.require(:puppy).permit(:image)
    end
end
