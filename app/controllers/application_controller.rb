class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :serch_items
  before_action :login_user_admin_kind

  before_action :configure_permitted_parameters, if: :devise_controller?#StrongParameterをbeforeactionする


  def serch_items
    @q = Item.search(params[:q])
    @items = @q.result(distinct: true) || Item.all
  end

  def login_user_admin_kind
    @add_class
    if admin_signed_in?
      @add_class = "applicaion-admins"
    else
      @add_class = "applicaion-users"
    end
  end


  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up,keys:[
      :firstname,
      :lastname,
      :kana_firstname,
      :kana_lastname,
      :postal_code,
      :address,
      :address2,
      :phone,
      :active])
    devise_parameter_sanitizer.permit(:account_update,keys:[
      :firstname,
      :lastname,
      :kana_firstname,
      :kana_lastname,
      :postal_code,
      :address,
      :address2,
      :phone,
      :active])
  end
end
