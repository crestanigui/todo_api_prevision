class Task < ApplicationRecord
  belongs_to :parent, class_name: "Task", optional: true
  has_many :children, class_name: "Task", foreign_key: "parent_id", dependent: :restrict_with_error

  validates :title, presence: true
  validates :due_date, presence: true

  validate :child_due_date_after_or_equal_parent

  def child_due_date_after_or_equal_parent
    return unless parent && due_date

    if due_date < parent.due_date
      errors.add(:due_date, "must be on or after parent due_date")
    end
  end
end
