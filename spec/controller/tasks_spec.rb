require 'rails_helper'

RSpec.describe TasksController, type: :controller do
  describe "#index" do
    before(:each) do 
      @task1 = create(:task)
      @task2 = create(:task)
    end

		it "routes to index" do
      {get: "/tasks"}.should route_to("tasks#index")
    end

    it "shows the list of tasks" do
      get :index
      assigns(:tasks).should == [@task1, @task2]
      response.should render_template :index
      response.should be_success
		end
  end

  describe "#update" do
    it "routes to update" do
      {put: "/tasks/1"}.should route_to("tasks#update", id: "1")
    end

    before(:each) do
      @task = create(:task)
    end

    context "when update is successful" do
      it "changes the task's attributes" do
        put :update, id: @task.id, task: {name: "Cool Project", complete: true, time: Time.new(2000), setting: "Cool Place"}
        
        @task.reload
        @task.name.should == "Cool Project"
        @task.complete.should == true
        @task.time.should eq(Time.new(2000))
        @task.setting.should == "Cool Place"

        flash[:notice].should == "Task successfully updated"
        response.should redirect_to(tasks_path)
      end
    end

    context "when update is unsuccessful" do
      it "doesn't change the task's attributes" do
        put :update, id: @task.id, task: {name: "", complete: true, time: Time.new(2000), setting: "Cool Place"}
        
        @task.reload
        @task.name.should_not == ""
        @task.complete.should_not == true
        @task.time.should_not == Time.new(2000)
        @task.setting.should_not == "Cool Place"

        flash[:error].should == "Name can't be blank"
        response.should redirect_to(tasks_path)
      end
    end
  end

  describe "#create" do
    it "routes to create" do
      {post: "/tasks"}.should route_to("tasks#create")
    end

    context "when create is successful" do
      it "should add a new task" do
        expect {
          post :create, task: {name: "Cool Project", complete: true, time: Time.new(2000), setting: "Cool Place"}
        }.to change(Task, :count).by(1)

        @task = Task.last
        @task.name.should == "Cool Project"
        @task.complete.should == true
        @task.time.should == Time.new(2000)
        @task.setting.should == "Cool Place"
        
        flash[:notice].should == "Task successfully created"
        response.should redirect_to(tasks_path)
      end
    end

    context "when create is unsuccessful" do
      it "should not add a new task" do
        expect {
          post :create, task: {name: "", complete: true, time: Time.new(2000), setting: "Cool Place"}
        }.to_not change(Task, :count)
        
        flash[:error].should == "Name can't be blank"
        response.should redirect_to(tasks_path)
      end
    end
  end

  describe "#destroy" do
    it "routes to destroy" do
      {delete: "/tasks/1"}.should route_to("tasks#destroy", id: "1")
    end

    describe "it removes a task" do
      before do
        @task = create(:task)
      end

      it "should successfully remove the task" do
        expect{
          delete :destroy, id: @task.id
          }.to change(Task, :count).by(-1)   
        
        flash[:notice].should == "Task successfully destroyed"
        response.should redirect_to(tasks_path)
      end
    end
  end
end