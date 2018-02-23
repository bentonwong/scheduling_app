desc "This task is called by the Heroku scheduler add-on"
task :update_reqs_resps => :environment do
  puts "Updating requests & responses..."
  Request.update_open_requests
  Response.update_open_responses
  puts "done."
end
