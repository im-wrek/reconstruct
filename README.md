## Reconstruct
A fast, usable module for reconstructing data-types ( see supported data-types [here](./types) )
> [!NOTE]
> This module does NOT fully reconstruct some data-types, I plan to add support for most or if not all data-types. To add your own, see (this)[./AYO]

### ReconstructorOptions
`IsClient` `boolean`

### Reconstruct.new(ReconstructorOptions: [ReconstructorOptions](#reconstructoroptions)): [Reconstructor](#reconstructorreconstruct-any-string)
Returns a `Reconstructor` object

### Reconstructor:Reconstruct(...: any): string
Reconstructs data-types into a useable, readable format

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
