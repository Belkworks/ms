local strtok
strtok = function(str, delim)
  local start, stop = str:find(delim)
  if start then
    local tok = str:sub(0, start - 1)
    local last = str:sub(stop + 1)
    if #last > 0 then
      return tok, last
    else
      return tok
    end
  elseif #str > 0 then
    return str
  end
end
local WORD = ',? +'
local ITEM = ' +'
local peeler
peeler = function(str)
  return function(delim)
    if delim == nil then
      delim = WORD
    end
    if not (str) then
      return 
    end
    local tok
    tok, str = strtok(str, delim)
    return tok
  end
end
local SECOND = 1
local MS = SECOND / 1000
local MINUTE = 60 * SECOND
local HOUR = 60 * MINUTE
local DAY = HOUR * 24
local MONTH = DAY * 30
local YEAR = DAY * 365
local PATCH = {
  [{
    "ms",
    "millisecond",
    "milliseconds"
  }] = MS,
  [{
    "second",
    "seconds",
    "sec",
    "secs"
  }] = SECOND,
  [{
    "minute",
    "minutes",
    "min",
    "mins"
  }] = MINUTE,
  [{
    "hour",
    "hours",
    "hr",
    "hrs"
  }] = HOUR,
  [{
    "day",
    "days"
  }] = DAY,
  [{
    "month",
    "months"
  }] = MONTH,
  [{
    "year",
    "years",
    "yr",
    "yrs"
  }] = YEAR
}
local UNITS = { }
for E, V in pairs(PATCH) do
  for _index_0 = 1, #E do
    local T = E[_index_0]
    UNITS[T] = V
  end
end
return function(str)
  local peel = peeler(str)
  local time = 0
  while true do
    local amount = peel(ITEM)
    if not (amount) then
      break
    end
    local unit = peel(WORD)
    local num = tonumber(amount)
    assert(num, "ms: invalid time string (invalid quantity \"" .. tostring(amount) .. "\")")
    assert(unit, "ms: invalid time string (missing unit after \"" .. tostring(amount) .. "\")")
    local value = UNITS[unit:lower()]
    assert(value, "ms: invalid time string (invalid unit \"" .. tostring(unit) .. "\")")
    time = time + (num * value)
  end
  return time
end
