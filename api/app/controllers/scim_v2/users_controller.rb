# frozen_string_literal: true

module ScimV2
  class UsersController < Scimitar::ResourcesController
    # Scimitar::AppicationController で定義されている
    rescue_from ActiveRecord::RecordNotFound, with: :handle_resource_not_found

    def index
      pagination_info = scim_pagination_info(query.count)
      page_of_results =
        query.offset(pagination_info.offset).limit(pagination_info.limit).to_a

      super(pagination_info, page_of_results) do |record|
        record.to_scim(location: url_for(action: :show, id: record.id))
      end
    end

    def show
      super do |user_id|
        user = storage_class.find(user_id)
        user.to_scim(location: url_for(action: :show, id: user_id))
      end
    end

    def create
      super do |scim_resource|
        user = storage_class.new
        user.save_from_scim!(scim_resource)

        user.to_scim(location: url_for(action: :show, id: user.id))
      end
    end

    private

    def query
      @query ||= if params[:filter].present?
                   parser = ::Scimitar::Lists::QueryParser.new(storage_class.new.scim_queryable_attributes)
                   parsed_query = parser.parse(params[:filter])
                   parsed_query.to_activerecord_query(storage_class.all)
                 else
                   storage_class.all
                 end
    end

    def storage_class
      User
    end
  end
end
