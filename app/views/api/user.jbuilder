json.token @key.access_token
json.user do 
  json.email @user.email
  json.name  @user.name
  json.gender @user.gender
  json.birthday @user.birthday
  json.id    @user.id
  json.image @user.image
  json.family_name @user.family_name
  json.given_name @user.given_name
  json.phone @user.phone
  json.school @user.school
  json.major @user.major
  json.job  @user.job
  json.wechat  @user.wechat
  json.line @user.line
end
