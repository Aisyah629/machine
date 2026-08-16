// main.moo - MOO Virtual World Engine

// Object Base Class
object base_object
{
    name = "Unknown Object",
    description = "An unknown object.",
    contents = [],
    parent = null,

    set_name(new_name)
    {
        this.name = new_name;
    },

    set_description(new_desc)
    {
        this.description = new_desc;
    },

    move_to(new_parent)
    {
        if (this.parent)
        {
            remove_from_list(this.parent.contents, this);
        }
        this.parent = new_parent;
        if (new_parent)
        {
            new_parent.contents = add_to_list(new_parent.contents, this);
        }
    },

    get_contents()
    {
        return this.contents;
    }
}

// Player Object
object player : base_object
{
    name = "Player",
    description = "A player character.",
    home_location = null,
    current_location = null,

    move_to(new_parent)
    {
        if (this.current_location)
        {
            remove_from_list(this.current_location.contents, this);
        }
        this.current_location = new_parent;
        if (new_parent)
        {
            new_parent.contents = add_to_list(new_parent.contents, this);
        }
    },

    get_location()
    {
        return this.current_location;
    }
}

// Command Parser
function parse_command(user_input)
{
    if (user_input == "look")
    {
        // Return current room description
        return "You are in a room."
    }
    else if (user_input == "help")
    {
        return "Commands: look, go <direction>"
    }
    else
    {
        return "Unknown command."
    }
}

// Initialize Game World
player home = new_player_object();
player home.set_name("Alice");
player home.home_location = "main_room";
player home.current_location = "main_room";

// Start Command Loop
while (true)
{
    input = get_user_input();
    response = parse_command(input);
    print(response);
}

// Helper Functions
function new_player_object()
{
    p = new player();
    return p;
}
