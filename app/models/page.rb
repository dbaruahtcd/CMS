class Page < ApplicationRecord

  belongs_to :subject, {optional: false }# , {:foreign_key => 'foreign_key'}
  has_many :sections
  has_and_belongs_to_many :admin_users, join_table: :admin_users_pages

  scope :visible, lambda { where(:visible => true) }
  scope :invisible, lambda { where(:visible => false) }
  scope :sorted, lambda { order("position ASC") }
  scope :newest_first, lambda { order("created_at DESC") }
end