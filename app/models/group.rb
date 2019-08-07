# == Schema Information
#
# Table name: groups
#
#  id         :bigint           not null, primary key
#  kind       :integer          default("general"), not null
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_groups_on_name  (name)
#

class Group < ApplicationRecord
  has_and_belongs_to_many :users

  validates :name, presence: true, uniqueness: true

  enum kind: {
    general: 0,
    developers: 1,
    organizers: 2,
  }
end
