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
    orientation = @puppy.get_orientation_of_image
    @puppy.orientation = orientation

    if @puppy.save && !orientation.nil?
      redirect_to dashboard_puppies_path
    else
      flash[:alert] = 'There was an issue updating the puppy. Please try again later'
      render :new, status: orientation.nil? ? 422 : 200
    end
  end

  def update
    @puppy = Puppy.find_by id: params[:id]
    @puppy.image = puppy_params[:image]
    @puppy.orientation = @puppy.get_orientation_of_image

    if @puppy.save
      redirect_to dashboard_puppies_path
    else
      flash[:alert] = 'There was an issue updating the puppy. Please try again later'
      render :edit
    end
  end

  def edit
    puppies = Puppy.where id: params[:id]

    if puppies.nil? || puppies.count == 0
      flash[:alert] = "Unable to find puppy no. #{params[:id]}. Please try again."
      redirect_to dashboard_puppies_path
    else
      @puppy = puppies.first
    end
  end

  def destroy
    @puppy = Puppy.where id: params[:id]

    if @puppy.nil? || @puppy.empty? || !@puppy.first.destroy
      @message = 'Unable to delete this Puppy - it does not exist in the database.'
      render partial: 'shared/status_422', status: 422
    else
      @message = 'Puppy successfully removed from the database. Have an epic day!'
      render partial: 'shared/status_200'
    end
  end

  def toggle_disabled
    puppy = Puppy.find(params[:id])

    if puppy.nil?
      @message = 'The puppy you are attempting to disable does not exist.'
      render partial: 'shared/status_422', status: 422
    else
      puppy.toggle(:disabled).save

      @message = "The puppy has been successfully #{puppy.enabled? ? 'enabled' : 'disabled'}."
      render partial: 'shared/status_200'
    end
  end

  private
    def puppy_params
      params.require(:puppy).permit(:image)
    end
end
