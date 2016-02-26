require 'spec_helper'

describe file('/etc/sumo.json/local_win_event_log.json') do
  it { is_expected.to exist }
end
