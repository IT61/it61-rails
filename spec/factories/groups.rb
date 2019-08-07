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

FactoryBot.define do
  factory :group do
    name { Faker::Company.name }
  end
end
