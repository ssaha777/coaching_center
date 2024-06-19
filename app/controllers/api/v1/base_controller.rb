module Api
  module V1
    class BaseController < ApplicationController
      rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
      rescue_from ActionController::ParameterMissing, with: :missing_parameter

      def index
        render_success(:ok, { body: resources })
      end

      def create
        if new_resource.save
          render_success(:created, { body: new_resource })
        else
          render_errors(:unprocessable_entity, new_resource.errors)
        end
      end

      def render_errors(status, errors = [])
        render(json: {
                 success: false,
                 errors: errors
               }, status: status)
      end

      def render_success(status, resource = {})
        render(json: resource, each_serializer: serializer_class, status: status, include: includes)
      end

      private

      # these method need to be overridden
      def new_resource; end
      def resources; end

      def model_class
        @model_class ||= controller_name.classify.constantize
      end

      # Returns the serializer class associated with the controller.
      def serializer_class
        @serializer_class ||= "#{model_class}Serializer".constantize
      end

      def record_not_found(error)
        render_errors(:not_found, error.message)
      end

      def missing_parameter(error)
        render_errors(:unprocessable_entity, error.message)
      end
    end
  end
end
