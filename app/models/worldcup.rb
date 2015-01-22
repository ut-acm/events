class Worldcup < ActiveRecord::Base
  belongs_to :profile
  validates :germany_goal, :numericality => { :greater_than_or_equal_to => 0 }
  validates :argentina_goal, :numericality => { :greater_than_or_equal_to => 0 }
end
