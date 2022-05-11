# frozen_string_literal: true

EVENT_FORMAT = {
  nil => nil,
  :legacy => 0,
  :json => 1
}.freeze

EVENT_MESSAGE = {
  nil => nil,
  :complete => 0,
  :message => 1,
  :metadata => 2
}.freeze
