class UserSerializer < ActiveModel::Serializer
  attributes :id, :firstname, :lastname, :email, :lat, :lng
end
