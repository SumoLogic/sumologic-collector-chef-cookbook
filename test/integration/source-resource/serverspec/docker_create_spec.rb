require 'spec_helper'

describe file('/etc/sumo.json/docker_stats.json') do
  it { is_expected.to exist }
end

describe file('/etc/sumo.json/docker_log.json') do
  it { is_expected.to exist }
end
