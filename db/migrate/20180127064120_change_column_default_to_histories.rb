class ChangeColumnDefaultToHistories < ActiveRecord::Migration[5.1]
  def change
    change_column_default :histories, :order_status, 0
  end
end
