class Ability
  include CanCan::Ability
    
    
  
  def initialize(user)
    user ||= User.new  #guest user
    
    
    can :read, :books
    can :access, :info
    cannot :create, :feedback_messages
    can [:read, :create, :login, :unsubscribe], :users
    
    
    if user.role == 'admin'
      #can :create, :books
      #can :update, :books
      
      can :create, :all
      can :destroy, :all
      can :update, :all
    elsif user.role =='user'
      can :create, :comments
      can [:update ,:destroy], :comments do |comment|
        comment.user.id == user.id
      end 
    end
    
  end
  
  
  
  
  
  
  

  # def initialize(user)
    # user ||= User.new #guest users
#     
    # can :show, @book
#     
    # if user.role == 'admin'
         # can :manage, :all
    # else
      # can :logout, :users
      # can :update, :users, :id => user.id
#       
      # can :create, Comment
      # can :update, :comment do |comment|
        # comment.user_id == user.id     
    # end
#     
    # # can :read, :book, ["published_at <= ?", Time.zone.now] do |book|
      # # book.published_at <= Time.now.utc
    # # end
    # # can :access, :info
    # # can :create, :feedback_messages
    # # can [:read, :create, :login, :unsubscribe], :users
# 
    # if user
#       
        # end
        # # can [:update, :destroy], :comments do |comment|
          # # comment.user_id == user.id
#        
      # end
# 
      # # if user.moderator?
        # # can :read, :episodes
        # # can :update, :episodes, :notes
        # # can [:update, :destroy, :index], :comments
        # # can :ban, :users
        # # can :revert, :versions
      # # end
# 
#        
    # #end
  # end
end
