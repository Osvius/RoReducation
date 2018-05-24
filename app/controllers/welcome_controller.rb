class WelcomeController < ApplicationController
  def index
    if user_signed_in?
      name = current_user.email
    else
      name = 'Guest'
    end
    @welcome = 'Helllo, %s' % [name]
  end
end