require 'json'
require 'yaml'
require 'tempfile'
require 'thor'
require 'io/console'
require 'pocketops/version'
require 'pocketops/config_generator'
require 'pocketops/config'
require 'pocketops/ansible'
require 'pocketops/inventory'
require 'pocketops/commands'
require 'pocketops/cli'
require 'pocketops/progress'

module Pocketops
  class PocketopsError < StandardError; end

  #if defined?(Rails)
    #class Railtie < Rails::Railtie
      #rake_tasks do
        #load 'tasks/pops.rake'
      #end
    #end
  #end
end
