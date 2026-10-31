-- rexurrect: restore saved sessions when the server starts
do local r = rex.exec({ [[/opt/homebrew/bin/rexurrect]], "auto-restore" }, { env = { REXURRECT_STATE_DIR = [[/Users/jigsaw/.local/state/rexurrect]], REXURRECT_CONFIG = [[/Users/jigsaw/.config/rexurrect/config.toml]] } }) if r then io.stderr:write(r.stderr) end end
