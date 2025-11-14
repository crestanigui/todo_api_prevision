class TasksController < ApplicationController
  def edit
    if params[:id]
      task = Task.find(params[:id])

      old_due_date = task.due_date
      new_due_date = task_params[:due_date] ? Date.parse(task_params[:due_date]) : nil

      if task.update(task_params)

        if new_due_date.present? && new_due_date != old_due_date
          UpdateTaskDatesService.new(task, old_due_date, new_due_date).call
        end

        render json: task, status: :ok
      else
        render json: { errors: task.errors.full_messages }, status: :unprocessable_entity
      end

    else
      task = Task.new(task_params)
      if task.save
        render json: task, status: :created
      else
        render json: { errors: task.errors.full_messages }, status: :unprocessable_entity
      end
    end
  end

  def index
    tasks = Task.includes(:children).all
    render json: tasks.as_json(include: { children: { only: [:id, :title, :due_date, :parent_id] } })
  end

  private

  def task_params
    params.require(:task).permit(:title, :description, :due_date, :parent_id)
  end
end