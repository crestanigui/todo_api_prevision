class UpdateTaskDatesService
  def initialize(task, old_date, new_date)
    @task = task
    @old_date = old_date
    @new_date = new_date
    @delta = @new_date - @old_date
  end

  def call
    propagate(@task)
  end

  private

  def propagate(task)
    task.children.find_each do |child|
      next unless child.due_date
      child.update!(due_date: child.due_date + @delta)
      propagate(child)
    end
  end
end
