# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                                       :bigint           not null, primary key
#  active(Okta上で有効かどうか)             :boolean          default(FALSE), not null
#  email                                    :string           not null
#  first_name                               :string           not null
#  last_name                                :string           not null
#  okta_user_name(Okta上で一意なユーザー名) :string           not null
#  created_at                               :datetime         not null
#  updated_at                               :datetime         not null
#
# Indexes
#
#  index_users_on_okta_user_name  (okta_user_name) UNIQUE
#
FactoryBot.define do
  factory :user do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { Faker::Internet.email }
    okta_user_name { Faker::Alphanumeric.unique.alpha(number: 10) }
  end
end
