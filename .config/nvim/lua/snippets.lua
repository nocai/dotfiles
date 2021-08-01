local fmt = string.format
local fn = vim.fn

-- utils
local fname = function()
    return fn.expand("%:t:r")
end

local clipboard = function()
    return fn.getreg("*")
end

-- helpers
local from_ft = function(ft)
    ft = type(ft) == "string" and { ft } or ft
    local gen = function(snip)
        if not vim.tbl_contains(ft, vim.bo.ft) then
            return
        end
        return snip
    end
    return gen, function(snip)
        return function()
            return gen(snip)
        end
    end
end

-- filetypes
local lua, luastr = from_ft("lua")
local ts, tsstr = from_ft({ "typescript", "typescriptreact" })
local tsx, tsxstr = from_ft("typescriptreact")

return {
    -- shared
    clg = function()
        return lua("print(vim.inspect($0))") or ts("console.log($0)")
    end,
    clq = function()
        return lua('print("$0")') or ts('console.log("$0")')
    end,
    clc = function()
        local cb = vim.trim(clipboard())
        return lua(fmt('print("%s", %s)', cb, cb)) or ts(fmt('console.log("%s", %s);', cb, cb))
    end,
    imp = function()
        return lua("local $1 = require($0)") or ts('import { $0 } from "$1";')
    end,
    dsc = function()
        return lua([[
        describe("$1", function()
            $0
        end)]]) or ts([[
        describe("$1", () => {
            $0
        });]])
    end,
    tt = function()
        return lua([[
        it("$1", function()
            $0
        end)]]) or ts([[
        test("$1", () => {
            $0
        });]])
    end,
    bff = function()
        return lua([[
        before_each(function()
            $0
        end)]]) or ts([[
        beforeEach(() => {
            $0
        });]])
    end,
    aff = function()
        return lua([[
        after_each(function()
            $0
        end)]]) or ts([[
        afterEach(() => {
            $0
        });]])
    end,
    exp = function()
        return lua("assert.$1($0)") or ts("expect($1).$0;")
    end,
    expx = function()
        return lua("assert.equals($1, $0)") or ts("expect($1).toBe($0);")
    end,
    exps = function()
        return lua("assert.same($1, $0)") or ts("expect($1).toEqual($0);")
    end,
    expc = function()
        return lua("assert.stub($1).was_called($0)") or ts("expect($1).toHaveBeenCalled();")
    end,
    expw = function()
        return lua("assert.stub($1).was_called_with($0)") or ts("expect($1).toHaveBeenCalledWith($0);")
    end,
    -- lua
    use = function()
        return lua(fmt('use("%s")', clipboard():gsub("https://github.com/", "")))
    end,
    usec = function()
        return lua(fmt('use_with_config({ "%s", "$0" })', clipboard():gsub("https://github.com/", "")))
    end,
    func = luastr([[
        function($1)
            $0
        end]]),
    ["in"] = luastr("vim.inspect($0))"),
    lfunc = luastr([[
        local $1 = function($2)
            $0
        end]]),
    tf = function()
        return lua(fmt(
            [[
            describe("%s", function()
                $0
            end)]],
            fname():gsub("%_spec", "")
        ))
    end,
    -- typescript
    tta = tsstr([[
        test("$1", async () => {
            $0
        });]]),
    iff = tsstr([[
        interface $1 {
            $0
        }]]),
    try = tsstr([[
        try {
            $1
        } catch (error) {
            $0
        }
        ]]),
    jfn = tsstr("jest.fn()"),
    -- typescriptreact
    ifp = tsxstr([[
        interface Props {
            $0
        }]]),
    uff = tsxstr([[
        useEffect(() => {
            $1
        }, [$0]);
        ]]),
    uss = tsxstr("const $1 = useSelector($0);"),
    udp = tsxstr("const dispatch = useDispatch();"),
    ufm = tsxstr("const { $1 } = useForm($0);"),
    ufmm = tsxstr("const { $1 } = useFormContext();"),
    mkst = tsxstr([[
    import { makeStyles } from "@material-ui/core";

    const useStyles = makeStyles({
        $0
    });

    export default useStyles;]]),
    xpco = function()
        return tsx(fmt(
            [[
                export const %s = (): JSX.Element => {
                    $0
                    return <div />;
                };]],
            fname()
        ))
    end,
    pco = function()
        return tsx(fmt(
            [[
            const %s = (): JSX.Element => {
                $0
                return <div />;
            };

            export default %s;]],
            fname(),
            fname()
        ))
    end,
}
