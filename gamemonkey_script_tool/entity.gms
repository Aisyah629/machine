-- entity.gms
-- Entity and component definitions

class Entity
{
    public function Entity(name)
    {
        this.name = name;
        this.components = {};
    }

    public function addComponent(component)
    {
        table.insert(this.components, component);
    }

    public function start()
    {
        foreach(component in this.components) do
            component:start();
        end
    }

    public function stop()
    {
        foreach(component in this.components) do
            component:stop();
        end
    }

    public function update()
    {
        foreach(component in this.components) do
            component:update();
        end
    }

    public function render()
    {
        foreach(component in this.components) do
            component:render();
        end
    }

    public function getName()
    {
        return this.name;
    }
}
