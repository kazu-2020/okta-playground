# frozen_string_literal: true

# sample file https://github.com/RIPAGlobal/scimitar/blob/main/config/initializers/scimitar.rb
Rails.application.config.to_prepare do # (required for >= Rails 7 / Zeitwerk)
  Scimitar.service_provider_configuration =
    Scimitar::ServiceProviderConfiguration.new(
      {
        # See https://tools.ietf.org/html/rfc7643#section-8.5 for properties.
        #
        # See Gem file 'app/models/scimitar/service_provider_configuration.rb'
        # for defaults. Define Hash keys here that override defaults; e.g. to
        # declare that filters are not supported so that calling clients shouldn't
        # use them:
        #
        #   filter: Scimitar::Supported.unsupported
      }
    )
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
