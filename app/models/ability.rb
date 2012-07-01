class Ability
  include CanCan::Ability

  def initialize(user)
    if user
      if user.api_ro_user?
        can :read, :all
      else
        can :manage, :all
      end
    end
  end
end
