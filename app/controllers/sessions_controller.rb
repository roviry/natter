class SessionsController < ApplicationController

    def new
    end

    def create
        # render 'new'
        user = User.find_by_email(params[:email].downcase)

        if user && user.authenticate(params[:password])
            # Log the user in and redirect to the user's show page.
            sign_in user
            redirect_back_or user
        else
            # Create and error message and re-render the log-in form.
            flash.now[:error] = 'Invalid email/password combination' #Not quite right!
            render 'new'
        end
    end

    def destroy
        sign_out
        redirect_to root_url
    end

end
