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

class Place < ApplicationRecord
  has_many :events

  validates :address, presence: true
  validates :title, presence: true

  def full_address
    [address, title].compact.reject(&:empty?).join(", ")
  end
end
