-- ms.moon - a simple duration parser
-- SFZILabs 2021

strtok = (str, delim) ->
	start, stop = str\find delim
	if start
		tok = str\sub 0, start - 1
		last = str\sub stop + 1
		if #last > 0
			tok, last
		else tok
	elseif #str > 0
		str

WORD = ',? +'
ITEM = ' +'

peeler = (str) ->
	(delim = WORD) ->
		return unless str
		tok, str = strtok str, delim
		tok

SECOND = 1
MS = SECOND / 1000
MINUTE = 60 * SECOND
HOUR = 60 * MINUTE
DAY = HOUR * 24
MONTH = DAY * 30
YEAR = DAY * 365

PATCH =
	[{"ms", "millisecond", "milliseconds"}]: MS
	[{"second", "seconds", "sec", "secs"}]: SECOND
	[{"minute", "minutes", "min", "mins"}]: MINUTE
	[{"hour", "hours", "hr", "hrs"}]: HOUR
	[{"day", "days"}]: DAY
	[{"month", "months"}]: MONTH
	[{"year", "years", "yr", "yrs"}]: YEAR

UNITS = {}
for E, V in pairs PATCH
	UNITS[T] = V for T in *E

(str) ->
	peel = peeler str
	time = 0
	while true
		amount = peel ITEM
		break unless amount
		unit = peel WORD
		num = tonumber amount
		assert num,
			"ms: invalid time string (invalid quantity \"#{amount}\")"
		assert unit,
			"ms: invalid time string (missing unit after \"#{amount}\")"
		
		value = UNITS[unit\lower!]
		assert value,
			"ms: invalid time string (invalid unit \"#{unit}\")"

		time += num * value

	time
