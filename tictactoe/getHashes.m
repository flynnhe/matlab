function list = getHashes(list)
for i = 1 : numel(list)
    list{i} = hash(list{i});
end
end

function h = hash(num)
h = 0;
for i = 9 : -1 : 1
    h = h + num(i) * 10 ^ (9-i);
end
end