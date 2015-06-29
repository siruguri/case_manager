class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    user ||= User.new # guest user (not logged in)

    if user.id
      if user.admin?
        can :manage, :all
      else
        # Users can see their own profiles
        can :manage, User, {id: user.id}
        can :read, NavbarEntry, {user_id: user.id}
        
        can :run_api_command, ApiAction do |action|
          Role.supersedes(user.role, action.role)
        end
        
        if user.has_role?(:manager)
          can :manage, AppointmentRequest
          can :manage, Client, {case_contact_id: user.volunteers.map { |vol| vol.id }}
          can :manage, User, {manager: user}
          can :access, :rails_admin   # grant access to rails_admin
          can :dashboard  

        end
        if user.has_role?(:volunteer)
          can :read, AppointmentRequest, {volunteer: user}
          can :create, FormEntry
          can :manage, Client, {case_contact_id: user.id}
          can [:read, :update], FormEntry do |fe|
            fe.form_author.id == user.id
          end
        end
      end
    end
    
    # The first argument to `can` is the action you are giving the user 
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. 
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/ryanb/cancan/wiki/Defining-Abilities
  end
end
