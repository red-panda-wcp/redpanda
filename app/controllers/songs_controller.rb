class SongsController < ApplicationController
  def new
  	@disc = Disc.new
  	@disc.songs.build
  end

  def create
  	@disc = Disc.new(item_params)
    @disc.save
    redirect_to ("/items")
  end

private
  def song_params
        params.require(:song).permit(:artist_name , :item_name, :image, :price, :label_name, :stock, :category_id, :release_date,discs_attributes:[:disc_name,songs_attributes:[:song_name,:number]])
  end
end
