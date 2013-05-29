class ApplicationController < ActionController::Base
    protect_from_forgery
    
    # force_ssl

    include SessionsHelper
    
    # Force signout to prevent CSRF attacks
    def handle_unverified_request
        sign_out
        super
    end

end
