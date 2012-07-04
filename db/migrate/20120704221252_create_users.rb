require 'declarative_authorization/maintenance'


class CreateUsers < ActiveRecord::Migration

  def self.up

    create_table :users do |t|
      t.string      :role,                  :null => false, :default => 'admin'
      t.string      :email,                 :null => false
      t.string      :crypted_password,      :null => false
      t.string      :password_salt,         :null => false
      t.string      :persistence_token,     :null => false
      t.integer     :login_count,           :null => false, :default => 0
      t.integer     :failed_login_count,    :null => false, :default => 0
      t.integer     :login_attempts_count,  :null => false, :default => 0
      t.datetime    :last_request_at
      t.datetime    :current_login_at
      t.datetime    :last_login_at
      t.string      :current_login_ip
      t.string      :last_login_ip
      t.timestamps
    end

    add_index :users, :last_request_at
    add_index :users, :email,             :unique => true
    add_index :users, :persistence_token, :unique => true


    Authorization::Maintenance::without_access_control do
      %w( one two ).each do |name|
        admin = User.new
        admin.password              = 'qweqwe'
        admin.password_confirmation = 'qweqwe'
        admin.email                 = "#{name}@example.com"
        admin.role                  = 'admin'
        admin.save!
      end
    end

  end

  def self.down
    drop_table :users
  end

end