class Request < ApplicationRecord
    belongs_to :user
    has_many :messages

    enum request_type: {
        one_time:                   'one_time',
        material_need:              'material_need'
    }

    validates :description, :request_type, :lat, :lng, presence: true

end
