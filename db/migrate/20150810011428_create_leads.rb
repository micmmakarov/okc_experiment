class CreateLeads < ActiveRecord::Migration
  def change
    create_table :leads do |t|
      t.string :name
      t.datetime :approached_at
      t.string :group

      t.timestamps null: false
    end
  end
end
