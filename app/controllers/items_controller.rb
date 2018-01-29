class ItemsController < ApplicationController
  before_action :authenticate_admin!, except:[:index,:show]

  def index
    @q = Item.search(params[:q])
    @items = @q.result(distinct: true) || Item.all
    # Rails.logger.info(@items.first.category_id)
  end

  def new
  	@item = Item.new
    2.times do
      @disc = @item.discs.build
      10.times do
        @disc.songs.build
      end
    end
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
            discs_attributes: [
              :id,
              :disc_name,
              songs_attributes: [
                :id,
                :number,
                :song_name
              ]
            ]
          )
        #Rails.logger.info(params[:item][:discs_attributes].count)
    end
end
