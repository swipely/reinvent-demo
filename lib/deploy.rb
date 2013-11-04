require 'fog'
require 'logger'

class PipelineDeployer
  @log = Logger.new(STDOUT)
  @data_pipelines = Fog::AWS::DataPipeline.new

  def self.deploy_pipeline(pipeline_name, definition)
    pipeline_ids = existing_pipelines(pipeline_name)
    @log.info("#{pipeline_ids.count} existing pipelines: #{pipeline_ids}")
    

    # Create new pipeline
    created_pipeline_id = create_pipeline(pipeline_name, definition)
    @log.info("Created pipeline id '#{created_pipeline_id}'")

    # Delete old pipelines
    pipeline_ids.each do |pipeline_id|
      begin
        delete_pipeline(pipeline_id)
        @log.info("Deleted pipeline '#{pipeline_id}'")

      rescue PipelineDeployerError => error
        @log.warn(error)
      end
    end

  end

  def self.existing_pipelines(pipeline_name)
    @data_pipelines.pipelines.select { |p| p.name == pipeline_name }.map(&:id)
  end

  def self.create_pipeline(pipeline_name, definition)
    created_pipeline = @data_pipelines.pipelines.create(unique_id: "#{pipeline_name}-#{Time.now.iso8601}", name: pipeline_name)
    created_pipeline.put(JSON.parse(definition)['objects'])
    created_pipeline.activate

    created_pipeline.id
  end

  def self.delete_pipeline(pipeline_id)
    @data_pipelines.pipelines.get(pipeline_id).destroy
  end
end

class S3Deployer
  @log = Logger.new(STDOUT)
  @s3 = Fog::Storage::AWS.new
  
  def self.copy_dir(local_path, s3_bucket_name, s3_prefix)
    s3_bucket = @s3.directories.get(s3_bucket_name)
    Dir["bin/*"].each do |f|
      key = s3_prefix + File.basename(f)
      @log.info("uploading #{f} to s3://#{s3_bucket_name}/#{key}")
      s3_file = s3_bucket.files.create(
        :key    => key,
        :body   => File.open(f)
      )
    end
  end
end
