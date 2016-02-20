require 'win_helper'

describe file('C:/sumo') do
  it { is_expected.to exist }
end
