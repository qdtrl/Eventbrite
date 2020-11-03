class Attendance < ApplicationRecord
  belongs_to :users
  belongs_to :events

  after_create :attendance_send

  private
  
  def attendance_send
    event = self.event
    event_admin = event.event_admin
    UserMailer.attendance_email(event_admin, event).deliver_now
  end
end
