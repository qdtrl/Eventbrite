class User < ApplicationRecord
  has_many :attendances
  has_many :events, through: :attendances
  has_many :admin_events, foreign_key: "event_admin_id", class_name: "Event", dependent: :destroy

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  after_create :welcome_send

  private
  
  def welcome_send
    UserMailer.welcome_email(self).deliver_now
  end
end
