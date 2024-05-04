## Reconstruct
A fast, usable module for reconstructing data-types ( see supported data-types [here]() )

REMINDER: This module does NOT fully reconstruct some data-types, I plan to add support for most or if not all data types. You can add your own also and if you have suggestions shoot me a dm (im.wrek on Discord)

### ReconstructorOptions
`IsClient` `boolean`

### Reconstruct.new(ReconstructorOptions: [ReconstructorOptions](#reconstructoroptions)): #reconstructor:reconstruct(...: any):string
Returns a `Reconstructor` object

### Reconstructor:Reconstruct(...: any): string
Reconstructs objects

Example
```lua
local module = require(path.to.module)

local options = {
  IsClient = false, -- this only changes WaitForChild when Instances in tables are "reconstructed".
  AppendVariable = true -- decides whether "local output = " is appended or not
}

local Reconstructor = module.new(options)

local Reconstruct = Reconstructor:Reconstruct({["User"] = {AccountAge = 14, Gold = 5, Location = Vector3.new(1, 1, 1), Spawn = game.Workspace.SpawnLocation}})

print(Reconstruct)
--[[
outputs
local output = {
  ["User"] = {
    ["Location"] = Vector3.new(1, 1, 1),
    ["Spawn"] = workspace.SpawnLocation,
    ["Gold"] = 5,
    ["AccountAge"] = 14,
  },
}
--]]
```
