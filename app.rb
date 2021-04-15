require 'sinatra/base'
require_relative './lib/thermostat'
require 'json'

class ThermostatApp < Sinatra::Base 
    enable :sessions 

    get '/' do
        File.read('public/index.html')
    end

    get '/temperature' do 
        thermostat = Thermostat.instance
        {
            temperature: thermostat.temperature,
            psm_on: thermostat.in_power_saving_mode?,
            energy_usage: thermostat.energy_usage,
            status: 200
    }.to_json
    end

    post '/temperature' do
        thermostat = Thermostat.instance
        case params[:method]
        when "up"
            thermostat.up 
        when "down"
            thermostat.down 
        when "reset"
            thermostat.reset 
        end
        { status: 200 }.to_json
    end

    post '/power-saving-mode' do
        thermostat = Thermostat.instance 
        if params[:method] == 'on'
            thermostat.psm_on
        else
            thermostat.psm_off
        end
        { status: 200 }.to_json
    end  
    
    run! if app_file == $0
end
