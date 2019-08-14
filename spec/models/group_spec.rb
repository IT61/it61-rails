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

RSpec.describe Group, type: :model do
  it "has a valid factory" do
    expect(build(:group)).to be_valid
  end
end
