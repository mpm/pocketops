module Pocketops
  class Inventory
    def initialize(servers)
      @servers = servers
    end

    def to_json
      Hash[
        @servers.map do |environment, hosts|
          [environment,
            {
              'hosts': hosts.is_a?(String) ? [hosts] : hosts
            }
          ]
        end
      ].to_json
    end
  end
end
