class ActivityAssign < ActiveRecord::Base
  belongs_to :user
  belongs_to :activity
  
  module UserMethods
    def self.included(base)
      base.has_many :activity_assigns
      base.has_many :be_assign_activities, :through =>:activity_assigns, :source => :activity  
    end
  end
end
