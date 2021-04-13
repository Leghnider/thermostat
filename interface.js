$(document).ready(function() {
    var thermostat = new Thermostat();
    updateTemperature();


    $('#temperature-up').on('click', function(){
        thermostat.up();
        updateTemperature();
    })

    $('#temperature-down').on('click', function(){
        thermostat.down();
        updateTemperature();
    })

    $('#temperature-reset').on('click', function(){
        thermostat.resetTemperature();
        updateTemperature();
    })

    $('#psm-on').on('click', function(){
        thermostat.switchPowerSavingModeOn();
        $('#power-saving').text('on');
    })

    $('#psm-off').on('click', function(){
        thermostat.switchPowerSavingModeOff();
        $('#power-saving').text('off');
    })

    function updateTemperature() {
        $('#temperature').text(thermostat.temperature)
        $('#temperature').attr('class', thermostat.energyUsage());
    }
})
