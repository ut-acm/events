class PriceModel < ActiveRecord::Base
	belongs_to :event
	has_many :participations

	validate :price_model_is_for_event, :before => :create

  private
    def ensure_ice_cream_is_not_melted
    	if self.price_model
    end
end
