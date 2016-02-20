case node['platform_family']
when 'windows'

  sumologic_collector_installer 'c:\sumo' do
    source 'https://collectors.sumologic.com/rest/download/win64'
    sumo_access_id node['SUMO_ACCESS_ID']
    sumo_access_key node['SUMO_ACCESS_KEY']
    skip_registration true
  end
  
else

  sumologic_collector_installer '/opt/SumoCollector' do
    source 'https://collectors.sumologic.com/rest/download/linux/64'
    sumo_access_id node['SUMO_ACCESS_ID']
    sumo_access_key node['SUMO_ACCESS_KEY']
    skip_registration true
  end
  
end
