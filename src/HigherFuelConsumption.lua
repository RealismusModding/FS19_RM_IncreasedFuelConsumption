----------------------------------------------------------------------------------------------------
-- HIGHER FUEL CONSUMPTION
----------------------------------------------------------------------------------------------------
-- Purpose: To increase fuel consumption for all vehicles
-- Author:  reallogger
--
-- Copyright (c) Realismus Modding, 2019
----------------------------------------------------------------------------------------------------

HigherFuelConsumption = {}

HigherFuelConsumption.CONSUMPTION_FACTOR = 3
HigherFuelConsumption.CONSUMPTION_FACTOR_LOW = 2.86 -- resulting at 200% at low setting

local directory = g_currentModDirectory
local modName = g_currentModName

function HigherFuelConsumption:loadMap(name)
end

function HigherFuelConsumption:loadSavegame()
end

function HigherFuelConsumption:saveSavegame()
end

function HigherFuelConsumption:update(dt)
end

function HigherFuelConsumption:mouseEvent(posX, posY, isDown, isUp, button)
end

function HigherFuelConsumption:keyEvent(unicode, sym, modifier, isDown)
end

function HigherFuelConsumption:draw()
end

function HigherFuelConsumption:delete()
end

function HigherFuelConsumption:deleteMap()
end

function HigherFuelConsumption.inj_loadConsumerConfiguration(vehicle, superFunc, xmlFile, consumerIndex)
    superFunc(vehicle, xmlFile, consumerIndex)

    local consumptionFactor = HigherFuelConsumption.CONSUMPTION_FACTOR
    if g_currentMission.missionInfo.fuelUsageLow then
        consumptionFactor = HigherFuelConsumption.CONSUMPTION_FACTOR_LOW
    end

    local spec = vehicle.spec_motorized
    for i = 1, #spec.consumers do
        if spec.consumers[i].fillType == FillType.DIESEL then
            spec.consumers[i].usage = spec.consumers[i].usage * consumptionFactor
        end
    end
end

function HigherFuelConsumption.installSpecializations()
    Motorized.loadConsumerConfiguration = Utils.overwrittenFunction(Motorized.loadConsumerConfiguration, HigherFuelConsumption.inj_loadConsumerConfiguration)
end

addModEventListener(HigherFuelConsumption)

VehicleTypeManager.validateVehicleTypes = Utils.prependedFunction(VehicleTypeManager.validateVehicleTypes, HigherFuelConsumption.installSpecializations)
