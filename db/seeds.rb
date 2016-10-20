# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

settings = Setting.create([
  {key: 'booking_limit_days', value: '7'},
  {key: 'course_view_days', value: '7'},
  {key: 'cancle_limit_minutes', value: '7'},
  {key: 'queue_limit_number', value: '7'},
])

users = Users.create([
  {full_name: 'admin', password:'1234'}
])
customers = Customer.create([
  {name: '张三', weixin: 'wx123456', mobile: '13912345678'},
  {name: '李四', weixin: 'wx234567', mobile: '18912345678'}
])

course_types = CourseType.create([
  {name: '基础课程'},
  {name: '进阶课程'},
  {name: '上肢力量'},
  {name: '下肢力量'},
])

stores = Store.create([
  {name: '中关村店', telphone: '010-009988776', address: '中关村'},
  {name: '大望路店', telphone: '010-119988776', address: '大望路'}
])


