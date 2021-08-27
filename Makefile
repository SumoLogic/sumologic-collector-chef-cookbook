.PHONY: test
test:
	bundle install
	bundle exec rubocop --version
	bundle exec rubocop
	bundle exec foodcritic --version
	bundle exec foodcritic . --exclude spec

knife-publish:
	# ensure that chef configuration is in place
	ls .chef
	# list cookbooks
	knife cookbook list
	# upload the sumologic-collector cookbook
	knife cookbook upload --cookbook-path /sumologic sumologic-collector
	# list cookbooks
	knife cookbook list
	# publish the cookbook
	knife supermarket share -o /sumologic sumologic-collector
