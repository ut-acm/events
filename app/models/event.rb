class Event < ActiveRecord::Base

  include Authority::Abilities
  resourcify

  # associations
  has_many :participations
  has_many :participants, :through => :participations, :source => :profile
  has_many :subscriptions
  has_many :subscribers, :through => :subscriptions, :source => :profile
  has_many :officerships
  has_many :officers, :through => :officerships, :source => :profile
  has_many :class_sessions
  has_one :survey
  has_one :report

  # attachments
  has_attached_file :poster, styles: {thumb: "x150"}
  
  # validations
  validates_attachment :poster, :content_type => { :content_type => ["image/jpeg", "image/png"] }, :size => { :in => 0..5.megabytes }
  
  def authors
    result = ""
    self.officers.each_with_index do |officer, i|
      result += (i == 0 ? "" : ", ") + officer.credentials
    end
    result
  end

  def members
    Profile.joins(:participations).merge(Participation.where("event_id = ?",self.id).where("payed = ?", true))
  end

  def members_mails
    s = ""
    Profile.joins(:participations).merge(Participation.where("event_id = ?",self.id).where("payed = ?", true)).each do |p|
      s += p.user.email + ";"
    end
    return s
  end

  #def registered_participants
  #  Profile.
  #end


  def can_register?
    Time.now < self.begins
  end

  def is_full?
    capacity <= participations.where('payed = ?',true).count
  end

end
