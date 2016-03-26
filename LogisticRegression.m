function W = LogisticRegression(Xpos, Xneg)
close all;
if nargin < 2
    a = rand();
    b = rand();
    Xpos = randn(10, 2);
    Xneg = randn(10, 2);
    % generate separate sets of points on either side of a hypothetical line
    for i = 1 : 10
        Xpos(i,2) = (a+rand())*Xpos(i,1) + b+rand() - 2;
        Xneg(i,2) = (a+rand())*Xneg(i,1) + b+rand() + 2;
    end
end

num_iters = 1000;
lrRate = 0.1;
N = length(Xpos) + length(Xneg);
X = [Xpos; Xneg];
X = [X ones(N,1)];
T = [ones(length(Xpos),1); zeros(length(Xneg),1)];

f = figure;
hold on;

%% initialize weights to random
W = randn(3, 1);

%% do stochastic gradient descent (one example at a time to update w)
for i = 1 : num_iters
    %clf;
    for j = 1 : N
        y_j = sigmoid(X(j,:)*W);
        dEdW = (y_j - T(j)) * X(j,:);
        % update the weights
        W = W - lrRate*dEdW';
    end
    cla;
    E = getCrossEntropyError(W, X, T, f);
    disp(E);
end
end

function E = getCrossEntropyError(W, X, T, f)
    N = length(X);
    E = 0;
    
    for i = 1 : N
        y_i = sigmoid(X(i,:)*W);
        E = E + T(i)*log(y_i) + (1-T(i))*log(1-y_i);
        if y_i >= 0.5 % plot positive points
            plot(X(i,1), X(i,2), 'r+');
        else % plot negative points
            plot(X(i,1), X(i,2), 'b.');
        end
    end
    % draw the line corresponding to xw = 0
    for i = 1 : length(X)
        y = -(W(1)/W(2))*X(i,1) - (W(3)/W(2));
        plot(X(i,1), y, '.g');
    end
    E = -E;
    pause(0.0001);
end
