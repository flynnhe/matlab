function g = doBestMove(games, game, player, initGame, resetGame)
n = sum(game==0);
if n == 0
    g = resetGame;
    return;
end
bestI = -1;
bestV = 0;
if player == 2
    bestV = 999999;
end
order = randperm(9);
for n = 1 : 9
    i = order(1, n);
    if game(i) ~= 0 % already played
       continue; 
    end
    tempgame = game;
    tempgame(i) = player;
    Vnext = games(hash(tempgame));

    if player == 1
        if Vnext > bestV % include the situation where you can't do better
            bestI = i;
            bestV = Vnext;
        end
    else
        if Vnext < bestV % include the situation where you can't do better
            bestI = i;
            bestV = Vnext;
        end
    end

end

g = game;
if bestI == -1 % no move to improve player's situation
    g = resetGame; % set it to invalid
else
    g(bestI) = player;
end
end