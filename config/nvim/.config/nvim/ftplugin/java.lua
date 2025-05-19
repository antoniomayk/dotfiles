vim.diagnostic.config({ virtual_text = true })

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(ev)
    require("utils").lsp_keymaps(ev, {
      -- stylua: ignore start
      -- { "<leader>la", vim.lsp.buf.code_action, mode = { "n", "v" }, desc = "Code Action", nowait = false },
      -- { "<leader>lr", vim.lsp.buf.rename,      mode = { "n" },      desc = "Rename",      nowait = false, },
      -- stylua: ignore end
    })
  end,
})

local jdtls = require("jdtls")
local lombok = vim.fn.expand("$MASON/share/jdtls/lombok.jar")

jdtls.start_or_attach({
  cmd = {
    "jdtls",
    "--jvm-arg=-javaagent:" .. lombok,
    "--jvm-arg=-Xbootclasspath/a:" .. lombok,
  },
  root_dir = vim.fs.dirname(vim.fs.find({ "pom.xml", "gradlew", ".git", "mvnw" }, { upward = true })[1]),
  settings = {
    java = {
      extendedClientCapabilities = jdtls.extendedClientCapabilities,
      eclipse = { downloadSources = true },
      maven = { downloadSources = true },
      implementationsCodeLens = { enabled = true },
      referencesCodeLens = { enabled = true },
      inlayHints = { parameterNames = { enabled = "all" } },
      signatureHelp = { enabled = true },
      completion = {
        favoriteStaticMembers = {
          "org.hamcrest.MatcherAssert.assertThat",
          "org.hamcrest.Matchers.*",
          "org.hamcrest.CoreMatchers.*",
          "org.junit.jupiter.api.Assertions.*",
          "java.util.Objects.requireNonNull",
          "java.util.Objects.requireNonNullElse",
          "org.mockito.Mockito.*",
        },
      },
      sources = {
        organizeImports = {
          starThreshold = 9999,
          staticStarThreshold = 9999,
        },
      },
      configuration = {
        runtimes = {
          {
            name = "JavaSE-17",
            path = vim.fn.expand("$HOME/.sdkman/candidates/java/17.0.14-tem/"),
          },
          {
            name = "JavaSE-21",
            path = vim.fn.expand("$HOME/.sdkman/candidates/java/21.0.6-tem/"),
          },
          {
            name = "JavaSE-24",
            path = vim.fn.expand("$HOME/.sdkman/candidates/java/24-tem/"),
          },
        },
        updateBuildConfiguration = "interactive",
      },
    },
  },
})
