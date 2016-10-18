# frozen_string_literal: true
require 'spec_helper'

sumo_dir = os[:family] == 'windows' ? 'c:\sumo' : '/opt/SumoCollector'

describe file("#{sumo_dir}/config") do
  it { is_expected.to exist }
end
