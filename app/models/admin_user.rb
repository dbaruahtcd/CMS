class AdminUser < ApplicationRecord
  # self.table_name = "admin_users"

  has_secure_password

  has_and_belongs_to_many :pages, join_table: :admin_users_pages
  has_many :section_edits
  has_many :sections, through: :section_edits

  EMAIL_REGEX = /\A[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,4}\Z/i
  FORBIDDEN_USERNAMES = [ 'username', 'user_name', 'uname' ]

  # long form validation
  # validates_presence_of :first_name
  # validates_length_of :first_name, maximum: 25
  # validates_presence_of :last_name
  # validates_length_of :last_name, maximum: 50
  # validates_presence_of :username
  # validates_length_of :username, within: 8..25
  # validates_uniqueness_of :username
  # validates_presence_of :email
  # validates_length_of :email, maximum: 100
  # validates_format_of :email, with: EMAIL_REGEX
  # validates_confirmation_of :email

  validates :first_name, presence: true,
                          length: { maximum: 25 }
  validates :last_name, presence: true,
                         length: { maximum: 50 }
  validates :username, presence: true,
                        uniqueness: true,
                        length: { within: 8..25 }
  validates :email, presence: true,
                    length: { maximum: 100 },
                    format: EMAIL_REGEX,
                    confirmation: true

  validate :username_is_allowed
  validate :no_new_user_on_saturday

  scope :sorted, ->{ order('last_name ASC, first_name ASC') }

  def name
    "#{first_name} #{last_name}"
    # first_name + ' ' + last_name
    # [first_name, last_name].join(' ')
  end


  private
  def username_is_allowed
    if FORBIDDEN_USERNAMES.include?(username)
      errors.add(:username, 'cannot be used')
    end
  end

  def no_new_user_on_saturday
    if Time.new.wday == 6
      errors.add(:base, 'No new users can be added on Saturday')
    end
  end
end
