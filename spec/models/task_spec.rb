require 'rails_helper'

RSpec.describe Task, type: :model do
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:due_date) }

  it { should belong_to(:parent).class_name('Task').optional }
  it { should have_many(:children).class_name('Task').with_foreign_key('parent_id') }
end