class Api::V1::FootPrintSerializer < ActiveModel::Serializer
	attributes :id,
             :user,
             :created_at,
             :updated_at

      has_one :user, serializer: Api::V1::UserSerializer

      def created_at
            object.created_at.to_i
      end

      def updated_at
            object.updated_at.to_i
      end

      def user
            User.find(object.user_id)
      end
end
