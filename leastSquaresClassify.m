function W = leastSquaresClassify(Xpos, Xneg)
close all;
if nargin == 0
    a = rand();
    b = rand();
    Xpos = randn(10, 2);
    Xneg = randn(10, 2);
    num_outliers = 4;
    Xneg_outliers = randn(num_outliers, 2);
    % generate separate sets of points on either side of a hypothetical line
    for i = 1 : 10
        Xpos(i,2) = (a+rand())*Xpos(i,1) + b+rand() - 2;
        Xneg(i,2) = (a+rand())*Xneg(i,1) + b+rand() + 2;
        if i <= num_outliers
            Xneg_outliers(i,2) = (a+rand())*Xneg_outliers(i,1) + b+rand() + 4;
        end
    end
end
%% find the w which minimizes 0.5*(wx-y)^2 for all points
all_points = [Xpos; Xneg];
[W, X, Y] = getLeastSquaresW(all_points);

%% draw the line y = wx
ys = X*W;
ax1 = subplot(1, 2, 1);
hold on;
plot(Xpos(:,1), Xpos(:,2), 'r.');
plot(Xneg(:,1), Xneg(:,2), 'b.');
plot(X(:,1), ys(:), 'g-');

%% add some outliers and see how badly least squares deals with those
all_points = [all_points; Xneg_outliers];
[W_outlier, X, Y] = getLeastSquaresW(all_points);
ys = X*W_outlier;
ax2 = subplot(1, 2, 2);
hold on;
plot(Xpos(:,1), Xpos(:,2), 'r.');
plot(Xneg(:,1), Xneg(:,2), 'b.');
plot(Xneg_outliers(:,1), Xneg_outliers(:,2), 'g.');
plot(X(:,1), ys(:), 'g-');
linkaxes([ax1,ax2],'xy')
end

function [W, X, Y] = getLeastSquaresW(points)
N = length(points(:,1));
X = [points(:,1) ones(N,1)];
Y = points(:,2);
% get the pseudo inverse of X using svd
Xinv = getPseudoInverse(X);
W = Xinv * Y;
end