require 'serverspec'

set :backend, :exec
set :path, '/sbin:/usr/local/sbin:/usr/sbin:$PATH'
