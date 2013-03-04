require 'spec_helper.rb'

feature 'Signing up' do
  background do
  end

  scenario 'Signing in with correct credentials' do
    click_link 'Sign in'
    fill_in 'email', with: 'tgeithner@mailinator.com'
    fill_in 'password', with: 'sybakaos'
    click_link '.btn.submit'
    page.should have_content 'Tim Geithner'
  end
end
