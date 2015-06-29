class WorkerSkill < ActiveRecord::Base
  has_many :skill_claims
  has_many :users, through: :skill_claims
end
