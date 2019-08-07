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

FactoryBot.define do
  factory :event do
    title { Faker::Esport.event }
    description { Faker::Lorem.paragraph }
    started_at { Faker::Date.forward }
    cover { Rack::Test::UploadedFile.new(File.join(Rails.root, "spec", "support", "files", "event_title_image.jpg")) }

    organizer
    place
  end

  trait :upcoming do
    started_at { Faker::Date.forward }
  end

  trait :past do
    started_at { Faker::Date.backward }
  end

  trait :published do
    published_at { Faker::Date.backward }
    published { true }
  end
end
