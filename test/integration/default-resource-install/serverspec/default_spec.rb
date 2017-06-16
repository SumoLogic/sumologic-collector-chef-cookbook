# frozen_string_literal: true

require 'spec_helper'

sumo_dir = os[:family] == 'windows' ? 'c:\sumo' : '/opt/SumoCollector'

describe file("#{sumo_dir}/config") do
  it { is_expected.to exist }
end

describe file("#{sumo_dir}/config/user.properties") do
  it { is_expected.to exist }
  its(:content) { is_expected.to match(/accessid=00000000000/) }
  its(:content) { is_expected.to match(/accesskey=0000000000000000000000000/) }
end
