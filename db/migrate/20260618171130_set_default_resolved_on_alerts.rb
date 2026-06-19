class SetDefaultResolvedOnAlerts < ActiveRecord::Migration[8.1]
  def change
    change_column_default :alerts, :resolved, false
  end
end
