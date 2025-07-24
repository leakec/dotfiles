return {
    'L3MON4D3/LuaSnip', 
    event="VeryLazy",
    config = function()
        local ls = require("luasnip")
        local s = ls.snippet
        local t = ls.text_node

        ls.add_snippets("python", {
            s("post-mortem", {
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
            s("default-kd-sim", {
                t({
                    "import atexit",
                    "from typing import cast",
                    "from Karana.Core.KCore_Py import discard, allFinalized, BaseContainer",
                    "from Karana.Frame.Frame_Py import FrameContainer",
                    "from Karana.Dynamics.SOADyn_Py import Multibody, PhysicalBody",
                    "",
                    "bc = BaseContainer.singleton()",
                    "fc = FrameContainer(\"root\")",
                    "bc.at_exit_fns[\"discard_fc\"] = lambda: discard(fc)",
                    "",
                    "mb = Multibody(\"mb\", fc)",
                    "bc.at_exit_fns[\"discard_mb\"] = lambda: discard(mb)",
                    "PhysicalBody.addSerialChain(\"bd\", 1, cast(PhysicalBody, mb.virtualRoot()))",
                    "",
                    "mb.ensureCurrent()",
                    "mb.resetData()",
                    "cleanup_graphics, _ = mb.setupGraphics(port=5757)",
                    "bc.at_exit_fns[\"cleanup_graphics\"] = cleanup_graphics",
                    "",
                    "assert allFinalized()",
                    "",
                    "",
                    "def cleanup():",
                    "    bc.at_exit_fns.executeReverse()",
                    "    bc.at_exit_fns.clear()",
                    "",
                    "",
                    "atexit.register(cleanup)",
                }),
            }),
        })
    end
}
