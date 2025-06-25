## Flex prompt setup

### Configure prompt symbol with current date

Unfotunatelly there is no any setting to configure prompt symbol to be dinamically changed,
that is why patch way is described here.

To have such prompt:

```bash
C:\Users\sakkada\scoop ·························································· 21:13:46
211346 ❯
```

it is required to make some little change in `get_prompt_symbol` function
in `flexprompt.lua` file in installation directory (e.g. `~/scoop/apps/clink-flex-prompt/0.16`).

```diff
 local function get_prompt_symbol()
     local p = nil
     if rl.insertmode and not rl.insertmode() then
         p = get_symbol("overtype_prompt", "►")
     end
-    return p or get_symbol("prompt", ">")
+    -- return p or get_symbol("prompt", ">")
+    -- sakkada patch: add curdate before '>' symbol
+    return os.date('%H%M%S ') .. (p or get_symbol("prompt", ">"))
 end
```

**Note**: not used if `lines=one` and `top_promt` defined.

TODO: To be deleted, not used anymore.
