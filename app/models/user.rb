class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable
  has_and_belongs_to_many :courses, join_table: "users_courses"
  def self.find_for_facebook_oauth(auth)
      user = User.where(provider: auth.provider, uid: auth.uid).first

      unless user
        user  = User.new
        user.attributes = { name:     auth.extra.raw_info.name,
                            provider: auth.provider,
                            uid:      auth.uid,
                            email:    auth.info.email.nil? ?  "null@qilian.com" : auth.info.email,
                            token:    auth.credentials.token,
                            password: Devise.friendly_token[0,20] }
      user.save
      end
      return user
  end
  def self.teachers
    User.where(role: 'teacher')
  end
end
