class SkillClaim < ActiveRecord::Base
  belongs_to :user
  belongs_to :worker_skill
end
