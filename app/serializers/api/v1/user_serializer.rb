class Api::V1::UserSerializer < ActiveModel::Serializer
	attributes :id,
             :name,
             :icon,
             :gender,
             :height,
             :figure,
             :work,
             :income,
             :debt,
             :hobby,
             :body,
             :birthday,
             :divorced_number,
             :children,
             :last_merried_start_time,
             :last_merried_last_time,
             :remarried_desired_time,
             :divorced_reason,
             :what_learned_from_divorce,
             :adress,
             :age,
             :final_education,
             :message_for_opponent,
             :is_facebook_connected,
             :last_login_at,
             :is_sms_verified,
             :firebase_token,
             :favorite_count,
             :is_favorite,
             :favorite_count,
             :is_mutual_friend,
             :is_purchased,
             :created_at,
             :updated_at

      def is_favorite
            false
      end

      def favorite_count
            0
      end

      def is_mutual_friend
            false
      end

      def birthday
            object.birthday.to_i
      end

      def last_login_at
            object.last_login_at.to_i
      end

      def created_at
            object.created_at.to_i
      end

      def updated_at
            object.updated_at.to_i
      end

      def current_user
            scope[:current_user]
      end
end

