require 'test_helper'

feature 'deleting an appointment' do
  scenario 'a therapist deletes an appointment' do
    sign_in(:therapist)
    visit edit_appointment_path(appointments(:available_appointment))
    click_link 'Delete Appointment'
    page.must_have_content Time.now.month
  end

  scenario 'a therapist cannot delete a reserved appointment' do
    sign_in(:therapist)
    visit edit_appointment_path(appointments(:reserved_appointment))
    page.wont_have_content 'Delete Appointment'
  end

  scenario 'a client cannot see the delete appointment link' do
    sign_in(:client)
    page.wont_have_content 'Delete Appointment'
  end
end
