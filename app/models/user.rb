class User < ActiveRecord::Base
  has_secure_password
  has_many :ideas
  validates :username, presence: true

  #need a column in the user table where default user, can set to admin
  

end
