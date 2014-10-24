class Student < ActiveRecord::Base
  has_many :group_participations
  has_many :groups, through: :group_participations
end
