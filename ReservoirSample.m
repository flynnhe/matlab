function [reservoir] = ReservoirSample(stream, k)
if nargin == 0
    a = 1; % min
    b = 10000000; % max
    N = b - a + 1; % number of elements in full stream
    stream = rand(N, 1)*(b-a)+a;
    k = 100000; % number of elements to sample
end

%% create initial reservoir by taking first k items from stream
reservoir = stream(1:k, :);

%% go through the remainder of stream and randomly replace elements in the reservoir
for i = k + 1 : length(stream)
    r = round(rand()*(i-1-1)+1); % random number between 1 and i-1 inclusive
    if r <= k
        reservoir(r) = stream(i);
    end
end

%% plot the final sample
clf;
hist(reservoir);
end