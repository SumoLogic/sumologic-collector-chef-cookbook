# frozen_string_literal: true

# InSpec tests for source-resource suite

# Syslog source
describe file('/etc/sumo.json/syslog.json') do
  it { should exist }
end

# Local file source
describe file('/etc/sumo.json/local_file.json') do
  it { should exist }
end

# Remote file source
describe file('/etc/sumo.json/remote_file.json') do
  it { should exist }
end

# Script source
describe file('/etc/sumo.json/script.json') do
  it { should exist }
end

# Docker sources
describe file('/etc/sumo.json/docker_stats.json') do
  it { should exist }
end

describe file('/etc/sumo.json/docker_log.json') do
  it { should exist }
end

# Graphite source
describe file('/etc/sumo.json/graphite.json') do
  it { should exist }
end

# Local Windows Event Log source (Linux path for JSON config)
if file('/etc/sumo.json/local_win_event_log.json').exist?
  describe file('/etc/sumo.json/local_win_event_log.json') do
    its('content') { should match(/"eventFormat":/) }
    its('content') { should match(/"eventMessage":/) }
    its('content') { should match(/"allowlist":/) }
    its('content') { should match(/"denylist":/) }
  end
end

# Remote Windows Event Log source (Linux path for JSON config)
if file('/etc/sumo.json/remote_win_event_log.json').exist?
  describe file('/etc/sumo.json/remote_win_event_log.json') do
    its('content') { should match(/"eventFormat":/) }
    its('content') { should match(/"eventMessage":/) }
    its('content') { should match(/"allowlist":/) }
    its('content') { should match(/"denylist":/) }
  end
end
