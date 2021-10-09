class ApplicationController < ActionController::Base

    include SessionsHelper

    def get_all_developers
        @all_developers=User.where(role:'Developer')      
    end
    
    def get_all_QA
        @all_QA=User.where(role:'QA')
    end

end
