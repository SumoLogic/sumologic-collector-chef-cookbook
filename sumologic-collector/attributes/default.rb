#
# Author:: Ben Newton (<ben@sumologic.com>)
# Cookbook Name:: sumologic-collector
# Recipe:: Default Recipe Attributes
#
# Copyright 2013, Sumo Logic
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#


# default sumocollector attributes



#Collector Activation User Credentials
default['sumologic']['userID']    = "YOUR_EMAIL"
default['sumologic']['password']  = "YOUR_PASSWORD"


#Ephemeral node (collector config deleted after 2 days of no heartbeat - data is not deleted from Sumo Logic)
default['sumologic']['ephemeral'] = "true"

#Default Time Zone for Sources
default['sumologic']['sources']['default_timezone'] = "UTC"

#Platform Specific Attributes
case platform
    # Currently have all linux variants using the scripted installer
    when "redhat", "centos", "scientific", "fedora", "suse", "amazon", "oracle", "debian", "ubuntu"
        #Install Path
        default['sumologic']['installDir']     = "/opt/SumoCollector"
    
        #Installer Name
        default['sumologic']['installerName'] = node['kernel']['machine'] =~ /^i[36']86$/ ? "SumoCollector_linux32.sh" : "SumoCollector_linux64.sh"
    
        #Install Command
        default['sumologic']['installerCmd'] = "sh #{default['sumologic']['installerName']} -q -dir #{default['sumologic']['installDir']}"
    
        #Download Path - Either 32bit or 64bit according to the architecture
        default['sumologic']['downloadURL'] = node['kernel']['machine'] =~ /^i[36']86$/ ? "https://collectors.sumologic.com/rest/download/linux/32" : "https://collectors.sumologic.com/rest/download/linux/64"
    
    else
        #Just have empty install commands for now as a placeholder
    
        #Install Path
        default['sumologic']['installDir']     = "/opt/SumoCollector"
        
        #Installer Name - Either 32bit or 64bit according to the architecture
        default['sumologic']['installerName'] = ""
        
        #Install Command
        default['sumologic']['installerCmd'] = ""
    
        #Download Path - Either 32bit or 64bit according to the architecture
        default['sumologic']['downloadURL'] = ""
    
end

