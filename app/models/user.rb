class User < ActiveRecord::Base

  using_access_control

  acts_as_authentic

  def role_symbols
    role.present? ? [role.to_sym] : []
  end

end