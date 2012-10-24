class AddVersionNumberToResponses < ActiveRecord::Migration
  def self.up
    add_column "responses","version_num",:integer,:default => nil

  end

  def self.down
    remove_column "responses","version_num"
  end
end
