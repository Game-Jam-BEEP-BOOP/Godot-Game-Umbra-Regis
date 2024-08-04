extends Node
#author Ed

var deaths : int = 0

var maxShadow: float = 100
var maxHealth: float = 100
var currentShadow: float = maxShadow
var currentHealth: float = maxHealth


# temp items for inventory tests
var stored_items = {"phantom_steel": 1, "queen_of_the_night": 2}   #  "steel": 3
var inventory_slot = {} #  "steel": 1

var slot_assignment = {
	"slot1": false,
	"slot2": false,
	"slot3": false,
	"slot4": false,
	"slot5": false,
	"slot6": false,
	"slot7": false,
	"slot8": false,
	"slot9": false,
	"slot10": false,
	"slot11": false,
	"slot12": false,
	"slot13": false,
	"slot14": false,
	"slot15": false,
	"slot16": false,
	"slot17": false,
	"slot18": false
	}
