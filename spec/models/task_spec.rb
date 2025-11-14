require 'rails_helper'

RSpec.describe Task, type: :model do
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:due_date) }

  it { should belong_to(:parent).class_name('Task').optional }
  it { should have_many(:children).class_name('Task').with_foreign_key('parent_id') }

it 'is invalid when child due_date < parent due_date' do
    parent = Task.create!(title: 'Tijolo', due_date: Date.new(2025,10,20))
    child = Task.new(title: 'Reboco', due_date: Date.new(2025,10,19), parent: parent)
    expect(child).not_to be_valid
    expect(child.errors[:due_date]).to include('must be on or after parent due_date')
  end

  it 'is valid when child due_date == parent due_date' do
    parent = Task.create!(title: 'Tijolo', due_date: Date.new(2025,10,20))
    child = Task.new(title: 'Reboco', due_date: Date.new(2025,10,20), parent: parent)
    expect(child).to be_valid
  end
end