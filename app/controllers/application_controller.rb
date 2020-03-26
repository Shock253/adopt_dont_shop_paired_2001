class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :favorite_pets

  def favorite_pets
    @favorite_pets ||= FavoritePets.new(session[:favorites])
  end
end
