教学活动安排的原型

student 和 teacher 模型是为了开发原型用，整合时忽略掉
给自己的用户模型关联 teacher 或者 student 模型需要手动在控制台进行，没有web界面
只需要把 student 或者 teacher 模型的 user_id 字段设置为自己用户的ID即可

要求
  1 教师可以创建教学活动，创建的时候，填写活动描述，制定活动日期和参与的学生和老师
  2 创建者和活动的参与者  都可以在一个简单的日历界面查看到本周创建和需要参与的教学活动
  3 自己创建的活动用粗体表示，参加的活动用普通字体表示
  
数据库
  activities
    string :title
    text   :content
    integer  :date   # 比如 "20120317"
    integer :creator_id
    
  activity_assign
    integer :activity_id
    integer :user_id