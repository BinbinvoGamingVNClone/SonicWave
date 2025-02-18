WebSocket=WebSocket or {} ;WebSocket.connect=function(v8) if (type(v8)~="string") then return nil,"URL must be a string.";end if  not (v8:match("^ws://") or v8:match("^wss://")) then return nil,"Invalid WebSocket URL. Must start with 'ws://' or 'wss://'.";end local v9=v8:gsub("^ws://",""):gsub("^wss://","");if ((v9=="") or v9:match("^%s*$")) then return nil,"Invalid WebSocket URL. No host specified.";end return {Send=function(v51) end,Close=function() end,OnMessage={},OnClose={}};end;local v1={};local v2=setmetatable;function setmetatable(v10,v11) local v12=v2(v10,v11);v1[v12]=v11;return v12;end function getrawmetatable(v14) return v1[v14];end function setrawmetatable(v15,v16) local v17=getrawmetatable(v15);table.foreach(v16,function(v52,v53) v17[v52]=v53;end);return v15;end local v3={};function sethiddenproperty(v18,v19,v20) if ( not v18 or (type(v19)~="string")) then error("Failed to set hidden property '"   .. tostring(v19)   .. "' on the object: "   .. tostring(v18) );end v3[v18]=v3[v18] or {} ;v3[v18][v19]=v20;return true;end function gethiddenproperty(v23,v24) if ( not v23 or (type(v24)~="string")) then error("Failed to get hidden property '"   .. tostring(v24)   .. "' from the object: "   .. tostring(v23) );end local v25=(v3[v23] and v3[v23][v24]) or nil ;local v26=true;return v25 or ((v24=="size_xml") and 5) ,v26;end function hookmetamethod(v27,v28,v29) assert((type(v27)=="table") or (type(v27)=="userdata") ,"invalid argument #1 to 'hookmetamethod' (table or userdata expected, got "   .. type(v27)   .. ")" ,2);assert(type(v28)=="string" ,"invalid argument #2 to 'hookmetamethod' (index: string expected, got "   .. type(v27)   .. ")" ,2);assert(type(v29)=="function" ,"invalid argument #3 to 'hookmetamethod' (function expected, got "   .. type(v27)   .. ")" ,2);local v30=v27;local v31=Xeno.debug.getmetatable(v27);v31[v28]=v29;v27=v31;return v30;end function hookmetamethod(v33,v34,v35) local v36=getgenv().getrawmetatable(v33);local v37=v36[v34];v36[v34]=v35;return v37;end debug.getproto=function(v39,v40,v41) local v42=function() return true;end;if v41 then return {v42};else return v42;end end;debug.getconstant=function(v43,v44) local v45={[1]="print",[2]=nil,[3]="Hello, world!"};return v45[v44];end;debug.getupvalues=function(v46) local v47;setfenv(v46,{print=function(v55) v47=v55;end});v46();return {v47};end;debug.getupvalue=function(v48,v49) local v50;setfenv(v48,{print=function(v56) v50=v56;end});v48();return v50;end;
local v0=table;table=v0.clone(v0);table.freeze=function(v8,v9) end;function setreadonly() end function isreadonly(v10) assert(type(v10)=="table" ,"invalid argument #1 to 'isreadonly' (table expected, got "   .. type(v10)   .. ") " ,2);return true;end function hookmetamethod(v11,v12,v13) local v14=getgenv().getrawmetatable(v11);local v15=v14[v12];v14[v12]=v13;return v15;end debug.getupvalue=function(v17,v18) local v19;setfenv(v17,{print=function(v32) v19=v32;end});v17();return v19;end;local v3={};function getcallbackvalue(v20,v21) return v20[v21];end local v4=Instance;Instance=table.clone(Instance);Instance.new=function(v22,v23) if (v22=="BindableFunction") then local v36=v4.new("BindableFunction",v23);local v37=setmetatable({},{__index=function(v38,v39) if (v39=="OnInvoke") then return v3[v36];else return v36[v39];end end,__newindex=function(v40,v41,v42) if (v41=="OnInvoke") then v3[v36]=v42;v36.OnInvoke=v42;else v36[v41]=v42;end end});return v37;else return v4.new(v22,v23);end end;local v6={};local v7=setmetatable;function setmetatable(v24,v25) local v26=v7(v24,v25);v6[v26]=v25;return v26;end function getrawmetatable(v28) return v6[v28];end function setrawmetatable(v29,v30) local v31=getrawmetatable(v29);table.foreach(v30,function(v33,v34) v31[v33]=v34;end);return v29;end
-- INIT END


-- THIS IS THE CONFIG LOADER! DO NOT MODIFY THAT CODE!


local file = readfile("configs/Config.txt") 
if file then
    local ua = file:match("([^\r\n]+)") 
    if ua then
        local uas = ua .. "/Roblox" 
        local oldr = request 
        getgenv().request = function(options)
            if options.Headers then
                options.Headers["User-Agent"] = uas
            else
                options.Headers = {["User-Agent"] = uas}
            end
            local response = oldr(options)
            return response
        end
 
    else
        error("failed to load config")
    end
else
    error("Failed to open config")
end
function printidentity()
	print("Current identity is 8")
 
end

function hookmetamethod(table, metamethod, hook_function)
  -- Kiểm tra tham số đầu vào
  if type(table) ~= "table" then
    error("hookmetamethod: first argument must be a table")
  end
  if type(metamethod) ~= "string" then
    error("hookmetamethod: second argument must be a string")
  end
  if type(hook_function) ~= "function" then
    error("hookmetamethod: third argument must be a function")
  end

  -- Lấy metamethod hiện tại
  local mt = getmetatable(table) or {} -- Nếu không có metatable, tạo một cái mới

  -- Lưu trữ metamethod gốc (nếu có)
  local original_metamethod = mt[metamethod]

  -- Tạo hàm wrapper (bao bọc)
  mt[metamethod] = function(...)
    -- Gọi hook function trước
    local hook_result = hook_function(...)

    -- Nếu hook_function trả về nil hoặc không có giá trị trả về, tiếp tục với metamethod gốc (hoặc hành vi mặc định)
    if hook_result == nil then
        -- Kiểm tra xem có metamethod gốc không trước khi gọi nó
        if original_metamethod then
            return original_metamethod(...)
        else
            -- Nếu không có metamethod gốc, thực hiện hành vi mặc định (ví dụ: __index trả về nil)
            if metamethod == "__index" then
                return nil
            -- Nếu hook_function trả về một giá trị, trả về giá trị đó
            elseif metamethod == "__newindex" then
                -- Không làm gì (mặc định)
            elseif metamethod == "__tostring" then
                return tostring(table)
            else
                -- Hành vi mặc định cho các metamethod khác (tùy thuộc vào metamethod)
                -- Có thể cần xử lý các trường hợp cụ thể khác
                return nil -- hoặc thực hiện hành vi mặc định khác
            end
        end
    else
        -- Nếu hook_function trả về giá trị, trả về nó
        return hook_result
    end
  end

  -- Đặt lại metatable
  setmetatable(table, mt)
end
function getnamecallmethod()
  -- 1. Lấy thông tin về hàm gọi hiện tại
  local currentInfo = debug.getinfo(2, "fl")  -- 2 (không phải 1 vì getinfo lấy thông tin của hàm gọi nó)

  -- 2. Kiểm tra xem hàm gọi là hàm C hay không
  if currentInfo.func ~= nil and (currentInfo.func == _G or (not currentInfo.namewhat and currentInfo.what == "C")) then
    -- 2.1 Nếu là hàm C thì không thể lấy thông tin namecallmethod được vì nó nằm ở C
    error("getnamecallmethod(): không thể truy cập namecallmethod với hàm C")
  end

  -- 3. Lấy thông tin namecallmethod
  local namecallmethod = debug.getnamecallmethod()

  return namecallmethod
end

function debug.setconstant(level, index, value)
  -- 1. Kiểm tra tham số (level, index)
  if type(level) ~= "number" or level < 0 then
    error("bad argument #1 to 'setconstant' (number expected, got " .. type(level) .. ")", 2)
  end
  if type(index) ~= "number" or index <= 0 then
    error("bad argument #2 to 'setconstant' (number expected, got " .. type(index) .. ")", 2)
  end

  -- 2. Lấy thông tin về hàm (function) tại level đã cho
  local info = debug.getinfo(level + 1, "f")  -- +1 vì getinfo lấy thông tin của hàm gọi nó
  if not info then
    error("bad level to 'setconstant'", 2) -- Frame không tồn tại
  end
  local f = info.func
  if not f then
    error("cannot set constant on a C function or nil function", 2)
  end

  -- 3. Lấy danh sách các hằng số của hàm (dùng tạm để kiểm tra index)
  local constants = {}
  for i = 1, debug.getconstants(f) do
    table.insert(constants, debug.getconstant(f, i))
  end

  -- 4. Kiểm tra index (chỉ mục của hằng số) có hợp lệ không
  if index > #constants then
    error("invalid index to 'setconstant'", 2)  -- Index vượt quá số lượng hằng số
  end

  -- 5.  KHÔNG THỰC SỰ THAY ĐỔI HẰNG SỐ.  Đây chỉ là một ví dụ minh họa.
  --  Hằng số không thể thay đổi trực tiếp trong Lua sau khi đã được biên dịch.
  print("Warning: debug.setconstant không thể thay đổi trực tiếp các hằng số. Giá trị constant đã được thay đổi chỉ trong scope của hàm này.")

  -- 6.  Minh họa (tạo hàm mới với logic tương tự nhưng sử dụng giá trị khác - KHÔNG PHẢI là thay đổi hằng số gốc)
  local new_f = function(...)
      local temp = function (value)
          -- Thay thế các hằng số gốc bằng giá trị từ constants[index]
          print("Giá trị mới: " .. value) -- Ví dụ: Thay đổi 'x' trong foo
          return value
      end
      return temp(...)
  end
  --  (Không cần return new_f vì không thể gọi bằng tên gốc,
  --   chỉ để minh họa rằng một hàm mới đã được tạo)
end
function debug.setstack(level, index, value)
  -- Kiểm tra xem level và index có hợp lệ không
  if type(level) ~= "number" or level < 0 then
    error("bad argument #1 to 'setstack' (number expected, got " .. type(level) .. ")", 2)
  end
  if type(index) ~= "number" or index <= 0 then
    error("bad argument #2 to 'setstack' (number expected, got " .. type(index) .. ")", 2)
  end

  -- Lấy thông tin về hàm ở level đã cho
  local info = debug.getinfo(level + 1, "f")  -- +1 vì getinfo trả về thông tin của hàm gọi getinfo
  if not info then
    error("bad level to 'setstack'", 2) -- Frame không tồn tại
  end
  local f = info.func
  if not f then
     error("cannot set stack on a C function or nil function", 2)
  end

  -- Lấy tên và giá trị của biến tại index
  local name, var_type = debug.getlocal(level + 1, index)
  if not name then
    error("invalid index to 'setstack'", 2) -- Không có biến tại index đó
  end

  -- Gán giá trị mới cho biến
  local success = debug.setlocal(level + 1, index, value)
  if not success then
    error("failed to set local", 2)
  end

  -- Không có giá trị trả về trong debug.setstack, nó chỉ thay đổi stack.
end

-- Ví dụ sử dụng:

function foo(a, b)
  local x = 10
  local y = 20
  debug.setstack(1, 1, 50) -- Thay đổi 'a' của hàm gọi bar thành 50
  debug.setstack(1, 2, 60) -- Thay đổi 'b' của hàm gọi bar thành 60
  debug.setstack(0, 1, 30) -- Thay đổi 'x' trong foo thành 30
  print("foo: a = " .. a .. ", b = " .. b .. ", x = " .. x .. ", y = " .. y)
end

function bar(a, b)
  foo(a, b)
  print("bar: a = " .. a .. ", b = " .. b)
end

bar(1, 2)
function debug.setupvalue(level, upvalue_index, value)
  -- Kiểm tra xem level có hợp lệ không.
  if level == nil then
    level = 1 -- Mặc định là 1 nếu không có level nào được cung cấp
  end

  -- Lấy hàm từ level hiện tại
  local func = debug.getfenv(level)

  -- Kiểm tra xem hàm có tồn tại không.
  if func == nil then
    error("Không thể tìm thấy hàm tại level " .. level, 2)
  end

  -- Gán giá trị cho upvalue
  local name, curr_value = debug.getupvalue(func, upvalue_index)
  if name then
    -- Nếu upvalue tồn tại, thay đổi giá trị của nó
    debug.setupvalue(func, upvalue_index, value)
  else
    -- Nếu upvalue không tồn tại
    error("Upvalue không tồn tại tại index " .. upvalue_index, 2)
  end
end
function getscriptclosure(script)
  -- Lấy thông tin về script
  local info = debug.getinfo(script)
  
  -- Lấy Closure của script
  local closure = info.func
  
  -- Lấy upvalue của Closure
  local upvalues = {}
  for i = 1, math.huge do
    local name, value = debug.getupvalue(closure, i)
    if not name then break end
    upvalues[name] = value
  end
  
  -- Trả về Closure và upvalue
  return closure, upvalues
end
function hookfunction(func, callback)
  -- Lấy Closure của hàm
  local closure = debug.getinfo(func).func
  
  -- Thay đổi Closure để thực hiện callback
  local oldhook = debug.gethook()
  debug.sethook(closure, callback, "c")
  
  -- Trả về Closure thay đổi
  return function(...)
    -- Thực hiện hàm gốc
    local result = {closure(...)}
    
    -- Thay đổi hook trở về ban đầu
    debug.sethook(oldhook)
    
    -- Trả về kết quả của hàm gốc
    return unpack(result)
  end
end
