class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :lift_password
  # attr_accessible :title, :body

  has_one :withings, class_name: 'WithingsToken', dependent: :destroy

  has_many :habit_links

  def subscribe_withings
    binding.remote_pry
    user = Withings::User.authenticate(withings.withings_user_id, withings.token, withings.secret)
    notifications = user.list_notifications(Withings::SCALE)
    if notifications.length < 1
      user.subscribe_notification('http://intense-bayou-2687.herokuapp.com/withings/notify', 'http://test.com', Withings::SCALE)
    end
  end

  protected

  def password_required?
    false
  end

end
