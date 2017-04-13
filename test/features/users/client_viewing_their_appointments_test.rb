require "test_helper"

feature 'a user views their appointment list' do
  scenario 'a client can view their upcoming appointments' do
    sign_in(:client)
    visit user_appointments_path(users(:client))

    page.must_have_content 'Upcoming Appointments'
  end 

  scenario 'a therapist can view their upcoming appointments'
  scenario 'a client can view past appointments'
  scenario 'a therapist can view past appointments'
end
