class Teacher < ActiveRecord::Base
  belongs_to :user
  
  validates :real_name, :presence => true
  validates :tid, :uniqueness => { :if => Proc.new { |teacher| !teacher.tid.blank? } }
  
  module UserMethods
    def self.included(base)
      base.has_one :teacher
      base.send(:include,InstanceMethod)
    end
    
    module InstanceMethod
      def is_teacher?
        !self.teacher.blank?
      end
      
      def real_name
        self.teacher.real_name if is_teacher?
        self.student.real_name if is_student?
        self.name
      end
    end
  end
end
