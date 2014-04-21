class User < ActiveRecord::Base
  include Gravtastic
  gravtastic :size => 18

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :firstname, :surname, :email, presence: true
end
