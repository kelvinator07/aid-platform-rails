require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_many(:requests).dependent(:destroy) }
  # Validation tests
  it { should validate_presence_of(:firstname) }
  it { should validate_presence_of(:lastname) }
  it { should validate_presence_of(:password) }
  it { should validate_uniqueness_of(:email) }
  it { should validate_presence_of(:picture) }
end
