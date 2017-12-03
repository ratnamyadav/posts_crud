class Post < ApplicationRecord
  validates_presence_of :title, :description, :created_by
end
