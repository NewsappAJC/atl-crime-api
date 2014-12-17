class Zone < ActiveRecord::Base
  
  self.primary_key = :zone # or other primary key

  scope :all_zones, -> { where.not("zone = ? or zone = ? or zone = ?", '0', ' ', '9') }


end