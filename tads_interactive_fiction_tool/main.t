/**
 * TADS Interactive Fiction Tool - Main Entry Point
 * Language: TADS
 * 
 * This module demonstrates the core structure for a TADS interactive fiction game.
 * It includes room definitions, object interactions, and parser initialization.
 */

// Game initialization and setup
initGame() {
    // Initialize global game state
    gGameState = {
        turnCount: 0,
        score: 0,
        isPlaying: true,
        inventory: []
    };
    
    // Setup main parser and narrative engine
    parser = new TADSParser();
    parser.setVerboseMode(false);
    parser.setInteractiveMode(true);
    
    printLine('========================================');
    printLine('  Welcome to the TADS Interactive Fiction Tool');
    printLine('========================================');
    printLine('');
    printLine('Type "help" for commands, or begin exploring...');
    printLine('');
}

/**
 * TADSParser: Core command interpreter
 */
class TADSParser {
    constructor() {
        this.commands = {
            'help': this.showHelp,
            'look': this.lookAround,
            'go': this.moveDirection,
            'take': this.takeItem,
            'drop': this.dropItem,
            'inventory': this.showInventory,
            'quit': this.quitGame
        };
        this.currentRoom = null;
        this.interactiveMode = false;
        this.verboseMode = false;
    }
    
    setInteractiveMode(val) { this.interactiveMode = val; }
    setVerboseMode(val) { this.verboseMode = val; }
    
    processCommand(input) {
        if (!input || input.trim().length === 0) return;
        
        let tokens = input.trim().toLowerCase().split(' ');
        let cmd = tokens[0];
        let args = tokens.slice(1);
        
        if (this.commands[cmd]) {
            this.commands[cmd].apply(this, args);
        } else {
            printLine('Unknown command: "' + cmd + '". Try "help" for available commands.');
        }
    }
    
    showHelp() {
        printLine('Available Commands:');
        printLine('  help        - Show this help message');
        printLine('  look        - Examine the current room');
        printLine('  go <dir>    - Move in a direction (n, s, e, w, u, d)');
        printLine('  take <obj>  - Pick up an item');
        printLine('  drop <obj>  - Drop an item from inventory');
        printLine('  inventory   - Show current inventory');
        printLine('  quit        - Exit the game');
    }
    
    lookAround() {
        if (this.currentRoom) {
            printLine('');
            printLine('*** ' + this.currentRoom.name + ' ***');
            printLine(this.currentRoom.description);
            
            if (this.currentRoom.contents && this.currentRoom.contents.length > 0) {
                printLine('You can see: ' + this.currentRoom.contents.map(obj => obj.name).join(', '));
            }
        } else {
            printLine('There is nothing to see here.');
        }
    }
    
    moveDirection(dir) {
        if (!this.currentRoom) return printLine('You are not currently in a room.');
        
        let exit = this.currentRoom.exits[dir];
        if (exit) {
            this.currentRoom = exit;
            this.lookAround();
        } else {
            printLine('You cannot go that way.');
        }
    }
    
    takeItem(itemName) {
        if (!this.currentRoom || !this.currentRoom.contents) return;
        
        let itemIndex = this.currentRoom.contents.findIndex(obj => obj.name === itemName);
        if (itemIndex > -1) {
            let item = this.currentRoom.contents.splice(itemIndex, 1)[0];
            gGameState.inventory.push(item);
            printLine('Taken.');
        } else {
            printLine('You don\'t see that here.');
        }
    }
    
    dropItem(itemName) {
        let itemIndex = gGameState.inventory.findIndex(obj => obj.name === itemName);
        if (itemIndex > -1) {
            let item = gGameState.inventory.splice(itemIndex, 1)[0];
            if (this.currentRoom) {
                this.currentRoom.contents.push(item);
                printLine('Dropped.');
            } else {
                gGameState.inventory.push(item); // put back if no room context
            }
        } else {
            printLine('You don\'t have that.');
        }
    }
    
    showInventory() {
        if (gGameState.inventory.length === 0) {
            printLine('You are empty-handed.');
        } else {
            printLine('You are carrying: ' + gGameState.inventory.map(obj => obj.name).join(', '));
        }
    }
    
    quitGame() {
        printLine('Thanks for playing!');
        gGameState.isPlaying = false;
        // In a real TADS environment, this would call sys.exit(0)
    }
}

/**
 * Room Definition Class
 */
class Room {
    constructor(name, description) {
        this.name = name;
        this.description = description;
        this.contents = [];
        this.exits = {};
    }
}

/**
 * Item Definition Class
 */
class Item {
    constructor(name, description) {
        this.name = name;
        this.description = description;
    }
}

// Helper output utilities (simulating TADS print library)
function printLine(text) {
    console.log(text);
}

// Initialize and start the game
initGame();

// Example setup (can be expanded with full TADS library features)
let startRoom = new Room('Dark Room', 'A dim, cramped room. There is a door to the north.');
let keyItem = new Item('rusty key', 'An old, tarnished key.');

startRoom.contents.push(keyItem);
startRoom.exits['n'] = new Room('Bright Hall', 'A surprisingly well-lit hallway with polished floors.');

gParser = new TADSParser();
gParser.currentRoom = startRoom;
gParser.lookAround();

// Simulate initial input loop for demonstration
printLine('');
printLine('Enter your first command:');
