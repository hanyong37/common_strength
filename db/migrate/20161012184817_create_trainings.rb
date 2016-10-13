class CreateTrainings < ActiveRecord::Migration[5.0]
  def change
    create_table :trainings do |t|
      t.integer   :user_id
      t.integer   :schedule_id
      t.integer   :training_status
      t.integer   :booking_status

      t.timestamps
    end
  end
end
