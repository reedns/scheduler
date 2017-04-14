require "test_helper"

feature 'a user views their appointment list' do
  scenario 'a client can view their upcoming appointments' do
    sign_in(:client)
    visit user_appointments_path(users(:client))

    page.must_have_content 'Upcoming Appointments'
    page.must_have_content users(:client).full_name
  end 

  scenario 'a therapist can view their upcoming appointments' do
    sign_in(:therapist)
    visit user_appointments_path(users(:therapist))

    page.must_have_content 'Upcoming Appointments'
    page.must_have_content users(:therapist).full_name
  end

  scenario 'a client can view past appointments' do
    sign_in(:client)
    visit user_appointments_path(users(:client), view: 'past_appointments')

    page.must_have_content 'Past Appointments'
    page.must_have_content users(:client).full_name
  end

  scenario 'a therapist can view past appointments' do
    sign_in(:therapist)
    visit user_appointments_path(users(:therapist))

    page.must_have_content 'Past Appointments'
    page.must_have_content users(:therapist).full_name
  end


  scenario "a client cannot see other client's or therapist's appointments" do
    sign_in(:client)
    visit user_appointments_path(users(:client2))
    page.must_have_content 'You are not authorized to perform this action.'

    visit user_appointments_path(users(:therapist))
    page.must_have_content 'You are not authorized to perform this action.'
  end

  scenario "a therapist cannot see other therapist's or a client's appointments" do
    sign_in(:therapist)
    visit user_appointments_path(users(:client2))
    page.must_have_content 'You are not authorized to perform this action.'

    visit user_appointments_path(users(:therapist2))
    page.must_have_content 'You are not authorized to perform this action.'
  end
end
