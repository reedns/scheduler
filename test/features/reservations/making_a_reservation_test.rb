require 'test_helper'

feature 'reserving an appointment' do
  scenario 'client reserves an available appointment' do
    sign_in(:client)
    visit root_path
    click_link "#{appointments(:available_appointment)}"
    fill_in 'Reservation Time', with: '2:00pm'
    click_button 'Reserve Appointment'

    page.must_have_content 'The appointment was succesfully booked.'
  end
end
