function [samples] = get_sample_intervals(window_intervals)
    sz = size(window_intervals);
    fs = 44109;
    samples = zeros(sz(1), sz(2));
    for i = 0:sz(1) - 1
        from = floor(window_intervals(i + 1, 1) * fs);
        to = floor(window_intervals(i + 1, 2) * fs);
        samples(i + 1,:) = [from, to];
    end
end

