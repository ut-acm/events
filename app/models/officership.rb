class Officership < ActiveRecord::Base
  include Authority::Abilities
  resourcify

  belongs_to :profile
  belongs_to :event
end
