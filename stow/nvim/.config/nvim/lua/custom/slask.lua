
--test code and stuff etc
function table.val_to_str ( v )
  if "string" == type( v ) then
    v = string.gsub( v, "\n", "\\n" )
    if string.match( string.gsub(v,"[^'\"]",""), '^"+$' ) then
      return "'" .. v .. "'"
    end
    return '"' .. string.gsub(v,'"', '\\"' ) .. '"'
  else
    return "table" == type( v ) and table.tostring( v ) or
      tostring( v )
  end
end

function table.key_to_str ( k )
  if "string" == type( k ) and string.match( k, "^[_%a][_%a%d]*$" ) then
    return k
  else
    return "[" .. table.val_to_str( k ) .. "]"
  end
end

function table.tostring( tbl )
  local result, done = {}, {}
  for k, v in ipairs( tbl ) do
    table.insert( result, table.val_to_str( v ) )
    done[ k ] = true
  end
  for k, v in pairs( tbl ) do
    if not done[ k ] then
      table.insert( result,
        table.key_to_str( k ) .. "=" .. table.val_to_str( v ) )
    end
  end
  return "{" .. table.concat( result, "," ) .. "}"
end
--end test


vim.notify(table.tostring("test"))

local function log(severity, message)
  print(severity, message)
end

local tmux_directions = {
  h = "L",
  j = "D",
  k = "U",
  l = "R",
}

local M = {
  is_tmux = false,
}

local function get_tmux()
  return os.getenv "TMUX"
end

local function get_tmux_pane()
  return os.getenv "TMUX_PANE"
end

local function get_socket()
  return vim.split(get_tmux(), ",")[1]
end

function M.resize(direction, step)
  execute(string.format("resize-pane -t '%s' -%s %d", get_tmux_pane(), tmux_directions[direction], step))
end

local function has_value(array, value)
  for _, v in ipairs(array) do
    if v == value then
      return true
    end
  end
  return false
end

local function collision(border)
  log("info", border)
  if has_value("", border) then
    return true
  end
  return false
end

function test()
  print(get_tmux())
end
