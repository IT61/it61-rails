# == Schema Information
#
# Table name: places
#
#  id         :bigint           not null, primary key
#  address    :string           not null
#  latitude   :float
#  longitude  :float
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_places_on_address                                       (address)
#  index_places_on_title                                         (title)
#  index_places_on_title_and_address_and_latitude_and_longitude  (title,address,latitude,longitude) UNIQUE
#

RSpec.describe Place, type: :model do
  it "has a valid factory" do
    expect(build(:place)).to be_valid
  end

  let! (:place) { create(:place) }
  subject { place }

  describe "ActiveModel validations" do
    it { expect(place).to validate_presence_of(:address) }
  end

  describe "public instance methods" do
    context "responds to its methods" do
      it { expect(place).to respond_to(:full_address) }
    end

    context "executes methods correctly" do
      context "full_address" do
        it "returns comma-separated address and title" do
          expected_value = place.address + ", " + place.title
          expect(place.full_address).to eq(expected_value)
        end
      end
    end
  end
end
