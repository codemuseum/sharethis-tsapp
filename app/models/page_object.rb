class PageObject < ActiveRecord::Base
  include ThriveSmartObjectMethods

  self.caching_default = :page_object_update #[in :forever, :page_object_update, :any_page_object_update, 'data_update[datetimes]', :never, 'interval[5]']

  belongs_to :button
  
  validates_associated :button
  before_save :save_button
  
  def default_button
    @default_button ||= Button.default_for_site(self.site_uid).first
  end
  
  def has_button?
    displayed_button
  end
  
  def displayed_button
    self.button || default_button
  end
  
  def all_buttons
    @all_buttons ||= Button.all_buttons_for(self.site_uid).map { |b| [b.nickname, b.id] }
  end

  def assigned_button=(hash)
    edited_unit = hash.delete(:edited_unit)
    if hash[:id].blank?
      self.button = Button.new_for_site(self.site_uid, hash)
      @button_updated = true
    else
      self.button = Button.all_buttons_for(self.site_uid).find_by_id(hash[:id])
      if edited_unit == 'true' || edited_unit == '1'
        self.button.attributes = hash
        @button_updated = true
      end
    end
  end
  
  protected
    def save_button
      self.button.save if @button_updated
    end
  
end
