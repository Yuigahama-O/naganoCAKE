class ApplicationController < ActionController::Base
before_action :configure_permitted_parameters, if: :devise_controller?


    private

      def after_sign_out_path_for(resource)
        root_path
      end

      protected
    
      def configure_permitted_parameters
         devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :first_name, :last_name, :first_name_kana, :last_name_kana, :postal_code, :address, :phone_number] )
      end

      # 会員の論理削除のための記述。退会後は、同じアカウントでは利用できない。
     
      
end
