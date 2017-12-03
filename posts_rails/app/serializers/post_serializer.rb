class PostSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :created_by, :created_at, :updated_at

  def created_at
    object.created_at.strftime('%d %b %Y %I:%M %p')
  end

  def updated_at
    object.updated_at.strftime('%d %b %Y %I:%M %p')
  end
end
