class ApplicationController < ActionController::Base
  # метод будет виден во всех вьюхах
  helper_method :current_user

  private
  #дергая метод получаем ссылку на пользователя который в данный момент залогинен на сайте
  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def reject_user
    redirect_to root_path, alert: 'Сюда нельзя.'
  end
end
