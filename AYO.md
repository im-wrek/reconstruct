This is a guide to add/edit data-types.
> [!NOTE]
> The most used data-types are already supported but if you still need to add one, use this as a guide

## Add Your Own Data-Type

### Step 1
Create a `ModuleScript`[^1] parented under the `types` folder


![image](https://github.com/im-wrek/reconstruct/assets/87952649/84d87970-a693-419c-a141-334c9071a84f)
### Step 2
Name the new `ModuleScript` whatever type you want it to be (e.g, `Color3`[^2], `table`[^3], etc.)

![Animation](https://github.com/im-wrek/reconstruct/assets/87952649/ed430b25-9522-45bb-966c-b9035dcda1dd)

### Step 3
Paste  this code into the `ModuleScript` to use as a template :
```lua
return function(options: {}, a: Color3, excludeLocal: boolean): string
	local source = not (excludeLocal or (not (options['AppendVariable']) or false)) and `local output = Color3.new(` or `Color3.new(`

	return source
end
```

### Additional Information
If the data-type uses `.new()` (e.g. `CatalogSearchParams.new()`), add an attribute named "VariableRequired" and set it to `true`


![Animation2](https://github.com/im-wrek/reconstruct/assets/87952649/52caa51a-635b-4573-a7fd-d8e742afbeb9)


[^1]: A type of `Script` that returns any value. In this case, `function`s ( see documentation [here](https://create.roblox.com/docs/reference/engine/classes/ModuleScript) ) 
[^2]: A type that Roblox uses for coloring objects, UI, etc. ( see documentation [here](https://create.roblox.com/docs/reference/engine/datatypes/Color3) ) 
