module.exports = (element) ->
	if @indexOf(element) >= 0
		@splice @indexOf(element), 1
	return @