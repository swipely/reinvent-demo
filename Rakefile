require 'erb'
require 'rake'

require './lib/deploy'

def period
  '12 hours'
end

class JsonBinding < OpenStruct
  def start_date_time
    start_time = Time.now.utc - 12 * 60 * 60
    hour = (start_time.hour < 12) ? '00' : '12'
    start_time.strftime("%Y-%m-%dT#{hour}:00:01")
  end

  def get_binding
    binding
  end
end

def pipeline_json
  json_binding = JsonBinding.new(YAML.load_file('config.yml'))
  ERB.new(IO.read("pipeline.json.erb")).result(json_binding.get_binding)
end

task :clean do
  rm_rf 'dist'
end

task :dist do
  mkdir_p 'dist'
  IO.write("dist/pipeline.json", pipeline_json)
end

task :deploy => [:dist] do
  S3Deployer.copy_dir('bin', 'swipely-reinvent-demo', 'bin/')
  PipelineDeployer.deploy_pipeline("pipe-reinvent-demo", pipeline_json)
end
