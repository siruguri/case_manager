class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :role
  belongs_to :manager, class_name: 'User'

  def is_admin?
    self.admin
  end

  def has_role(sym)
    self.role.name.to_sym == sym
  end

end
