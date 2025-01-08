-- https://luals.github.io/wiki/settings/
return {
  settings = {
    Lua = {
      completion = {
        callSnippet = "Replace",
      },
      format = {
        enable = true,
        -- defaultConfig = {
        --   quote_style = "double",
        -- },
      },
      dagnostics = {
        globals = { "vim" },
        -- globals = { "vim", "spec" },
      },
      runtime = {
        version = "LuaJIT",
        -- special = {
        --   spec = "require",
        -- },
      },
      workspace = {
        checkThirdParty = false,
        library = {
          [vim.fn.expand("$VIMRUNTIME/lua")] = true,
          [vim.fn.stdpath("config") .. "/lua"] = true,
        },
      },
      hint = {
        enable = true,
        arrayIndex = "Disable", -- "Enable" | "Auto" | "Disable"
        await = true,
        paramName = "All",      -- "All" | "Literal" | "Disable"
        paramType = false,
        semicolon = "Disable",  -- "All" | "SameLine" | "Disable"
        setType = false,
      },
      telemetry = {
        enable = false,
      },
    },
  },
}