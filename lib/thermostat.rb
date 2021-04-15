class Thermostat
    DEFAULT_TEMP = 20

    attr_reader :temperature

    def initialize
        @temperature = DEFAULT_TEMP
        @powersaving = true
    end

    def up
        @temperature += 1 unless maximum_reached?
    end

    def down
        @temperature -= 1 unless minimum_reached?
    end

    def reset 
        @temperature = DEFAULT_TEMP
    end

    def psm_off
        @powersaving = false 
    end

    def psm_on
        @powersaving = true 
    end

    def in_power_saving_mode?
        @powersaving 
    end

    def self.instance
        @thermostat ||= self.new
    end

    def energy_usage
        if temperature < 18
            return :low
        elsif temperature < 25
            return :medium
        end 
        return :high 
    end

    def update(temperature)
        @temperature = temperature
    end

    private 

  

    def maximum_reached?
        if in_power_saving_mode?
            temperature >= 25
        else
            temperature == 32
        end
    end

    def minimum_reached?
        temperature == 10
    end
end