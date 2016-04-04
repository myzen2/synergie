class User < ActiveRecord::Base
  include Mailboxer::Models::Messageable
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :articles, dependent: :destroy
  has_many :comments, dependent: :destroy

  acts_as_messageable

  def forem_name
    pseudo
  end

  # Returning any kind of identification you want for the model
  def name
    pseudo
  end

  # Returning the email address of the model if an email should be sent for this object (Message or Notification).
  # If no mail has to be sent, return nil.
  def mailboxer_email(_object)
    email
  end
end
