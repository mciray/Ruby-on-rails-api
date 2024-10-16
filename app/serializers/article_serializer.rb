class ArticleSerializer < ActiveModel::Serializer
  attributes :id, :title, :body, :created_at, :updated_at
  belongs_to :user

  class UserSerializer < ActiveModel::Serializer
    attributes :id, :email, :created_at
  end
end
