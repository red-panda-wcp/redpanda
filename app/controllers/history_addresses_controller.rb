class HistoryAddressesController < ApplicationController
  def create

    if Cart.where(user_id:current_user.id).presence == nil#カートに何も入っていない場合の処理
      redirect_to carts_path

    else# 履歴へカートの情報を登録　ここから
      @carts = Cart.where(user_id:current_user.id)
      @history_address = HistoryAddress.create(history_address_params)

      @carts.each do |cart|
        @history = History.new(cart.attributes)#カート内user_id,item_id,countを登録
        @history.price = cart.item.price#priceセット
        @history.history_address_id = @history_address.id#address_idセット

        if (@history.count != 0 && cart.item.active == "display" ) && (cart.item.stock >= @history.count)#商品の個数変更　もし在庫がカート内の個数よりも多ければ
          cart.item.stock -= @history.count
          if @history.save#履歴保存に成功した場合カートアイテムの更新
            cart.item.save
            flash[:notice]= "ご購入ありがとうございます。発送までしばらくお待ち下さい。"
          else#履歴保存に失敗した場合、アラートを出す
            flash["alert #{cart.id}"] = "「#{@history.item.item_name}」 #{@history.item.artist_name} :購入できませんでした。"
          end
        elsif @history.count == 0
          flash["alert #{cart.id}"] = "「#{@history.item.item_name}」 #{@history.item.artist_name} :購入数が 0 のため、購入しませんでした。"
        elsif cart.item.active != "display"
          flash["alert #{cart.id}"] = "「#{@history.item.item_name}」 #{@history.item.artist_name} :購入停止中の商品のため、購入できませんでした。"
        else
          flash["alert #{cart.id}"] = "「#{@history.item.item_name}」 #{@history.item.artist_name} :購入できませんでした。ご確認ください。"
        end
      end# 履歴へカートの情報を登録　ここまで

    @carts.destroy_all#カート内削除
    redirect_to users_path
  end


  end

  private

  def history_address_params
    params.require(:history_address).permit(:postal_code,:address,:address2,:lastname,:firstname,
                                      :kana_lastname,:kana_firstname,:phone,:phone2,:phone3,history_attributes:[
                                        :user_id,:item_id,:count,:order_status,:price,:history_address_id])
  end

end