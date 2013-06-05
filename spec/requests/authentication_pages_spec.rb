require 'spec_helper'

describe "AuthenticationPages" do

    subject { page }

    describe "sign in page" do
        before { visit signin_path }

        it { should have_selector('h1', text: 'Log-in') }
        it { should have_selector('title', text: 'Log-in') }
        it { should_not have_link('Settings') }
    end

    describe "Log-in" do
        before { visit signin_path }

        describe "with invalid information" do
            before { click_button "Log-in" }

            it { should have_selector('title', text: 'Log-in') }
            it { should have_error_message('Invalid') }

            describe "after visiting another page" do
                before { click_link "Home" }

                it {should_not have_selector('div.alert.alert-error') }
            end

        end

        describe "with valid information"  do
            let(:user) { FactoryGirl.create(:user) }
            before { valid_sign_in(user) }

            it { should have_selector('title', text: user.name) }
            it { should have_link('Users', href: users_path) }
            it { should have_link('Profile', href: user_path(user)) }
            it { should have_link('Settings', href: edit_user_path(user)) }
            it { should have_link('Logout', href: signout_path) }
            it { should_not have_link('Log-in', href: signin_path) }

            describe "followed by logout" do
                before { click_link "Logout" }

                it { should have_link("Log-in") }

            end
        end
    end

    describe "authorisation" do

        describe "for non-loggedin users" do
            let(:user) { FactoryGirl.create(:user) }

            describe "when attempting to visit a protected page" do
                before do
                    visit edit_user_path(user)
                    fill_in "Email", with: user.email
                    fill_in "Password", with: user.password
                    click_button "Log-in"
                end

                describe "after loggin in" do
                    it "should render the desired protected page" do
                        page.should have_selector('title', text: 'Edit User')
                    end
                end
            end

            describe "in the User's controller" do

                describe "visiting the edit page" do
                    before { visit edit_user_path(user) }
                    it { should have_selector('title', text: 'Log-in') }
                end

                describe "submitting to the update action" do
                    before { put user_path(user) }
                    specify { response.should redirect_to(signin_path) }
                end

                describe "visiting the user index" do
                    before { visit users_path }
                    it { should have_selector('title', text: 'Log-in') }
                end

            end

        end

        describe "as wrong user" do
            let(:user) { FactoryGirl.create(:user) }
            let(:wrong_user) { FactoryGirl.create(:user, email: "wrong@example.com") }
            before { valid_sign_in(user) }

            describe "visiting Users#edit page" do
                before { visit edit_user_path(wrong_user) }
                it { should_not have_selector("title", text: full_title('Edit user')) }
            end

            describe "submitting a PUT request to the Users#update action" do
                before { put user_path(wrong_user) }
                specify { response.should redirect_to(root_path) }
            end

        end

        describe "as non-admin user" do
            let(:user) { FactoryGirl.create(:user) }
            let(:non_admin) { FactoryGirl.create(:user) }

            before { valid_sign_in(non_admin) }

            describe "submitting a DELETE request to the Users#destroy action" do
                before { delete user_path(user) }
                specify { response.should redirect_to(root_path) }
            end
        end
    end

end