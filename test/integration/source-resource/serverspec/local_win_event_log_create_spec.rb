# frozen_string_literal: true

require 'spec_helper'

describe file('/etc/sumo.json/local_win_event_log.json') do
  it { is_expected.to exist }

  its(:content) { is_expected.not_to match(/"eventFormat":/) }
  its(:content) { is_expected.not_to match(/"eventMessage":/) }
  its(:content) { is_expected.not_to match(/"allowlist":/) }
  its(:content) { is_expected.not_to match(/"denylist":/) }
end
