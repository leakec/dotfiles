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
                    "import numpy as np",
                    "import Karana.Dynamics as kd",
                    "import Karana.Core as kc",
                    "from Karana.KUtils.Sim import Sim",
                    "",
                    "sim = Sim()",
                    "kd.PhysicalBody.addSerialChain(",
                    "    \"bd\",",
                    "    1,",
                    "    sim.mb.virtualRoot(),",
                    "    kd.PhysicalBodyParams(",
                    "        hinge_params=kd.PhysicalHingeParams(",
                    "            kd.HingeType.REVOLUTE,",
                    "            subhinge_params=[kd.PinSubhingeParams(unit_axis=np.array([1.0, 0.0, 0.0]))],",
                    "        )",
                    "    ),",
                    ")",
                    "",
                    "sim.mb.ensureHealthy()",
                    "sim.mb.resetData()",
                    "sim.sp.ensureHealthy()",
                    "sim.sp.hardReset()",
                    "sim.sp.setState(sim.sp.assembleState())",
                    "",
                    "assert kc.allReady()",
                    "",
                    "def cleanup():",
                    "    global sim",
                    "    del sim",
                    "",
                    "atexit.register(cleanup)",
                }),
            }),
        })
    end
}
