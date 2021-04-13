'use strict';

describe('Thermostat', function () {
    var thermostat;

    beforeEach( function() {
        thermostat = new Thermostat ();
    });

    it('starts at 20 degrees', function(){
        expect(thermostat.getCurrentTemperature()).toEqual(20);
    });

    it('increases temperature with up()', function(){
        thermostat.up();
        expect(thermostat.getCurrentTemperature()).toEqual(21);
    });

    it('decreases temperature with down()', function(){
        thermostat.down();
        expect(thermostat.getCurrentTemperature()).toEqual(19);
    });

    it('sets minimum of 10 degrees', function() {
        for (var i = 0; i < 11; i++) {
            thermostat.down();
        }
        expect(thermostat.getCurrentTemperature()).toEqual(10);
    });

    it('has power saving mode on by default', function() {
        expect(thermostat.isPowerSavingModeOn()).toBe(true);
    });

    it('can switch power saving mode off', function(){
        thermostat.switchPowerSavingModeOff();
        expect(thermostat.isPowerSavingModeOn()).toBe(false);
    });

    it('can switch power saving mode on', function(){
        thermostat.switchPowerSavingModeOff();
        expect(thermostat.isPowerSavingModeOn()).toBe(false);

        thermostat.switchPowerSavingModeOn();
        expect(thermostat.isPowerSavingModeOn()).toBe(true);
    });

    describe('when power saving mode is on', function(){
        it('has max temp of 25', function() {
            for (var i = 0; i < 6; i++) {
                thermostat.up();
            }
            expect(thermostat.getCurrentTemperature()).toEqual(25);
        });
    });

    describe('when power saving mode is off', function (){
        it('has a max temp of 32', function() {
            thermostat.switchPowerSavingModeOff();
            for (var i = 0; i < 13; i++) {
                thermostat.up();
            }
            expect(thermostat.getCurrentTemperature()).toEqual(32);
        })
    });

    it('can be reset to the default temp', function(){
        for (var i = 0; i < 6; i++) {
            thermostat.up();
        }
        thermostat.resetTemperature();
        expect(thermostat.getCurrentTemperature()).toEqual(20);
    });

    describe('displaying usage levels', function(){
        describe('when temperature is below 18 degrees', function() {
            it('is considered to be low-usage', function() {
                for (var i = 0; i < 3; i++) {
                    thermostat.down();
                }
                expect(thermostat.energyUsage()).toEqual('low-usage');
            });
        });

        describe('when temperature is between 18 and 25 degrees', function() {
            it('is considered to be medium-usage', function() {
                expect(thermostat.energyUsage()).toEqual('medium-usage');
            });
        });

        describe('when temperature is greater than 25 degrees', function() {
            it('is considered to be high-usage', function() {
                thermostat.switchPowerSavingModeOff();
                for (var i = 0; i < 6; i++) {
                    thermostat.up();
                }
                expect(thermostat.energyUsage()).toEqual('high-usage');
            });
        });
    });
});