require 'spec_helper'

describe 'sumologic_source_test::delete_default' do
  cached(:chef_run) do
    runner = ChefSpec::SoloRunner.new step_into: ['sumologic_source']
    runner.converge described_recipe
  end
  subject { chef_run }

  it { is_expected.to include_recipe 'sumologic_source_test::delete_default' }

  it do
    is_expected.to_not delete_directory ::File.dirname '/etc/sumo.d/sumo.json'
  end

  it { is_expected.to delete_file '/etc/sumo.d/sumo.json' }
  it { is_expected.to delete_sumologic_source '/etc/sumo.d/sumo.json' }
end
