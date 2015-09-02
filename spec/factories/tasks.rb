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

FactoryGirl.define do
  factory :task do
    name 'Do Homework'
    setting 'Home'
    time Time.now
    complete false
  end
end
