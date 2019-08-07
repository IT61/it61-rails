# == Schema Information
#
# Table name: events
#
#  id                            :bigint           not null, primary key
#  attendees_limit               :integer          default(-1), not null
#  broadcast_url                 :string
#  cover                         :string
#  description                   :text             not null
#  has_attendees_limit           :boolean          default(FALSE), not null
#  has_closed_registration       :boolean          default(FALSE)
#  link                          :string
#  published                     :boolean          default(FALSE)
#  published_at                  :datetime
#  started_at                    :datetime
#  subscribers_notification_send :boolean          default(FALSE)
#  title                         :string           not null
#  created_at                    :datetime         not null
#  updated_at                    :datetime         not null
#  organizer_id                  :integer          not null
#  place_id                      :integer
#
# Indexes
#
#  index_events_on_organizer_id  (organizer_id)
#  index_events_on_place_id      (place_id)
#
# Foreign Keys
#
#  fk_rails_...  (place_id => places.id)
#

RSpec.describe Event, type: :model do
  it "has a valid factory" do
    expect(build(:event)).to be_valid
  end

  let! (:event) { create(:event) }
  subject { event }

  describe "ActiveModel validations" do
    it { expect(event).to validate_presence_of(:title) }
    it { expect(event).to validate_presence_of(:description) }
  end

  describe "ActiveRecord associations" do
    it { expect(event).to belong_to(:organizer).class_name("User") }
    it { expect(event).to belong_to(:place) }
    it { expect(event).to have_many(:attendees).class_name("User") }
  end

  context "callbacks" do
    let(:event) { create(:event) }
  end
end
