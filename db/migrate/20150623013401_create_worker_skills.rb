class CreateWorkerSkills < ActiveRecord::Migration
  def change
    create_table :worker_skills do |t|
      t.string :skill_name

      t.timestamps
    end
  end
end
