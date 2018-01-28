class UsersController < ApplicationController
  def show
    @user = current_user

    # 履歴表示
    @histories_for_user = History.where(user_id:@user.id)
    @histories = History.where(user_id: @user.id).order("id desc") #ログインユーザーの履歴を一覧化
    @history_ids = @histories.pluck(:history_address_id).uniq #@historiesからhistory_address_idの一覧を取得して配列にする

    # 上記をベースにビュー側で行っている事まとめ
    #   変数
    #     histories 該当ユーザーの全履歴明細
    #     histroies_ids 該当ユーザーがこれまで使用した全配送住所（history_address_id）
    #     h_histories 同一配送先住所(history_address_id)ごとにまとめた履歴
    #     h_h_item 同一配送先住所（history_address_id)内のひとつひとつの履歴

    @total_price = 0 #合計金額初期化
  end

  def destroy
    @user = current_user
    @user.active = 1#activeカラムを1（削除済）にして、保存
    @user.email = "#{@user.last_sign_in_at.to_i.to_s}_#{@user.email.to_s}"
    if @user.save
      flash[:notice] = "ユーザーを削除しました。"
      signed_out = Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name)
    end
    redirect_to root_path#リダイレクト先の変更（deviseの初期値　User#index から rootへ変更
  end

end