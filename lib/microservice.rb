require 'rais_ecs'

# Microservice - A class to wrap the ecs api library for a specific service, and serve as
# a factory for api methods

# @author Brett Haranin

class Microservice

  # @return [String] Local service name (friendly name for CLI)
  attr_reader :cli_service_code

  # Constructor for Microservice wrapper
  # @param options [Hash] Options Hash
  # @option options [String] :aws_region AWS Region Name
  # @option options [String] :aws_cluster_name AWS Cluster Name
  # @option options [String] :aws_service_name AWS Service Name
  # @option options [String] :docker_registry_server Docker Registry Server
  # @option options [String] :docker_registry_username Docker Registry Username
  # @option options [String] :docker_registry_password Docker Registry Password
  # @option options [String] :docker_registry_repository Repository on Registry
  # @option options [String] :docker_local_repository Repository on Local Docker
  # @option options [String] :docker_local_build_path Local location of docker-compose.yml
  # @option options [String] :docker_local_build_container_name Name of container in docker-compose.yml
  # @option options [String] :cli_service_code Service Code

  def initialize(options)

    @aws_region = options[:aws_region]

    @aws_cluster_name = options[:aws_cluster_name]
    @aws_service_name = options[:aws_service_name]
    @aws_container_name = options[:aws_container_name]

    @docker_registry_server = options[:docker_registry_server]
    @docker_registry_username = options[:docker_registry_username]
    @docker_registry_password = options[:docker_registry_password]
    @docker_registry_repository = options[:docker_registry_repository]

    @docker_local_repository = options[:docker_local_repository]
    @docker_local_build_path = options[:docker_local_build_path]
    @docker_local_build_container_name = options[:docker_local_build_container_name]

    @cli_service_code = options[:cli_service_code]

  end

  # Get an instance of the Cloud object
  # @return [RaisEcs:Cloud]

  def get_cloud
    return RaisEcs::Cloud.new
  end

  # Get an instance of the Cluster object
  # @return [RaisEcs:Cluster]

  def get_cluster
    cloud = self.get_cloud
    ecs_manager = RaisEcs::EcsManager.new(cloud: cloud)
    cluster = ecs_manager.get_cluster_by_name(@aws_cluster_name)

    return cluster
  end

  # Get an instance of the remote repository object
  # @return [RaisEcs::RegistryImageRepository]

  def get_remote_repository

    remote_repository = RaisEcs::RegistryImageRepository.new(
      registry_server: @docker_registry_server,
      repository_name: @docker_registry_repository,
      repository_username: @docker_registry_username,
      repository_password: @docker_registry_password
    )

    return remote_repository

  end

  # Get an instance of the local repository object
  # @return [RaisEcs::LocalImageRepository]

  def get_local_repository
    local_repository = RaisEcs::LocalImageRepository.new({repository_name: @docker_local_repository})
    return local_repository
  end

  # Get an instance of the service object
  # @return [RaisEcs::Service]

  def get_service
    cluster = self.get_cluster
    service = cluster.get_service_by_name(@aws_service_name)
    return service
  end

  # Get an instance of ECS Manager
  # @return [RaisEcs::EcsManager]

  def get_ecs_manager
    ecs_manager = RaisEcs::EcsManager.new(cloud: self.get_cloud)
  end


  # Utility method to invoke docker-compose build command and provide a place for override to implement multi-step builds
  def build
    build_command = "cd #{@docker_local_build_path} && docker-compose build #{@docker_local_build_container_name}"
    system build_command
  end

end
