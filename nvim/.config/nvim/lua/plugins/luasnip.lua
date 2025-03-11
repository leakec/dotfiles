return {
    'L3MON4D3/LuaSnip', 
    config = function()
        local ls = require("luasnip")
        local s = ls.snippet
        local t = ls.text_node

        ls.add_snippets("python", {
            s("excepthook", {
                t({
                    "import sys",
                    "import pdb",
                    "import traceback",
                    "",
                    "def handle_exception(exc_type, exc_value, exc_traceback):",
                    "    if issubclass(exc_type, KeyboardInterrupt):",
                    "        # Ignore Ctrl+C interruptions",
                    "        sys.__excepthook__(exc_type, exc_value, exc_traceback)",
                    "        return",
                    "    print(\"Exception occurred:\")",
                    "    traceback.print_exception(exc_type, exc_value, exc_traceback)",
                    "    pdb.post_mortem(exc_traceback)",
                    "",
                    "sys.excepthook = handle_exception",
                }),
            }),
        })
    end
}
