require 'rails_helper'

RSpec.describe UpdateTaskDatesService do
  let!(:grandparent) { Task.create!(title: 'Tijolo', due_date: Date.new(2025, 10, 20)) }
  let!(:parent) { Task.create!(title: 'Reboco', due_date: Date.new(2025, 10, 21), parent: grandparent) }
  let!(:child) { Task.create!(title: 'Tinta', due_date: Date.new(2025, 10, 22), parent: parent) }

  it 'propagates difference to children and grandchildren' do
    old_date = grandparent.due_date
    new_date = Date.new(2025, 10, 25)
    difference = new_date - old_date

    described_class.new(grandparent, old_date, new_date).call

    expect(parent.reload.due_date).to eq(Date.new(2025, 10, 21) + difference)
    expect(child.reload.due_date).to eq(Date.new(2025, 10, 22) + difference)
  end
end
