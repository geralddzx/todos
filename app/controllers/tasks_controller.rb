class TasksController < ApplicationController
	def index
		@tasks = Task.order(:id)
	end

	def update
		@task = Task.find(params[:id])
		if @task.update_attributes(task_params)
			flash[:notice] = "Task successfully updated"
		else
			flash[:error] = @task.errors.full_messages.join(", ")
		end
		redirect_to tasks_path
	end

	def create
		@task = Task.new(task_params)
		if @task.save
			flash[:notice] = "Task successfully created"
		else
			flash[:error] = @task.errors.full_messages.join(", ")
		end
		redirect_to tasks_path
	end

	def destroy
		Task.find(params[:id]).destroy
		flash[:notice] = "Task successfully destroyed"
		redirect_to tasks_path
	end

	private

	def task_params
		params.require(:task).permit(:name, :setting, :complete, :time)
	end
end
