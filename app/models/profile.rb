class Profile < ActiveRecord::Base
  acts_as_taggable
  validates :phone_number, format: { with: /\A[0-9]*\z/, message: "bad format" }
  # associations
  belongs_to :user
  has_many :participations
  has_many :my_events, :through => :participations , :source => :event
  has_many :officerships
  has_many :events, :through => :officerships
  has_many :payments

  has_one :worldcup
  has_many :answers

  after_create :set_credentials

  def set_credentials
    if self.name.nil?
      self.name = ""
    end
    if self.surname.nil?
      self.surname = ""
    end
    if self.phone_number.nil?
      self.phone_number=""
    end
    self.save
  end


  def is_officer(event)
    event.officers.include?(self)
  end


  # attachments
  has_attached_file :avatar, styles: {thumb: "100x100#"}

  # validations
  validates_attachment :avatar, :content_type => { :content_type => ["image/jpeg", "image/png"] }, :size => { :in => 0..512.kilobytes }

  def complete?
    !self.name.blank? and !self.surname.blank?
  end

  def credentials
    self.name + " " + self.surname
  end

  def cancel_book(event)
    participations.where("event_id = ?", event.id).delete_all
  end

  def book(event)
    if event.participations.where("profile_id = ?", self.id).count == 0
      return (event.participations << Participation.new(:event => event, :profile => self))
    end
  end

  def buy(participation)
    if participations.profile == self and Invoice.where("profile_id = ?", participations.profile.id).where("event_id = ?", participations.event.id).any? == false
      invoice = Invoice.create(:participation => participation, :amount => participations.event.price)
      if invoice.errors.blank?
        self.credit -= participations.event.price
        self.save
        return true
      end
      return false
    end
    return false
  end

  def next_sessions
    ClassSession.where("start_time > ?", Time.now).joins(:event).merge(
        Event.joins(:participations).merge(
            Participation.where("payed = ?",true).where("profile_id = ? ", self.id)))
  end

end
