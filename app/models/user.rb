class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :role
  belongs_to :manager, class_name: 'User'
  has_many :volunteers, class_name: 'User', foreign_key: :manager_id
  has_many :clients, foreign_key: :case_contact_id

  belongs_to :employer, class_name: 'Organization'

  has_many :form_entries, foreign_key: :form_author_id
  has_many :user_actions

  def is_admin?
    self.admin
  end

  def has_role?(sym)
    # The admins have all roles.
    if sym.class==String
      sym = sym.to_sym
    end
    self.is_admin? or self.role.name.to_sym == sym
  end

  def display_name
    if self.first_name
      "#{self.first_name} #{self.last_name}"
    else
      self.last_name
    end
  end

  def is_current?
    # If actions are more recent than some number of days
    self.user_actions.each do |act|
      if act.created_at > Time.now - 1.day # TODO Need to add type of action here, and parametrize the time period
        return true
      end
    end

    return false
  end

  def last_action
    acts=self.user_actions
    acts.empty? ? "No action recorded!" : acts.last.created_at.to_time.strftime('%b %d, %Y (%H:%M)')
  end

  def last_sign_in
    if self.last_sign_in_at.nil?
      'N/A'
    else
      last_sign_in_at.to_time.strftime('%b %d, %Y (%H:%M)')
    end
  end
end
