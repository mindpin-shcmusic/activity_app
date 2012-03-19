class Activity < ActiveRecord::Base
  # --- 模型关联
  belongs_to :creator, :class_name => "User", :foreign_key => :creator_id
  has_many :activity_assigns
  has_many :participants, :through => :activity_assigns, :source => :user
  accepts_nested_attributes_for :activity_assigns
  
  # --- 模型验证
  validates :title, :content, :date, :creator, :presence => true
  
  # 只有老师才可以创建教学活动
  validate :check_creator_must_is_teacher
  def check_creator_must_is_teacher
    if !self.creator.blank? && !self.creator.is_teacher?
      errors.add(:creator,"只有老师才可以创建教学活动")
    end
  end
  
  # 验证 date 字符串是否是有效的时间字符串
  validate :check_date_format
  def check_date_format
    if !self.date.blank?
      str = Time.parse(self.date.to_s).strftime("%Y%m%d")
      if str != self.date.to_s
        errors.add(:date,"date 的格式不正确") 
      end
    end
  end

  # 活动至少有一个参与者
  validate :check_at_least_one_participant
  def check_at_least_one_participant
    if self.activity_assigns.blank?
      errors.add(:participants ,"活动至少有一个参与者")
    end
  end
  
  def hold_date
    Time.parse(self.date.to_s)
  end
  
  module UserMethods
    def self.included(base)
      base.has_many :created_activities, :class_name => "Activity", :foreign_key => :creator_id
    end
    
    def all_activities
      created_activities | be_assign_activities
    end
    
    # [
    #    {:date=>date_1,:activities=>[activity_1,activity_2]},
    #    {:date=>date_2,:activities=>[activity_6,activity_3]}
    # ]
    def the_week_activities_data
      dates = _the_week_dates
      activities = []
      activities = created_activities.where(:date=>dates)
      activities = (activities | be_assign_activities.where(:date=>dates))
      
      temp_hash = {}
      activities.each do |activity|
        temp_hash[activity.date]||=[]
        temp_hash[activity.date].push activity
      end
      
      dates.map do |date|
        {:date=>date,:activities=>temp_hash[date]||[]}
      end
    end
    
    # 返回这个星期的七个日期字符串数组
    def _the_week_dates
      t = Time.now
      if 0 == t.wday
        monday = t-6.day
      else
        monday = t-(t.wday-1).day
      end
      tuesday = monday+1.day
      wednesday = monday+2.day
      thursday = monday+3.day
      friday = monday+4.day
      saturday = monday+5.day
      sunday = monday+6.day
      [monday,tuesday,wednesday,thursday,friday,saturday,sunday].map{|time|time.strftime("%Y%m%d").to_i}
    end
  end
end
