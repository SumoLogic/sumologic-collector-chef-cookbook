require 'spec_helper'

describe 'sumologic_source_test::create_default' do
  cached(:chef_run) do
    runner = ChefSpec::SoloRunner.new step_into: ['sumologic_source']
    runner.converge described_recipe
  end
  subject { chef_run }

  it { is_expected.to include_recipe 'sumologic_source_test::create_default' }
  it { is_expected.to create_directory ::File.dirname '/etc/sumo.d/sumo.json' }
  it { is_expected.to create_template '/etc/sumo.d/sumo.json' }
  it { is_expected.to create_sumologic_source '/etc/sumo.d/sumo.json' }
end
