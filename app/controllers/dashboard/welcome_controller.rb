class Dashboard::WelcomeController < DashboardController

  def index
    @puppies = Puppy.all
  end
end
