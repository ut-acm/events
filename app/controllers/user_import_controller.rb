class UserImportController < ApplicationController
	def import_users
u=nil
go=false
n=0
# puts "KKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK:::::::::::::::::::::"
File.open("users.txt",'r') do |file|
# puts "KKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK:::::::::::::::::::::"
file.each_with_index do |line,i|
# puts "LLLLLLLLLLLLLLLLLLLLLLL",line
next if i==0
if i%2==1 && User.where(:email=>line).size==0
go=true
# puts line
u=User.create(:email=>line,:password=>"123456789",:password_confirmation=>"123456789")
u.errors.messages.each do |ee|
puts ee
end
elsif go
if u.update(:encrypted_password=>line)
n=n+1
else
u.errors.messages.each do |ee|
puts ee
end
end
go=false
end
end
end
puts ":::::::::::::::::::::::::::::::::::::::::",n,n,n,n
	end
end
