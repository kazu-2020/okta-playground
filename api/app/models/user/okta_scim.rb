# frozen_string_literal: true

# okta用の scimitar に関する設定
# https://github.com/RIPAGlobal/scimitar/blob/fe43f9f2cbf157d2b16732fc52cd8341fe1aefd2/app/models/scimitar/resources/mixin.rb
module User::OktaScim
  extend ActiveSupport::Concern

  included { include Scimitar::Resources::Mixin }

  module ClassMethods
    def scim_resource_type
      Scimitar::Resources::User
    end

    def scim_attributes_map
      {
        id: :id,
        userName: :okta_user_name,
        name: {
          givenName: :first_name,
          familyName: :last_name
        },
        emails: [
          {
            match: 'primary',
            with: true,
            using: {
              value: :email,
              primary: true
            }
          }
        ],
        active: :active
      }
    end

    def scim_mutable_attributes; end

    def scim_queryable_attributes
      { 'userName' => { column: :okta_user_name } }
    end

    def scim_timestamps_map
      { created: :created_at, lastModified: :updated_at }
    end
  end

  def save_from_scim!(scim_resource)
    ActiveRecord::Base.transaction do
      from_scim!(scim_hash: scim_resource.as_json)
      save!
    end
  rescue ActiveRecord::RecordInvalid
    raise Scimitar::ErrorResponse.new(status: 409, detail: 'User already exists in the database.' )
  end
end
