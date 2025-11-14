class Task < ApplicationRecord
  belongs_to :parent, class_name: 'Task', optional: true
  has_many :children, class_name: 'Task', foreign_key: 'parent_id', dependent: :restrict_with_error

  validates :title, presence: true
  validates :due_date, presence: true
end
