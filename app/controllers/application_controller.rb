class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :serch_items

  def serch_items
    @q = Item.search(params[:q])
    @items = @q.result(distinct: true) || Item.all
  end
end
