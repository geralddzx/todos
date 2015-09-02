# == Schema Information
#
# Table name: tasks
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  complete   :boolean          default(TRUE), not null
#  setting    :string
#  time       :datetime
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Task, type: :model do
  describe "checks for name" do
  	context "when name is not present" do
  		let(:task_without_name) { build(:task, {name: nil}) }

  		it "shows the name error" do
  			task_without_name.valid?.should == false

  			task_without_name.errors.full_messages.should == ["Name can't be blank"]
  		end
  	end

  	context "when name is present" do
  		let(:task_with_name) { build(:task) }

  		it "doesn't show errors" do
  			task_with_name.valid?.should == true
  		end
  	end
  end
end
