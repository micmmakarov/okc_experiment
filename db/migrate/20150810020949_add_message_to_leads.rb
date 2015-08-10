class AddMessageToLeads < ActiveRecord::Migration
  def change
    add_column :leads, :message, :message
  end
end
