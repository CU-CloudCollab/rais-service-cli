require_relative '../lib/microservice'

class ServiceTwo < Microservice

  def initialize

    options = {}

    options[:aws_region] = 'us-east-1'
    options[:aws_cluster_name] = 'TEST-CLUSTER'
    options[:aws_service_name] = 'SERVICE-TWO'

    options[:docker_registry_server] = 'docker.registry.com'
    options[:docker_registry_username] = ENV['REGISTRY_USERNAME']
    options[:docker_registry_password] = ENV['REGISTRY_PASSWORD']
    options[:docker_registry_repository] = 'repo/service-two'

    options[:docker_local_repository] = 'service-two'
    options[:docker_local_build_path] = '/home/user/projects/service-two'
    options[:docker_local_build_container_name] = 'service-two'

    options[:cli_service_code] = "service-two"

    super(options)

  end


end
