# == Schema Information
#
# Table name: events_attendees
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  event_id   :integer          not null
#  user_id    :integer          not null
#
# Indexes
#
#  index_events_attendees_on_event_id              (event_id)
#  index_events_attendees_on_user_id               (user_id)
#  index_events_attendees_on_user_id_and_event_id  (user_id,event_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (event_id => events.id)
#  fk_rails_...  (user_id => users.id)
#

class EventsAttendee < ApplicationRecord
  belongs_to :event
  belongs_to :attendee, class_name: "User", foreign_key: :user_id
end
