
# ms
*A simple duration parser*

**Importing with [Neon](https://github.com/Belkworks/NEON)**:
```lua
ms = NEON:github('belkworks', 'ms')
```

## API

**ms**: `ms(timestring) -> number`  
Returns a duration in seconds
```lua
ms '1 day, 2 hours, 3 minutes, 4 seconds' -- 93784 seconds
```

## Format

A time string is a series of quantity-unit pairs.  
Valid examples of time strings:

- `1 second`
- `1 seconds`
- `1 day 1 day`
- `1 day 1 second`
- `1 day, 1 seconds`
