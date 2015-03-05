require 'test_helper'

feature 'reserving an appointment' do
  scenario 'client reserves an available appointment' do
    sign_in(:client)
    visit edit_appointment_path(appointments(:available_appointment))
    fill_in 'Select Start Time', with: '2:00pm'
    click_button 'Reserve Appointment'

    page.must_have_content 'Appointment was succesfully reserved.'
  end

  scenario 'client cannot reserve an appointment outside of time block' do
    sign_in(:client)
    visit edit_appointment_path(appointments(:available_appointment))
    fill_in 'Select Start Time', with: '8:00am'
    click_button 'Reserve Appointment'
    page.must_have_content 'must be within the available block'

    fill_in 'Select Start Time', with: '4:00pm'
    click_button 'Reserve Appointment'
    page.must_have_content 'must be within the available block'
  end
end
