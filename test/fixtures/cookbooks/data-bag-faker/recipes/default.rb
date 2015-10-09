Chef::Log.warn('***************** Creating a fake Data Bag with real Sumo key')

sumo_access_id = node['SUMO_ACCESS_ID'] # set in .kitchen.yml
sumo_access_id_var = '<@SUMO_ACCESS_ID@>'
sumo_access_key = node['SUMO_ACCESS_KEY'] # set in .kitchen.yml
sumo_access_key_var = '<@SUMO_ACCESS_KEY@>'

BAG_PATH = Chef::Config[:data_bag_path]
TARGET_BAG = 'sumo-creds/api-creds.json'
BAG_FILE = BAG_PATH + '/' + TARGET_BAG
BACKUP_FILE = BAG_FILE + '.old'

edit_file = Chef::Util::FileEdit.new(BAG_FILE)
edit_file.search_file_replace(sumo_access_id_var, sumo_access_id)
edit_file.search_file_replace(sumo_access_key_var, sumo_access_key)
edit_file.write_file

File.delete(BACKUP_FILE) if File.exist?(BACKUP_FILE) # FileEdit creates, but does not remove, a backup file.
