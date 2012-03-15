教学活动安排的原型

要求
  1 教师可以创建教学活动，创建的时候，填写活动描述，制定活动日期和参与的学生和老师
  2 创建者和活动的参与者  都可以在一个简单的日历界面查看到创建和需要参与的教学活动
  
数据库
  activities
    string :title
    text   :content
    string  :date   # 比如 "20120317"
    
  activity_assign
    integer :activity_id
    integer :user_id