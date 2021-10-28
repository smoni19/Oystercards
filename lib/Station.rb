module Station

attr_reader :name, :zone

    def initialize(name, zone)
        @name = name
        @zone = zone
    end

    def list_zones
        @zones = {
            :zone1 => ["a", "b"],
            :zone2 => ["c", "d"],
            :zone3 => ["e", "f"]
        }
        #@zones = [
        #    {:zone1 => "a"},
        #    {:zone2 => "b"},
        #    {:zone3 => "c"},
        #    {:zone4 => "d"}
        #]
    end

end

