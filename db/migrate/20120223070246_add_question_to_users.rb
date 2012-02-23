class AddQuestionToUsers < ActiveRecord::Migration
  def change
    add_column :users, :question, :string, :default => "type 12345"

    add_column :users, :answer, :string, :default => "12345"

  end
end
