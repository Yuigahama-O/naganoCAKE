class ApplicationController < ActionController::Base


    private
    
      def after_sign_in_path_for(resource)
        public_customer_path(current_customer)
      end
    
      def after_sign_out_path_for(resource)
        root_path
      end
    
      def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys: [:email , :first_name,:last_name,:first_name_kana,:last_name_kana,:postal_code,:address,:phone_number] )
      end
end
