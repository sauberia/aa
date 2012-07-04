authorization do

  role :admin do

    # has_permission_on :users, :to => :update

    # has_permission_on :users, :to => :read do
    #   if_attribute :id => is { user.id }
    # end

    has_permission_on :users, :to => [:update, :read] do
      if_attribute :id => is { user.id }
    end

  end

  role :guest do
    has_permission_on :users, :to => :update
  end

end