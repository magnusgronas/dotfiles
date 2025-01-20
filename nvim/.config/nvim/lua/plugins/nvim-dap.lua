return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"rcarriga/nvim-dap-ui",
		"theHamsta/nvim-dap-virtual-text",
		"nvim-neotest/nvim-nio",
	},
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		-- Set breakpoint icon
		vim.api.nvim_set_hl(0, "DapBreakpointCustom", { fg = "#ee99a0" })
		vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "DapBreakpointCustom", linehl = "", numhl = "" })

		local dap = require("dap")
		local dapui = require("dapui")
		dapui.setup()
		dap.listeners.after.event_initialized["dapui_config"] = function()
			dapui.open()
		end
		dap.listeners.before.event_terminated["dapui_config"] = function()
			dapui.close()
		end
		dap.listeners.before.event_exited["dapui_config"] = function()
			dapui.close()
		end

		dap.adapters.codelldb = {
			type = "executable",
			command = "/home/magnus/.local/share/nvim/mason/bin/codelldb", -- or if not in $PATH: "/absolute/path/to/codelldb"

			-- On windows you may have to uncomment this:
			-- detached = false,
		}

		dap.configurations.cpp = {
			{
				name = "Launch file",
				type = "codelldb",
				request = "launch",
				program = function()
					return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
				end,
				cwd = "${workspaceFolder}",
				stopOnEntry = false,
			},
		}

		-- Keymaps
		local keymap = vim.keymap.set
		keymap({ "n", "v" }, "<leader>db", dap.toggle_breakpoint, { silent = true, desc = "Toggle Breakpoint" })
		keymap(
			{ "n", "v" },
			"<leader>dr",
			"<cmd> DapContinue <CR>",
			{ silent = true, desc = "Start or continue debug" }
		)
		keymap({ "n", "v" }, "<leader>du", dapui.toggle, { silent = true, desc = "Open debug ui" })
		keymap({ "n", "v" }, "<leader>de", dapui.eval, { silent = true, desc = "Eval" })
	end,
}
