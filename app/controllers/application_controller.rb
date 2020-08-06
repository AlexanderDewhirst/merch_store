class ApplicationController < ActionController::Base

    module CurrentUser
        def self.included(base)
          base.send :helper_method, :current_user
        end
    end

end
