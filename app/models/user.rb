class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  attr_accessor :login
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, :authentication_keys => [:login]
  has_and_belongs_to_many :courses, join_table: "users_courses"
  validates_presence_of :name
  validates_length_of :name, minimum: 2, maximum: 12
  has_many :entries
  mount_uploader :image, ImageUploader
  def self.find_for_facebook_oauth(auth)
      user = User.where(provider: auth.provider, uid: auth.uid).first
      unless user
        user  = User.new
        user.attributes = { name:     auth.extra.raw_info.name,
                            provider: auth.provider,
                            uid:      auth.uid,
                            image:    auth.info.image,
                            email:    auth.info.email.nil? ? "" : auth.info.email,
                            token:    auth.credentials.token,
                            password: Devise.friendly_token[0,20] }
      user.save
      end
      return user
  end
  def self.teachers
    User.where(role: 'teacher')
  end
  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["name = :value OR lower(email) = lower(:value)", { :value => login }]).first
    else
      where(conditions).first
    end
  end
  def email_required?
    false
  end

  def email_changed?
    false
  end
end
