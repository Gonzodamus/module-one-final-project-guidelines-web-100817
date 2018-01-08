class CreateInspectionViolation < ActiveRecord::Migration[4.2]

  def change
    create_table :inspection_violations do |t|
      t.integer :inspection_id
      t.integer :violation_id
    end
  end
end
