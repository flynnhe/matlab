initGame = zeros(9,1);
resetGame = -1*ones(9,1);

games = genAllValidGames(initGame, resetGame);

eps = 0.1;
maxGames = 100000;
lrRate = 0.99;

game = initGame; % empty board
player = 0;
numGames = 0;

while numGames < maxGames
    r = rand();
    hgame = hash(game);
    greedy = false;
    if r < eps % choose a random move
        g = doRandomMove(games, game, player + 1, initGame, resetGame);
    else % greedily choose next move
        greedy = true;
        g = doBestMove(games, game, player + 1, initGame, resetGame);
    end
    hg = hash(g);
    [valid, nwins_o, nwins_x] = winsValid(g, initGame, resetGame);
    if valid
        if greedy % only update during greedy moves
            games(hgame) = games(hgame) + lrRate * (games(hg) - games(hgame));
        end
        game = g;
        if nwins_o > 0 || nwins_x > 0
            game = initGame;
            numGames = numGames + 1;
            if mod(numGames, 1000) == 0
                disp(numGames);
            end
        end
    else
        game = initGame;
        numGames = numGames + 1;
    end
    player = ~player;
end
t=2;