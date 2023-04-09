# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                                       :bigint           not null, primary key
#  email                                    :string           not null
#  first_name                               :string           not null
#  last_name                                :string           not null
#  okta_user_name(Okta上で一意なユーザー名)     :string           not null
#  created_at                               :datetime         not null
#  updated_at                               :datetime         not null
#
# Indexes
#
#  index_users_on_okta_user_name  (okta_user_name) UNIQUE
#
class User < ApplicationRecord
  include User::OktaScim

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true
  validates :okta_user_name, presence: true, uniqueness: true
end
