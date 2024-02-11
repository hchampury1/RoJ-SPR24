# Team 12 
# Modified on 4/27/23

class WebinarRegistrationHomeController < ApplicationController
    def index
    
    end

    def new 
        @webinar_form = WebinarForm.new
        render :new
    end

    def create
        @webinar_form = WebinarForm.new(params.require(:webinar_form.permit(:firstName, :lastName, :email, :occupation, :wantsCredit, :paid)))
        if @webinar_form.save
            flash[:success] = "Webinarform submitted. Registration successful!"
            redirect_to webinar_registration_home/index
        else 
            flash.now[:error] = "Webinar Form Registration failed"
            render :new
        end
    end
end
