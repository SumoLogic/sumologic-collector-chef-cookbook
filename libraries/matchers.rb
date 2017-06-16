# frozen_string_literal: true

if defined?(ChefSpec)
  #####################
  # sumologic_collector
  #####################
  ChefSpec.define_matcher :sumologic_collector

  def install_sumologic_collector(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:sumologic_collector, :install, resource_name)
  end

  def configure_sumologic_collector(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:sumologic_collector, :configure, resource_name)
  end

  def install_and_configure_sumologic_collector(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:sumologic_collector, :install_and_configure, resource_name)
  end

  def start_sumologic_collector(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:sumologic_collector, :start, resource_name)
  end

  def stop_sumologic_collector(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:sumologic_collector, :stop, resource_name)
  end

  def restart_sumologic_collector(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:sumologic_collector, :restart, resource_name)
  end

  def enable_sumologic_collector(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:sumologic_collector, :enable, resource_name)
  end

  def disable_sumologic_collector(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:sumologic_collector, :disable, resource_name)
  end

  def remove_sumologic_collector(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:sumologic_collector, :remove, resource_name)
  end
end
