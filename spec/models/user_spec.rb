# == Schema Information
#
# Table name: users
#
#  id                        :bigint           not null, primary key
#  avatar                    :string
#  bio                       :text
#  current_sign_in_at        :datetime
#  current_sign_in_ip        :inet
#  email                     :string           default("")
#  email_reminders           :boolean          not null
#  first_name                :string
#  fresh                     :boolean          default(TRUE), not null
#  google_refresh_token      :string
#  is_social_profiles_hidden :boolean          default(FALSE), not null
#  last_name                 :string
#  last_sign_in_at           :datetime
#  last_sign_in_ip           :inet
#  migration_token           :string
#  name                      :string
#  normalized_phone          :string
#  phone                     :string
#  remember_created_at       :datetime
#  remember_token            :string
#  role                      :integer          default("member"), not null
#  sign_in_count             :integer          default(0), not null
#  sms_reminders             :boolean          not null
#  subscribed                :boolean          not null
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#
# Indexes
#
#  index_users_on_email_reminders  (email_reminders)
#  index_users_on_name             (name)
#  index_users_on_sms_reminders    (sms_reminders)
#  index_users_on_subscribed       (subscribed)
#

RSpec.describe User, type: :model do
  it "has a valid factory" do
    expect(build(:user)).to be_valid
  end

  let! (:user) { create(:user) }
  subject { user }

  describe "ActiveModel validations" do
    it { expect(user).to validate_presence_of(:role) }

    before { subject.sms_reminders = true }
    it { expect(user).to validate_presence_of(:phone) }

    before { subject.email_reminders = true }
    it { expect(user.role).to eq("member") }
  end

  context "callbacks" do
    let(:user) { create(:user) }

    it { expect(user).to callback(:assign_defaults).before(:create) }
  end

  describe "public instance methods" do
    context "responds to its methods" do
      it { expect(user).to respond_to(:full_name) }
      it { expect(user).to respond_to(:name) }
      it { expect(user).to respond_to(:remember_me) }
      it { expect(user).to respond_to(:events_attendees) }
      it { expect(user).to respond_to(:subscribe!) }
      it { expect(user).to respond_to(:has_events?) }
    end

    context "executes methods correctly" do
      context "full_name" do
        it "returns space-separated first name and last name" do
          expected_value = user.first_name + " " + user.last_name
          expect(user.full_name).to eq(expected_value)
        end

        context "partial" do
          let!(:name_expected_value) { user.name }

          before { subject.first_name = nil }
          it "returns name if first name is empty" do
            expect(user.full_name).to eq(name_expected_value)
          end

          before { subject.last_name = nil }
          it "returns name if last name is empty" do
            expect(user.full_name).to eq(name_expected_value)
          end

          it "returns only name if first name and last name are empty" do
            expect(user.full_name).to eq(name_expected_value)
          end
        end
      end
    end
  end

  describe "abilities" do
    subject(:ability) { Ability.new(user) }
    let!(:user) { nil }
    let!(:event) { create(:event) }
    let!(:published_event) { create(:event, :published) }

    context "when is an unauthorized user" do
      it { should have_abilities(:read, User.new) }
      it { should have_abilities(:read, published_event) }
      it { should have_abilities(:upcoming, Event) }
      it { should have_abilities(:past, Event) }

      it { should_not have_abilities([:edit, :update, :destroy], user) }
      it { should_not have_abilities([:edit, :update, :destroy], event) }
      it { should_not have_abilities([:edit, :update, :destroy], published_event) }
      it { should_not have_abilities([:read], event) }
    end

    context "when is an authorized user" do
      let! (:user) { create(:user) }
      it { should have_abilities(:read, User.new) }
      # manage himself
      it { should have_abilities([:edit, :update, :destroy], user) }
      it { should have_abilities([:attend, :leave], published_event) }

      it { should_not have_abilities([:read, :edit, :update, :destroy], event) }
      it { should_not have_abilities([:attend, :leave], event) }
    end

    context "when is a moderator" do
      let! (:user) { create(:user, :moderator) }
      it { should have_abilities(:read, User.new) }
      it { should have_abilities(:read, event) }
      it { should have_abilities(:manage, event) }

      it { should_not have_abilities(:destroy, User) }
      it { should_not have_abilities(:destroy, Place) }
    end

    context "when is an administrator" do
      let! (:user) { create(:user, :admin) }
      it { should have_abilities(:manage, event) }
      it { should have_abilities(:manage, published_event) }
      it { should have_abilities(:manage, User) }
    end

    context "when is an organizer" do
      let!(:user) { create(:user) }
      let!(:event) { create(:event, organizer: user) }

      it { should have_abilities([:read, :edit, :update, :destroy], event) }

      it { should_not have_abilities(:publish, event) }
    end
  end
end
