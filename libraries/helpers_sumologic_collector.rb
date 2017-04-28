# frozen_string_literal: true

require 'json'

module SumologicCollector
  # A set of helper methods for monitoring the registration status of a
  # sumologic_collector resource.
  class Helpers
    class << self
      #
      # Monitor a specified Sumo directory and wait X number of seconds for a
      # successful registration.
      #
      # @param dir [String] the main Sumo directory
      # @param retries [Integer] the number of times to retry before failing
      # @raise [Chef::Exceptions::Service] if registration fails or times out
      #
      def wait_for_registration(dir, retries = 30)
        (1..retries).each do
          case registration_status(dir)
          when true then registration_succeeded! && return
          when false then registration_failed!
          else registration_pending!
          end
        end
        registration_timed_out!
      end

      #
      # Return true if registration has succeeded, false if it failed, or nil
      # if we can't tell. Default to checking for a .installerResult file and
      # fallback to checking the collector.log, as the collector doesn't create
      # .installerResult if it was started by the Sumo installer script.
      #
      # @param dir [String] the main Sumo directory
      # @return [TrueClass,FalseClass,NilClass] success, failure, or unknown
      #
      def registration_status(dir)
        result = result_status(dir)
        return result unless result.nil?
        log_status(dir)
      end

      #
      # Check for a .installerResult file and return true if registration has
      # succeeded, false if it failed, or nil if we can't tell.
      #
      # @param dir [String] the main Sumo directory
      # @return [TrueClass,FalseClass,NilClass] success, failure, or unknown
      #
      def result_status(dir)
        file = File.join(dir, 'config/.installerResult')
        JSON.parse(File.read(file))['success'] if File.exist?(file)
      end

      #
      # Check the collector.log file for registration status and return true if
      # registration has succeeded, false if it failed, or nil if we can't
      # tell.
      #
      # @param dir [String] the main Sumo directory
      # @return [TrueClass,FalseClass,NilClass] success, failure, or unknown
      #
      def log_status(dir)
        file = File.join(dir, 'logs/collector.log')
        return nil unless File.exist?(file)
        status = File.read(file).lines.find do |l|
          l.include?('Notifying installer of registration result: ' \
                     'RegistrationResult(')
        end
        return nil unless status
        return true if status.include?('RegistrationResult(true,')
        return false if status.include?('RegistrationResult(false,')
      end

      #
      # Log an informational message and wait for the next retry attempt.
      #
      def registration_pending!
        Chef::Log.info('Waiting for Sumo Collector to register...')
        sleep(1)
      end

      #
      # Log the registration success and give the collector a couple seconds to
      # release its hold on the user.properties file before continuing.
      #
      def registration_succeeded!
        Chef::Log.info('Sumo Collector registered successfully.')
        sleep(2)
      end

      #
      # Log an error message and raise an exception.
      #
      # @raise [Chef::Exceptions::Service] registration failed
      #
      def registration_failed!
        raise(Chef::Exceptions::Service,
              'Sumo Collector registration failed!')
      end

      #
      # Log an error message and raise an exception.
      #
      # @raise [Chef::Exceptions::Service] registration timed out
      #
      def registration_timed_out!
        raise(Chef::Exceptions::Service,
              'Timed out waiting for Sumo Collector registration!')
      end
    end
  end
end
