RSpec.describe 'Tasks API', type: :request do
  it 'creates a task when no id provided' do
    post '/tasks', params: { task: { title: 'Tijolo', due_date: '2025-10-20' } }
    expect(response).to have_http_status(:created)
    expect(JSON.parse(response.body)['title']).to eq('Tijolo')
  end

  it 'updates due_date and calls UpdateTaskDatesService when editing' do
    parent = Task.create!(title: 'Tijolo', due_date: Date.new(2025,10,20))

    expect(UpdateTaskDatesService)
      .to receive(:new)
      .with(parent, Date.new(2025,10,20), Date.new(2025,10,25))
      .and_call_original

    post "/tasks/#{parent.id}", params: {
      task: { due_date: "2025-10-25" }
    }

    expect(response).to have_http_status(:ok)
  end
end