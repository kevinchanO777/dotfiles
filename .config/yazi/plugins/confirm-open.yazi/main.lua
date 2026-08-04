--- @since 26.1.22

local THRESHOLD_DEFAULT = 0

local get_context = ya.sync(function(state)
	return {
		threshold = state.threshold,
		is_visual = cx.active.mode.is_visual,
		num_selected = #cx.active.selected,
	}
end)

local function setup(state, opts)
	if opts then
		state.threshold = opts.threshold
	end
end

local function entry()
	-- Exit visual mode first (otherwise its selection won't count)
	-- This only works in async context, or it will run after entry() returns
	ya.emit("escape", { visual = true })

	-- Sync context
	local context = get_context()

	local answer = true
	if context.num_selected >= (context.threshold or THRESHOLD_DEFAULT) then
		answer = ya.confirm({
			pos = { "center", w = 40, h = 10 },
			title = "Open?",
			body = "Open " .. context.num_selected .. " files?",
		})
	end

	if answer then
		ya.emit("open", {})
	end
end

return { entry = entry, setup = setup }
