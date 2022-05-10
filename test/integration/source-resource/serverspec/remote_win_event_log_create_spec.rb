# frozen_string_literal: true

require 'spec_helper'

describe file('/etc/sumo.json/remote_win_event_log.json') do
  it { is_expected.to exist }

  its(:content) { is_expected.to match(/"eventFormat":/) }
  its(:content) { is_expected.to match(/"eventMessage":/) }
  its(:content) { is_expected.to match(/"allowlist":/) }
  its(:content) { is_expected.to match(/"denylist":/) }
end
