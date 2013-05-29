require 'spec_helper'

describe "AuthenticationPages" do

    subject { page }
    
    describe "sign in page" do
        before { visit signin_path }
        
        it { should have_selector('h1', text: 'Log-in') }
        it { should have_selector('title', text: 'Log-in') }
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
            before { valid_signin(user) }
            
            it { should have_selector('title', text: user.name) }
            it { should have_link('Profile', href: user_path(user)) }
            it { should have_link('Logout', href: signout_path) }
            it { should_not have_link('Log-in', href: signin_path) }
            
            describe "followed by logout" do
                before { click_link "Logout" }
                
                it { should have_link("Log-in") }
                
            end 
        end
    end
    
end
