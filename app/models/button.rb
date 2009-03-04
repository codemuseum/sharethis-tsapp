class Button < ActiveRecord::Base
  attr_protected :site_uid
  before_validation :add_offset_to_code
  validates_presence_of :site_uid
  validates_uniqueness_of :nickname, :scope => :site_uid
  after_save :set_unique_default_for_site_uid
  
  named_scope :default_for_site, lambda { |site_uid| {
    :conditions => { :site_uid => site_uid, :default => true }
  }}
  
  named_scope :all_buttons_for, lambda { |site_uid| {
    :conditions => { :site_uid => site_uid }
  }}

  def self.new_for_site(st_uid, attrs = {})
    returning new(attrs) do |b|
      b.site_uid = st_uid
    end
  end
  
  # For the form
  def edited_unit
    false
  end
  
  protected
    def add_offset_to_code
      return if self.code =~ /offsetLeft/
      self.code.gsub!(/"><\/script>/, "&amp;offsetLeft=-275\"><\/script>")
    end
  
    def set_unique_default_for_site_uid
      if self.default
        current_default = self.class.default_for_site(self.site_uid).first
        if current_default.id != self.id
          current_default.update_attribute(:default, false)
        end
      end
    end
end
