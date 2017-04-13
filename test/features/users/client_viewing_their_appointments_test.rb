require "test_helper"

feature 'a client views their appointment list' do
  scenario 'a client can view their upcoming appointments' do
    sign_in(:client)
    visit user_appointments_path(users(:client))

    page.must_have_content 'Upcoming Appointments'
  end 
end
