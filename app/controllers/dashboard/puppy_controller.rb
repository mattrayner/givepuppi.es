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
    @puppy.orientation = @puppy.get_orientation_of_image if puppy_params_image_exists

    if @puppy.save
      redirect_to dashboard_puppies_path
    else
      flash[:alert] = 'There was an issue updating the puppy. Please try again later.' if puppy_params_image_exists
      flash[:notice] = 'Please try again with an image for our puppy,' unless puppy_params_image_exists
      render :new, status: @puppy.orientation.nil? ? 422 : 200
    end
  end

  def update
    @puppy = Puppy.find_by id: params[:id]

    if puppy_params_image_exists
      @puppy.image = puppy_params[:image]
      @puppy.orientation = @puppy.get_orientation_of_image
    end

    if @puppy.save && !puppy_params[:image].nil? && !puppy_params[:image] == ''
      redirect_to dashboard_puppies_path
    else
      flash[:alert] = 'There was an issue updating the puppy. Please try again later' if puppy_params_image_exists
      flash[:notice] = 'You cannot update a puppy to no image... This would be bad.' unless puppy_params_image_exists
      render :edit, status: @puppy.orientation.nil? ? 422 : 200
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
      if params[:puppy].nil?
        return Hash.new(nil)
      else
        params.require(:puppy).permit(:image)
      end
    end

    def puppy_params_image_exists
      !(puppy_params[:image].nil? || puppy_params[:image] == '')
    end
end
