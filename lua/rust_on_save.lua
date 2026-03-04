local M = {}

local function apply_code_action(kind)
	local params = vim.lsp.util.make_range_params()
	params.context = { only = { kind }, diagnostics = {} }

	local results = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 2000)
	if not results then
		return
	end

	for _, res in pairs(results) do
		for _, action in ipairs(res.result or {}) do
			if action.edit then
				vim.lsp.util.apply_workspace_edit(action.edit, "utf-8")
			end
			local cmd = action.command or action
			if cmd then
				vim.lsp.buf.execute_command(cmd)
			end
		end
	end
end

function M.setup()
	local group = vim.api.nvim_create_augroup("RustOnSave", { clear = true })

	vim.api.nvim_create_autocmd("BufWritePre", {
		group = group,
		pattern = "*.rs",
		callback = function()
			-- Conform already formats on save via its own autocmd, but we want
			-- imports/fixes too. Do those here.
			apply_code_action("source.organizeImports")
			apply_code_action("source.fixAll")
		end,
	})
end

return M
