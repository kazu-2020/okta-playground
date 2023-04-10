# frozen_string_literal: true

# sample file https://github.com/RIPAGlobal/scimitar/blob/main/config/initializers/scimitar.rb
Rails.application.config.to_prepare do # (required for >= Rails 7 / Zeitwerk)
  Scimitar.engine_configuration =
    Scimitar::EngineConfiguration.new(
      {
        application_controller_mixin:
          Module.new do
            def self.included(base)
              base.class_eval { skip_before_action :verify_authenticity_token }
            end
          end,
        token_authenticator:
          proc do |token, _options|
            Rack::Utils.secure_compare(
              token,
              Rails.application.credentials.dig(:okta, :scim)
            )
          end
      }
    )
end
