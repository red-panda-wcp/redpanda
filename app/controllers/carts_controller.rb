class CartsController < ApplicationController
  def index
    @carts = Cart.all
    @history_address = HistoryAddress.new

    @total_price = 0#合計金額を表示するための記述
      @carts.each do |cart|
      if current_user.id == cart.user_id
         @total_price += cart.item.price*cart.count
      end
    end
  end

  def create#カートインデックスに商品追加
    @cart = Cart.new(cart_params)
    @cart.user_id = current_user.id
    if Cart.find_by(item_id: @cart.item_id,user_id:current_user.id)
       redirect_to carts_path, flash: {n: "この商品は既にカートに入っています"}
    else
      @cart.save
      redirect_to carts_path
    end
  end

  def update#個数変更メソッド
    @cart = Cart.find(params[:id])
    @cart.update(cart_params)
    redirect_to carts_path
  end

  def destroy#カート内商品削除
    @cart = Cart.find(params[:id])
    @cart.destroy
    redirect_to carts_path
  end

  private

  def cart_params
    params.require(:cart).permit(:user_id, :item_id, :count)
  end
end