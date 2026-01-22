table.unpack = table.unpack or unpack -- 5.1 compatibility
table.merge = function (t1, t2)
    t1 = t1 or {}
    t2 = t2 or {}
    for k, v in pairs(t2) do
        if type(t1[k]) == "table" and type(v) == "table" then
            table.merge(t1[k], v)
        else
            t1[k] = v
        end
    end
    return t1
end
