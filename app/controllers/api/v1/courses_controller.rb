module Api
  module V1
    class CoursesController < BaseController
      private

      def new_resource
        @new_resource ||= Course.new(new_params)
      end

      def new_params
        @new_params ||= params.require(:course).permit(:name, tutors_attributes: [:name])
      end

      def includes
        @includes ||= [:tutors]
      end

      def resources
        @resources ||= Course.includes(:tutors).all
      end
    end
  end
end
