require 'erb'
require 'rake'

def start_date_time
  "alskmdalksmd"
end

def db_host
  "asdknasldknasd"
end

def db_username
  "asdknasldknasd"
end

def db_password
  "asdknasldknasd"
end

def db_database
  "asdknasldknasd"
end

task :dist do
  out = ERB.new(IO.read("pipeline.json.erb")).result(binding)
  mkdir_p 'dist'
  IO.write("dist/pipeline.json", out)
end
