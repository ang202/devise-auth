class AddUserToCourse < ActiveRecord::Migration[6.1]
  def change
    add_reference :courses, :user, type: :uuid, null: false, foreign_key: true
  end
end
