# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :email, null: false
      t.string :okta_user_name, null: false, index: { unique: true }, comment: 'Okta上で一意なユーザー名'
      t.boolean :active, null: false, default: false, comment: 'Okta上で有効かどうか'

      t.timestamps
    end
  end
end
