class ItemsController < ApplicationController
  before_action :authenticate_admin!, except:[:index,:show]

  def index
    @item = Item.where(active: 0)
    @q = @item.search(params[:q])
    @items = @q.result(distinct: true)

    @no_item = Item.where(active: 1)
    @no_q = @no_item.search(params[:q])
    @no_items = @no_q.result(distinct: true)
  end

  def new
    @item = Item.new
    @disc = @item.discs.build
    @song = @disc.songs.build
  end

  def create
  	@item = Item.new(item_params)
    if @item.save
    redirect_to ("/")
    else
      render ("items/new")
    end
  end

  def show
    @item = Item.find(params[:id])
    @cart = Cart.new
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    @disc = @item.discs
    @item.update(item_params)
    redirect_to ("/")
  end

  def destroy
    @item = Item.find(params[:id])
    if @item.delete
      flash[:notice] = "削除しました。"
      redirect_to("/items")
    end
  end

  private
    def item_params
        params.require(:item).permit(
          :artist_name,
          :item_name,
          :image,
          :price,
          :label_name,
          :stock,
          :category_id,
          :release_date,
          :active,
            discs_attributes: [
              :id,
              :disc_name,
              :_destroy,
              songs_attributes: [
                :id,
                :number,
                :song_name,
                :_destroy
              ]
            ]
          )
        #Rails.logger.info(params[:item][:discs_attributes].count)
    end
end
