require 'rails_helper'

# Test suite for the Request model
RSpec.describe Request, type: :model do
  # Association test
  # ensure Request model has a 1:m relationship with the Message model
  it { should have_many(:messages) }
  # Validation tests
  it { should validate_presence_of(:description) }
  it { should validate_presence_of(:request_type) }
  it { should validate_presence_of(:lat) }
  it { should validate_presence_of(:lng) }
end