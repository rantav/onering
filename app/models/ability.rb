class Ability
  include CanCan::Ability

  def initialize(user)
    if user
      if user.can_write
        can :manage, :all
      else
        can :read, :all
      end
    end
  end
end
