class Dashboard::WelcomeController < Dashboard::DashboardController

  def index
    @puppies = Puppy.enabled
  end
end
