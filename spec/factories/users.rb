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

FactoryBot.define do
  factory :user, aliases: [:organizer] do
    email { Faker::Internet.email }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    fresh false

    trait :admin do
      role :admin
    end

    trait :moderator do
      role :moderator
    end

    trait :oauth_user do
      name { Faker::Name.name }
      authentications { build_list :authentication, 1 }
    end

    trait :with_reset_password_token do
      reset_password_token { Sorcery::Model::TemporaryToken.generate_random_token }
    end
  end
end
