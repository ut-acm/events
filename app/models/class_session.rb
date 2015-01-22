class ClassSession < ActiveRecord::Base

  include Authority::Abilities
  resourcify

  belongs_to :event
end
