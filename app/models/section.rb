class Section < ApplicationRecord
  belongs_to :page

  has_many :section_edits
  has_many :admin_users, through: :section_edits

  scope :sorted, -> { order('position ASC')}
  scope :visible, -> { where(visible: true) }
  scope :invisible, -> { where(visible: false) }
  scope :newest_first, -> { order('created_at DESC') }
end