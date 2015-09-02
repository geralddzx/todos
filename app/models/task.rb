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

class Task < ActiveRecord::Base
	validates :name, presence: true
end
