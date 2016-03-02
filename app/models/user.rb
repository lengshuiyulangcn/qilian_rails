class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  VALIDATE_PHONE_NUMBER = /\A0[7,8,9]0\d{8}\z/ 
  attr_accessor :login
 
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, :authentication_keys => [:login]
  
  has_and_belongs_to_many :courses, join_table: "users_courses"
  validates_presence_of :name,message: '昵称不能为空'
  validates_presence_of :family_name, message: '姓氏不能为空', on: [:update]
  validates_presence_of :given_name,message: '名字不能为空', on: [:update]
  validates_length_of :name, minimum: 2, maximum: 12, message: '昵称应该在2-20个字符以内', on: [:update]
  validates_format_of :phone, with: VALIDATE_PHONE_NUMBER, message: "请输入正确的手机号码", on: [:update]
  validates_presence_of :school, message: '学校不能为空', on: [:update]
  validates_presence_of :major, message: '专业不能为空', on: [:update]
 
  has_many :entries
  has_one :cv
  has_and_belongs_to_many :events

  mount_uploader :image, ImageUploader
  after_create :make_cv

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
      # conditions should be converted to hash
      where(conditions.to_hash).first
    end
  end
  def email_required?
    false
  end

  def email_changed?
    false
  end
  
  def admin?
    self.role == 'admin'
  end
  def teacher?
    self.role == 'teacher'
  end
  # override devise reset_password! method
  def reset_password!(new_password, new_password_confirmation)
    self.password = new_password
    self.password_confirmation = new_password_confirmation

    validates_presence_of     :password
    validates_confirmation_of :password
    validates_length_of       :password, within: Devise.password_length, allow_blank: true

    if errors.empty?
      clear_reset_password_token
      after_password_reset
      save(validate: false)
    end
  end
  private
  def make_cv
    Cv.create(user_id: id, email: email, cell_phone: phone, birthday: birthday, gender: gender)
  end

end
