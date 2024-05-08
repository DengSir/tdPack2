do
    local file = io.open('default.luacheckrc', 'r')
    if file then
        file:close()

        local _ENV = {}

        local f = loadfile('default.luacheckrc')
        f()

        read_globals = _ENV.read_globals
    end
end

std = 'lua51'

exclude_files = { --
    '**/Libs', '**/Localization', '.index.lua', '.emmy', 'Scaner.lua', '**/Button/**', '**/Core/Compat.lua',
}

ignore = {
    -- '212', -- Unused argument.
    -- '432', -- Shadowing an upvalue argument.
    '213/i', -- Unused loop variable.
    '213/k', -- Unused loop variable.
    '213/v', -- Unused loop variable.
    '542', -- An empty if branch.
    '631', -- Line is too long.
    '11./SLASH_.*', -- Setting an undefined (Slash handler) global variable
    '11./BINDING_.*', -- Setting an undefined (Keybinding header) global variable
    -- "113/LE_.*", -- Accessing an undefined (Lua ENUM type) global variable
    -- "113/NUM_LE_.*", -- Accessing an undefined (Lua ENUM type) global variable
    '122/StaticPopupDialogs', -- Setting a read-only field of a global variable "StaticPopupDialogs"
    -- "211", -- Unused local variable
    -- "212", -- Unused argument
    '212/self', -- Unused argument "self"
    -- "213", -- Unused loop variable
    -- "231", -- Set but never accessed
    -- "311", -- Value assigned to a local variable is unused
    -- "314", -- Value of a field in a table literal is unused
    '42.', -- Shadowing a local variable, an argument, a loop variable.
    '43.', -- Shadowing an upvalue, an upvalue argument, an upvalue loop variable.
}

globals = {'maybe'}
