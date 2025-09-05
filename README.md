# MT Gold Panning
Simple gold panning script for FiveM

# Preview
https://youtu.be/a6WEgPNMMUE

# Requirements
ox_inventory
ox_lib
BZzZ Mining props V2 (optional)

# Installation
Just add these items in the ox_inventory/data/items.lua
```lua
	['goldpan'] = {
		label = 'Gold pan',
		weight = 2000,
		stack = false,
		client = {
			export = 'mt_goldpanning.usePanning'
		}
	},
```
