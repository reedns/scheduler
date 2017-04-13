class Appointment < ActiveRecord::Base
  belongs_to :client, class_name: 'User'
  belongs_to :therapist, class_name: 'User'

  validates :date, :start_time, :end_time, presence: true
  validates :reservation_time, presence: true, on: :update, if: :user_client?
  validate :reservation_valid, on: :update
  validate :valid_time
  validate :valid_date

  def self.upcoming_appointments
    where('appointments.date >= ?', Time.zone.today)
  end

  delegate :full_name, to: :client, prefix: true
  delegate :full_name, to: :therapist, prefix: true

  private

  def reservation_valid
    if reservation_time && (reservation_time < start_time || reservation_time > end_time)
      errors.add(:reservation_time, 'must be within the available block')
    end
  end

  def valid_time
    errors.add(:start_time, 'must be before the start time') if start_time > end_time
  end

  def valid_date
    errors.add(:date, 'must be in the future') if date <= Date.today
  end

  def user_client?
    client_id
  end
end
