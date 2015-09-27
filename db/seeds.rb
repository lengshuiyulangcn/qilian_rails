# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create(name:'admin',
            role: 'admin',
            family_name:'qilian',
            given_name:'admin',
            gender: 'male',
            email: 'gyorou@tjjtds.me',
            birthday: Time.now,
            password: 'qilianadmin',
            school: 'MIT',
            major: 'CS',
            phone: '08011111111')
