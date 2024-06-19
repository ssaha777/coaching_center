# == Schema Information
#
# Table name: courses
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

# A course can have many tutors.

class Course < ApplicationRecord
  has_many :tutors, dependent: :destroy

  accepts_nested_attributes_for :tutors

  validates :name, presence: true
end
