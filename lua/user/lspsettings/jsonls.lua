return {
  init_options = {
    providerFormatter = false,
  },
  settings = {
    json = {
      schemas = require("schemastore").json.schemas(),
    },
  },
}
