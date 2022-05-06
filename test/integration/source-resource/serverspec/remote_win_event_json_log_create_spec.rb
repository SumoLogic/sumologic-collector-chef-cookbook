# frozen_string_literal: true

require 'spec_helper'

describe file('/etc/sumo.json/remote_win_event_json_log.json') do
  it { is_expected.to exist }

  its(:content) { is_expected.to match(/"eventFormat": 0/) }
  its(:content) { is_expected.to match(/"eventMessage": 1/) }
  its(:content) { is_expected.to match(/"allowlist": "el1,el2"/) }
  its(:content) { is_expected.to match(/"denylist": "el3,el4"/) }
end
