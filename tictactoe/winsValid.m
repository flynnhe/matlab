function [valid, nwins_o, nwins_x] = winsValid(game, initGame, resetGame)
nwins_x = 0;
nwins_o = 0;
if game == resetGame
    valid = false;
    return;
end
game = reshape(game, 3, 3);
for i = 1 : 3
    row = game(i, :);
    col = game(:, i);
    % check for filled rows or cols
    nx_across = sum(row==1);
    no_across = sum(row==2);
    nx_down = sum(col==1);
    no_down = sum(col==2);
    if nx_across == 3
        nwins_x = nwins_x + 1;
    end 
    if no_across == 3
        nwins_o = nwins_o + 1;
    end
    if nx_down == 3
        nwins_x = nwins_x + 1;
    end
    if no_down ==3
        nwins_o = nwins_o + 1;
    end
    
end

% check for filled diagonals
diag_lr = [game(1,1) game(2,2) game(3,3)];
diag_rl = [game(1,3) game(2,2) game(3,1)];
nx_diag_lr = sum(diag_lr==1);
no_diag_lr = sum(diag_lr==2);
nx_diag_rl = sum(diag_rl==1);
no_diag_rl = sum(diag_rl==2);
 
if nx_diag_lr == 3
    nwins_x = nwins_x + 1;
end
if no_diag_lr == 3
    nwins_o = nwins_o + 1;
end
if nx_diag_rl == 3
    nwins_x = nwins_x + 1;
end
if no_diag_rl == 3
    nwins_o = nwins_o + 1;
end

valid = true;
% can't have both x and o winning
if nwins_x > 0 && nwins_o > 0
    valid = false;
end
end