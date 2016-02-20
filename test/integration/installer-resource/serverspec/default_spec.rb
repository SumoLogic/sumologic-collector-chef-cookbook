require 'spec_helper'

describe file('/opt/SumoCollector/config') do
  it { is_expected.to exist }
end
