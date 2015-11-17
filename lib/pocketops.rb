require 'json'
require 'yaml'
require 'pocketops/version'
require 'pocketops/config'
require 'pocketops/ansible'
require 'pocketops/inventory'

module Pocketops
  class PocketopsError < StandardError; end

  class Railtie < Rails::Railtie
    rake_tasks do
      load 'tasks/pops.rake'
    end
  end
end
