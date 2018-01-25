class ItemsController < ApplicationController

  def index
    @q = Item.search(params[:q])
    # @items = @q.result(distinct: true)
    @items = Item.all
    # Rails.logger.info(@items.first.category_id)
  end

  def new
  	@item = Item.new
    @disc = @item.discs.build
    5.times{@disc.songs.build}

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
