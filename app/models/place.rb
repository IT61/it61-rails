class Place < ApplicationRecord
  has_many :events

  validates :address, presence: true

  def full_address
    [address, title].compact.reject(&:empty?).join(', ')
  end
end
