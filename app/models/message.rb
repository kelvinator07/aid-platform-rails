class Message < ApplicationRecord
  belongs_to :request

  validates :body, :name, presence: true

end
