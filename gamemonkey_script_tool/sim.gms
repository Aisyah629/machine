-- sim.gms
-- Core simulation logic

class Simulation
{
    public function Simulation()
    {
        this.entities = {};
        this.running = false;
    }

    public function addEntity(entity)
    {
        table.insert(this.entities, entity);
    }

    public function removeEntity(entity)
    {
        local idx = table.find(this.entities, entity);
        if (idx ~= nil) then
            table.remove(this.entities, idx);
        end
    }

    public function start()
    {
        this.running = true;
        foreach(entity in this.entities) do
            entity:start();
        end
    }

    public function stop()
    {
        this.running = false;
        foreach(entity in this.entities) do
            entity:stop();
        end
    }

    public function update()
    {
        if (not this.running) return;
        foreach(entity in this.entities) do
            entity:update();
        end
    }

    public function render()
    {
        if (not this.running) return;
        foreach(entity in this.entities) do
            entity:render();
        end
    }
}
