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
require 'rails_helper'

RSpec.describe User do
  describe '#valid?' do
    it 'is valid with valid attributes' do
      expect(build(:user)).to be_valid
    end

    it 'is invalid without a first_name' do
      expect(build(:user, first_name: nil)).to be_invalid
    end

    it 'is invalid without a last_name' do
      expect(build(:user, last_name: nil)).to be_invalid
    end

    it 'is invalid without an email' do
      expect(build(:user, email: nil)).to be_invalid
    end

    it 'is invalid without an okta_user_name' do
      expect(build(:user, okta_user_name: nil)).to be_invalid
    end

    it 'is invalid with a duplicate okta_user_name' do
      user = create(:user)
      expect(build(:user, okta_user_name: user.okta_user_name)).to be_invalid
    end
  end
end
