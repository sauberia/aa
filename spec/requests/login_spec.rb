require 'spec_helper'

describe 'Login' do

  it 'should allow two users to login simultaneously without interfering with each other' do

    # Create two accounts

    without_access_control do
      %w( one two ).each { |name| User.make(:email => "#{name}@example.com") }
    end


    # Log in to first account

    Capybara.session_name = 'one'

    visit login_path

    fill_in 'Email',    :with => 'one@example.com'
    fill_in 'Password', :with => 'qweqwe'
    click_on 'Login'

    current_path.should == root_path
    page.should have_content 'Login successful!'
    page.should have_content 'Logged in as one@example.com'


    # Log in to second account in a separate session

    Capybara.session_name = 'two'

    visit login_path

    fill_in 'Email',    :with => 'two@example.com'
    fill_in 'Password', :with => 'qweqwe'
    click_on 'Login'

    current_path.should == root_path
    page.should have_content 'Login successful!'
    page.should have_content 'Logged in as two@example.com'


    # Visit the home page in the first session

    Capybara.session_name = 'one'

    visit root_path

    page.should have_content 'Logged in as one@example.com'
    page.should_not have_content 'You (two@example.com) are not authorised to perform that action'

  end

end