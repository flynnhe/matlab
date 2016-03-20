function g = doRandomMove(games, game, player, initGame, resetGame)
n = sum(game==0);
if n == 0
    g = resetGame;
    return;
end
order = randperm(9);
for i = 1 : 9
    r = order(i);
    if game(r) == 0
        game(r) = player;
        break;
    end
end
g = game;
end