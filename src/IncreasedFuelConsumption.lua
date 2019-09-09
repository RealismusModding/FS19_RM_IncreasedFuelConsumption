----------------------------------------------------------------------------------------------------
-- INCREASED FUEL CONSUMPTION
----------------------------------------------------------------------------------------------------
-- Purpose: To increase fuel consumption for all vehicles
-- Author:  reallogger
--
-- Copyright (c) Realismus Modding, 2019
----------------------------------------------------------------------------------------------------

IncreasedFuelConsumption = {}

IncreasedFuelConsumption.CONSUMPTION_FACTOR = 3
IncreasedFuelConsumption.CONSUMPTION_FACTOR_LOW = 2.86 -- resulting at 200% at low setting

local directory = g_currentModDirectory
local modName = g_currentModName

function IncreasedFuelConsumption:loadMap(name)
end

function IncreasedFuelConsumption:loadSavegame()
end

function IncreasedFuelConsumption:saveSavegame()
end

function IncreasedFuelConsumption:update(dt)
end

function IncreasedFuelConsumption:mouseEvent(posX, posY, isDown, isUp, button)
end

function IncreasedFuelConsumption:keyEvent(unicode, sym, modifier, isDown)
end

function IncreasedFuelConsumption:draw()
end

function IncreasedFuelConsumption:delete()
end

function IncreasedFuelConsumption:deleteMap()
end

function IncreasedFuelConsumption.inj_loadConsumerConfiguration(vehicle, superFunc, xmlFile, consumerIndex)
    superFunc(vehicle, xmlFile, consumerIndex)

    local consumptionFactor = IncreasedFuelConsumption.CONSUMPTION_FACTOR
    if g_currentMission.missionInfo.fuelUsageLow then
        consumptionFactor = IncreasedFuelConsumption.CONSUMPTION_FACTOR_LOW
    end

    local spec = vehicle.spec_motorized
    for i = 1, #spec.consumers do
        if spec.consumers[i].fillType == FillType.DIESEL then
            spec.consumers[i].usage = spec.consumers[i].usage * consumptionFactor
        end
    end
end

function IncreasedFuelConsumption.installSpecializations()
    Motorized.loadConsumerConfiguration = Utils.overwrittenFunction(Motorized.loadConsumerConfiguration, IncreasedFuelConsumption.inj_loadConsumerConfiguration)
end

addModEventListener(IncreasedFuelConsumption)

VehicleTypeManager.validateVehicleTypes = Utils.prependedFunction(VehicleTypeManager.validateVehicleTypes, IncreasedFuelConsumption.installSpecializations)
