class Attendance < ApplicationRecord
  belongs_to :users
  belongs_to :events

  after_create :new_event_send

  
  def new_event_send
    UserMailer.new_event_send(self).deliver_now
  end
end
