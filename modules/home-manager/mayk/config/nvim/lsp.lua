-- vim

local api = vim.api
local diagnostic = vim.diagnostic
local fs = vim.fs
local lsp = vim.lsp

--=========================================================
--= setup
--=========================================================

diagnostic.config({
  severity = {
    Error = true,
    Warning = true,
    Hint = true,
    Info = true,
  },
  virtual_lines = {
    current_line = true,
  },
})

lsp.enable({
  "clangd",
  "docker-compose-langserver",
  "dockerls",
  "lemminx",
  "lua-language-server",
  "nixd",
  "rust-analyzer",
})

--=========================================================
--= clangd
--=========================================================

lsp.config["clangd"] = {
  cmd = { "clangd" },
  root_markers = {
    ".clangd",
    ".clang-tidy",
    ".clang-format",
    "compile_commands.json",
    "compile_flags.txt",
    "configure.ac",
    ".git",
  },
  filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
  capabilities = {
    textDocument = {
      semanticTokens = {
        multilineTokenSupport = true,
      },
    },
  },
}

--=========================================================
--= jdtls
--=========================================================

api.nvim_create_autocmd({ "FileType" }, {
  pattern = "java",
  callback = function()
    local lombok = "{{{lombok}}}/share/java/lombok.jar"

    require("jdtls").start_or_attach({
      cmd = {
        "jdtls",
        "--jvm-arg=-javaagent:" .. lombok,
        "--jvm-arg=-Xbootclasspath/a:" .. lombok,
      },
      root_dir = fs.dirname(fs.find({ "pom.xml", "gradlew", ".git", "mvnw" }, { upward = true })[1]),
      filetypes = { "java" },
      settings = {
        java = {
          compile = {
            -- nullAnalysis = {
            --   nonnull = {
            --     "javax.annotation.Nonnull",
            --     "org.eclipse.jdt.annotation.NonNull",
            --     "org.jspecify.annotations.NonNull",
            --   },
            --   nullable = {
            --     "javax.annotation.Nullable",
            --     "org.eclipse.jdt.annotation.Nullable",
            --     "org.jspecify.annotations.Nullable",
            --   },
            --   nonnullbydefault = {
            --     "javax.annotation.ParametersAreNonnullByDefault",
            --     "org.eclipse.jdt.annotation.NonNullByDefault",
            --     "org.jspecify.annotations.NullMarked",
            --   },
            --   mode = "automatic",
            -- },
          },
          extendedClientCapabilities = require("jdtls").extendedClientCapabilities,
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
            updateBuildConfiguration = "interactive",
          },
        },
      },
      handlers = {
        ["language/status"] = function() end,
        ["$/progress"] = function() end,
      },
    })
  end,
  once = false,
  buffer = nil,
  nested = false,
})

--=========================================================
--= metals
--=========================================================

local metals_config = require("metals").bare_config()

api.nvim_create_autocmd("FileType", {
  pattern = { "scala", "sbt" },
  callback = function()
    require("metals").initialize_or_attach(vim.tbl_deep_extend("force", metals_config, {
      settings = {
        showImplicitArguments = true,
        excludedPackages = { "akka.actor.typed.javadsl", "com.github.swagger.akka.javadsl" },
      },
      init_options = {
        statusBarProvider = "off",
      },
      capabilities = require("blink.cmp").get_lsp_capabilities(metals_config.capabilities),
      on_attach = function(client, bufnr)
        local map = vim.keymap.set

        map("n", "gD", vim.lsp.buf.definition)
        map("n", "K", vim.lsp.buf.hover)
        map("n", "gi", vim.lsp.buf.implementation)
        map("n", "gr", vim.lsp.buf.references)
        map("n", "gds", vim.lsp.buf.document_symbol)
        map("n", "gws", vim.lsp.buf.workspace_symbol)
        map("n", "<leader>cl", vim.lsp.codelens.run)
        map("n", "<leader>sh", vim.lsp.buf.signature_help)
        map("n", "<leader>rn", vim.lsp.buf.rename)
        map("n", "<leader>f", vim.lsp.buf.format)
        map("n", "<leader>ca", vim.lsp.buf.code_action)
        map("n", "<leader>ws", function()
          require("metals").hover_worksheet()
        end)

        map("n", "<leader>aa", vim.diagnostic.setqflist)

        map("n", "<leader>ae", function()
          vim.diagnostic.setqflist({ severity = "E" })
        end)

        map("n", "<leader>aw", function()
          vim.diagnostic.setqflist({ severity = "W" })
        end)

        map("n", "<leader>d", vim.diagnostic.setloclist)

        map("n", "[c", function()
          vim.diagnostic.goto_prev({ wrap = false })
        end)

        map("n", "]c", function()
          vim.diagnostic.goto_next({ wrap = false })
        end)
      end,
    }))
  end,
  group = api.nvim_create_augroup("nvim-metals", { clear = true }),
})

--=========================================================
--= lua-language-server
--=========================================================

lsp.config["lua-language-server"] = {
  cmd = { "lua-language-server" },
  root_markers = {
    ".luarc.json",
    ".luarc.jsonc",
    ".luacheckrc",
    ".stylua.toml",
    "stylua.toml",
    "selene.toml",
    "selene.yml",
    ".git",
  },
  filetypes = { "lua" },
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT",
      },
    },
  },
}

--=========================================================
--= rust-analyzer
--=========================================================

lsp.config["rust-analyzer"] = {
  cmd = { "rust-analyzer" },
  root_markers = {
    "Cargo.toml",
    "Cargo.lock",
    ".git",
  },
  filetypes = { "rust" },
  settings = {
    ["rust-analyzer"] = {
      diagnostics = {
        enable = true,
      },
      check = {
        command = "clippy",
        allTargets = false,
      },
      cargo = {
        allFeatures = true,
      },
    },
  },
}

--=========================================================
--= nixd
--=========================================================

lsp.config["nixd"] = {
  cmd = { "nixd" },
  filetypes = { "nix" },
  root_markers = { "flake.nix", "git" },
  settings = {
    nixd = {
      formatting = {
        command = { "nixfmt" },
      },
    },
  },
}

--=========================================================
--= docker-compose-langserver
--=========================================================

vim.filetype.add({
  filename = {
    ["docker-compose.yml"] = "yaml.docker-compose",
    ["docker-compose.yaml"] = "yaml.docker-compose",
    ["compose.yml"] = "yaml.docker-compose",
    ["compose.yaml"] = "yaml.docker-compose",
  },
})

lsp.config["docker-compose-langserver"] = {
  cmd = { "docker-compose-langserver", "--stdio" },
  root_markers = {
    "docker-compose.yaml",
    "docker-compose.yml",
    "compose.yaml",
    "compose.yml",
  },
  filetypes = { "yaml.docker-compose", "yml.docker-compose" },
}

--=========================================================
--= dockerls
--=========================================================

lsp.config["dockerls"] = {
  cmd = { "docker-langserver", "--stdio" },
  filetypes = { "dockerfile" },
  root_markers = { "Dockerfile" },
  settings = {
    docker = {
      languageserver = {
        formatter = {
          ignoreMultilineInstructions = true,
        },
      },
    },
  },
}

--=========================================================
--= lemminx
--=========================================================

lsp.config["lemminx"] = {
  cmd = { "lemminx" },
  filetypes = { "xml", "xsd", "xsl", "xslt", "svg" },
  root_markers = { ".git" },
}
