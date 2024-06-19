# == Schema Information
#
# Table name: tutors
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  course_id  :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

# The Tutor model represents a tutor in the system.
# A tutor belongs to one course.

class Tutor < ApplicationRecord
  belongs_to :course

  validates :name, presence: true
end
