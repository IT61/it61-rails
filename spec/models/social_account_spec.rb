# == Schema Information
#
# Table name: social_accounts
#
#  id         :bigint           not null, primary key
#  link       :string
#  provider   :string           not null
#  uid        :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#
# Indexes
#
#  index_social_accounts_on_user_id  (user_id)
#

RSpec.describe SocialAccount, type: :model do

  describe "public class methods" do
    context "responds to its methods" do
      it { expect(SocialAccount).to respond_to(:link_for) }
    end
  end

end
