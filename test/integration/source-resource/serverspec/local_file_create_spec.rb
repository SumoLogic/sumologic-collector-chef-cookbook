require 'spec_helper'

describe file('/etc/sumo.json/local_file.json') do
  it { is_expected.to exist }
end
