class Attendance < ApplicationRecord
  belongs_to :user
  belongs_to :event

  after_create :new_event_subsciption_send

  
  def new_event_subsciption_send
    UserMailer.new_event_subsciption_send(user, event).deliver_now
  end
end
