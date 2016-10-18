# frozen_string_literal: true
require 'serverspec'

# manually determine if the platform is Windows or not
# Serverspec as of v2.24 cannot detect the OS family of Windows target hosts
# For reference see https://github.com/serverspec/serverspec/blob/master/WINDOWS_SUPPORT.md
if ENV['OS'] == 'Windows_NT'
  set :backend, :cmd
  # On Windows, set the target host's OS explicitly
  set :os, family: 'windows'
else
  set :backend, :exec
  set :path, '/sbin:/usr/local/sbin:/usr/sbin:$PATH'
end

def load_properties(properties_filename)
  properties = {}
  File.open(properties_filename, 'r') do |properties_file|
    properties_file.read.each_line do |line|
      line.strip!
      next unless line[0] != '#' && line[0] != '='
      i = line.index('=')
      if i
        properties[line[0..i - 1].strip] = line[i + 1..-1].strip
      else
        properties[line] = ''
      end
    end
  end
  properties
end
