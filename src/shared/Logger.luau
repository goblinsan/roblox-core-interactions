-- Logger module
-- Provides simple logging helpers. Debug is no-op by default; set DEBUG = true for development.

local Logger = {}
Logger.DEBUG = false

function Logger.debug(...)
    if Logger.DEBUG then
        print("[DEBUG]", ...)
    end
end

function Logger.info(...)
    print("[INFO]", ...)
end

function Logger.warn(...)
    warn("[WARN]", ...)
end

return Logger
