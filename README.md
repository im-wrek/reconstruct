# Reconstruct
A fast, usable module for reconstructing (decompiling) data-types ( see supported data-types [here](./types) )

# Documentation
## Creation
### Reconstruct.new(`ReconstructorOptions`: [ReconstructorOptions](#reconstructoroptions)): [Reconstructor](#Methods)

Returns a `Reconstructor` object

----

### ReconstructorOptions

  |Option|Value|Default|Information|
  |-------------|-------------|-------------|-------------|
  |IsClient|boolean[^1]|true|Changes the behavior of how Instances are found by using `Instance:WaitForChild()` instead of directly indexing the Instance|
  |AppendVariable|boolean[^1]|false|Decides whether `local output` is appended to the output or not|
  |VariableNames|string[^2]|%type_|Formats reconstructed data-types variable names. To use this, you need to include "%type" in your value.|
  |WrapKeysInBrackets|boolean[^1]|true|Decides whether numbered keys in tables are wrapped in brackets `[]` or not|
  |ReconstructInstances|boolean[^1]|true|Decides whether data-types that use `Instance`s (such as [CatalogSearchParams](./types/CatalogSearchParams.lua)) will be reconstructed or not|


## Properties
### `Reconstructor.Options`: [ReconstructorOptions](#reconstructoroptions)
----
## Methods

### Reconstructor:Reconstruct(`...: any`): `string`
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
----
## Installation
### [Creator Store](https://create.roblox.com/store/asset/17385700566)
### [rbxm file](https://github.com/im-wrek/reconstruct/raw/main/Reconstruct.rbxm)
----

> [!NOTE]
> This module does NOT fully reconstruct some data-types, I plan to add support for most or if not all data-types.
>
> To add your own (or modify existing data-types), follow [this](./AYO.md) guide.

[^1]: true or false
[^2]: anything with double-quotes, single-quotes or backticks, see [strings](https://create.roblox.com/docs/luau/strings)
