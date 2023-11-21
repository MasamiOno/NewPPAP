class ApplicationController < ActionController::Base
    before_action :authenticate_user!,:except=>[:show,:index,:roomsearch,:instruction,:generate,:ezrt_privacy_policy,:ezkj,:ezkj_privacy_policy,:cbpb,:cbpb_privacy_policy,:jbpb,:jbpb_privacy_policy,:ggpb,:ggpb_privacy_policy,:bpbc,:bpbc_privacy_policy,:bpgr,:bpgr_privacy_policy,:asop,:asop_privacy_policy,:etpm,:etpm_privacy_policy,:mcpb,:mcpb_privacy_policy,:sgpb,:sgpb_privacy_policy,:pbct,:pbct_privacy_policy,:jbct,:jbct_privacy_policy,:hcpc,:hcpc_privacy_policy,:bbsd,:bbsd_privacy_policy]

    #before_action :configure_permitted_parameters, if: :devise_controller?

    protected


    def configure_permitted_parameters
        added_attrs = [:name, :email, :password, :password_confirmation, :remember_me]

        devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
        devise_parameter_sanitizer.permit :account_update, keys: added_attrs
    end
end
