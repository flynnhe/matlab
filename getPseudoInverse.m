function Xinv = getPseudoInverse(X)
[U, E, Vt] = svd(X);
Einv = E;
sz = size(E);
for i = 1 : min(sz(1), sz(2))
    Einv(i, i) = 1 / Einv(i, i);
end
Einv = Einv';
Xinv = Vt * Einv * U';
end