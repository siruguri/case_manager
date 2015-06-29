class CreateSkillClaims < ActiveRecord::Migration
  def change
    create_table :skill_claims do |t|
      t.integer :user_id
      t.integer :worker_skill_id
      
      t.timestamps
    end
  end
end
