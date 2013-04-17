require 'resque/tasks'

task "resque:setup" => :environment do
  ENV['QUEUE'] = '*'

  Resque.after_fork do |job|
    ActiveRecord::Base.establish_connection
  end
end

<<<<<<< HEAD
task "jobs:work" => "resque:work"
=======
>>>>>>> master

