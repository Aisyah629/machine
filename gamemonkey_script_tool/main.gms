-- main.gms
-- Main entry point for the GameMonkey Script Simulation Engine

import "sim.gms";
import "entity.gms";
import "event.gms";

function main()
{
    local sim = Simulation:new();
    local entity1 = Entity:new("Player");
    local entity2 = Entity:new("Enemy");

    sim:addEntity(entity1);
    sim:addEntity(entity2);

    sim:start();

    for i = 0, 10 do
        sim:update();
        sim:render();
        io.write("Simulation step: " .. i .. "\n");
    end

    sim:stop();

    return 0;
}

if (_SCRIPTNAME == nil or _SCRIPTNAME == "main.gms") then
    main();
end
