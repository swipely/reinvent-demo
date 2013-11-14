require 'erb'
require 'rake'

require './lib/conf'
require './lib/deployer'

@log = Logger.new(STDOUT)

def conf
  @conf ||= Conf.new(YAML.load_file('config.yml'))
end

def pipeline_json
  @pipeline_json ||= ERB.new(IO.read("pipeline.json.erb")).result(conf.get_binding)
end

task :clean do
  @log.info('deleting dist')
  FileUtils.rm_rf('dist')
  @log.info('deleting s3 bin/')
  Deployer.delete_s3_dir('swipely-reinvent-demo', 'bin/')
  @log.info('deleting s3 run/')
  Deployer.delete_s3_dir('swipely-reinvent-demo', 'run/')
  @log.info('truncating table')
  Deployer.truncate_table(conf.marshal_dump, 'sales_by_day')
end

task :dist do
  @log.info("making dist/")
  FileUtils.mkdir_p('dist')
  @log.info("writing dist/pipeline.json")
  IO.write("dist/pipeline.json", pipeline_json)
end

task :deploy => [:clean, :dist] do
  @log.info('copying bin/ to s3')
  Deployer.copy_dir_to_s3('bin', 'swipely-reinvent-demo', 'bin/')
  @log.info('deploying pipeline')
  Deployer.deploy_pipeline('pipe-reinvent-demo', pipeline_json)
end
