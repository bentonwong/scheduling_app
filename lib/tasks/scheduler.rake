desc "This task is called by the Heroku scheduler add-on"
task :update_requests => :environment do
  puts "Updating requests..."
  Request.update_open_requests
  puts "done."
end

task :send_reminders => :environment do
  puts "Updating responses..."
  Response.update_open_responses
  puts "done."
end
