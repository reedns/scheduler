require 'test_helper'

feature 'viewing appointments' do
  scenario 'a therapist can view all appointments' do
    sign_in(:therapist)
    visit appointments_path
    page.must_have_content appointments(:reserved_appointment).date
    page.must_have_content appointments(:available_appointment).date
  end

  scenario 'a therapist can view any appointment' do
    sign_in(:therapist)
    visit edit_appointment_path(appointments(:reserved_appointment))

    page.must_have_content users(:client).full_name
  end

  scenario 'a client can only see available appointments' do
    sign_in(:client)
    visit appointments_path
    page.must_have_content appointments(:available_appointment).date
    page.wont_have_content appointments(:reserved_appointment).date
  end

  scenario "a client cannot view another client's appointment" do
    sign_in(:client)
    visit edit_appointment_path(appointments(:new_appointment))
    page.must_have_content Time.now.month
  end

  scenario 'a client can view an available appointment' do
    sign_in(:client)
    visit edit_appointment_path(appointments(:available_appointment))
    page.must_have_content appointments(:available_appointment).date
  end

  scenario 'expired appointments are not viewable in the appointments list' do
    sign_in(:therapist)
    visit appointments_path
    page.wont_have_content appointments(:old_appointment).date
  end

  scenario 'apppointments display in descending order by date' do
    sign_in(:therapist)
    visit appointments_path
    page.must_have_selector
  end
end
