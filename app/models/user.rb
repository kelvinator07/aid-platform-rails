class User < ApplicationRecord
    include Rails.application.routes.url_helpers
    has_many :requests, dependent: :destroy

    has_secure_password
    has_one_attached :picture

    validates :firstname, :lastname, :password, :picture, presence: true

    validates :email, presence: true, uniqueness: true

    # validates :picture, {
    #     presence: true
    # }
      
end
