.PHONY: test
test:
	bundle install
	bundle exec rubocop --version
	bundle exec rubocop
	bundle exec foodcritic --version
	bundle exec foodcritic . --exclude spec
