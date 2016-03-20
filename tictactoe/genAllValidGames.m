function games = genAllValidGames(initGame, resetGame)
n = 3 ^ 9;
games = cell(n, 2);
k = 0;
%% generate all games but don't keep the invalid ones
for i = 0 : n-1
    game = getGame(i, 3);
    [valid, nwins_o, nwins_x] = isValidGame(game, initGame, resetGame);
    if valid
        initVal = 0.5;
        if nwins_x > 0
            initVal = 1.0;
        end
        if nwins_o > 0
            initVal = 0.0;
        end
        k = k + 1;
        games{k, 1} = game;
        games{k, 2} = initVal;
    end
end
games = games(1:k, :);
games = containers.Map(getHashes(games(1:k, 1)), games(1:k, 2));
end
 
%% check if tictactoe configuration is valid
function [valid, nwins_o, nwins_x] = isValidGame(game, initGame, resetGame)
nx = sum(game==1);
no = sum(game==2);
valid = false;
nwins_o = 0;
nwins_x = 0;
if abs(nx - no) <= 1
    [valid, nwins_o, nwins_x] = winsValid(game, initGame, resetGame);
end
end

function g = getGame(i, base)
g = zeros(9, 1);
k = 1;
while i > 0
    g(k) = mod(i, base);
    k = k + 1;
    i = floor(i / base);
end
end