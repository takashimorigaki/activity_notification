class CreateTestTables < ActiveRecord::Migration
  def change
    create_table :users do |t|
      # Devise
      ## Database authenticatable
      t.string :email,              null: false, default: "", index: true, unique: true
      t.string :encrypted_password, null: false, default: ""

      ## Confirmable
      t.string   :confirmation_token
      t.datetime :confirmed_at
      t.datetime :confirmation_sent_at

      # Apps
      t.string   :name

      t.timestamps
    end

    create_table :articles do |t|
      t.references :user, index: true
      t.string     :title
      t.string     :body

      t.timestamps
    end

    create_table :comments do |t|
      t.references :user,    index: true
      t.references :article, index: true
      t.string     :body

      t.timestamps
    end
  end
end
