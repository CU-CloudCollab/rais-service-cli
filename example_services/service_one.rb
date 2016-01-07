require_relative '../lib/microservice'

class ServiceOne < Microservice

  def initialize

    options = {}

    options[:aws_region] = 'us-east-1'
    options[:aws_cluster_name] = 'TEST-CLUSTER'
    options[:aws_service_name] = 'SERVICE-ONE'

    options[:docker_registry_server] = 'docker.registry.com'
    options[:docker_registry_username] = ENV['REGISTRY_USERNAME']
    options[:docker_registry_password] = ENV['REGISTRY_PASSWORD']
    options[:docker_registry_repository] = 'repo/service-one'

    options[:docker_local_repository] = 'service-one'
    options[:docker_local_build_path] = '/home/user/projects/service-one'
    options[:docker_local_build_container_name] = 'service-one'

    options[:cli_service_code] = "service-one"

    super(options)

  end


end
