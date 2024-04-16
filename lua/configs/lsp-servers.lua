return {
  omnisharp = {
    settings = {
      RoslynExtensionsOptions = {
        EnableAnalyzersSupport = true,
        EnableImportCompletion = true,
        enableDecompilationSupport = true,
      },
    },
    handlers = {
      ['textDocument/definition'] = require('omnisharp_extended').definition_handler,
      ['textDocument/typeDefinition'] = require('omnisharp_extended').type_definition_handler,
      ['textDocument/references'] = require('omnisharp_extended').references_handler,
      ['textDocument/implementation'] = require('omnisharp_extended').implementation_handler,
    },
  },
  lua_ls = {
    settings = {
      Lua = {
        completion = {
          callSnippet = 'Disable', -- Disables snippets for lua_ls
        },
      },
    },
  },
}
