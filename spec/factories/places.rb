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

FactoryBot.define do
  factory :place do
    title { Faker::Address.street_name }
    address { Faker::Address.street_address }
    latitude { Faker::Address.latitude }
    longitude { Faker::Address.longitude }
  end
end
