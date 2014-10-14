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

    valid_puppy_image = puppy_params_image_valid

    if valid_puppy_image
      @puppy.image = puppy_params[:image]
      @puppy.orientation = @puppy.get_orientation_of_image
    end

    if @puppy.save
      redirect_to edit_dashboard_puppy_path(@puppy)
    else
      flash[:alert] = 'There was an issue updating the puppy. Please try again later.' if valid_puppy_image
      flash[:notice] = 'Please try again with an image for our puppy,' unless valid_puppy_image
      render :new, status: @puppy.orientation.nil? ? 422 : 200
    end
  end

  def update
    @puppy = Puppy.find_by id: params[:id]

    valid_puppy_image = puppy_params_image_valid

    if valid_puppy_image
      @puppy.image = puppy_params[:image]
      @puppy.orientation = @puppy.get_orientation_of_image

      return redirect_to edit_dashboard_puppy_path if @puppy.save
    end

    flash[:alert] = 'There was an issue updating the puppy. Please try again later' if valid_puppy_image
    flash[:notice] = 'You cannot update a puppy to no image... This would be bad.' unless valid_puppy_image
    render :edit, status: 422
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

    def puppy_params_image_valid
      (puppy_params[:image].class == ActionDispatch::Http::UploadedFile || puppy_params[:image].class == Rack::Test::UploadedFile) && !(puppy_params[:image].content_type.match /image\/(jpeg|png|jpg)/).nil?
    end
end
