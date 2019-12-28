function [windows] = get_windows(sample_intervals, signals)
    sz = size(sample_intervals);
    ssz = size(signals);
    num_samples = sample_intervals(1, 2) - sample_intervals(1, 1);
    windows = zeros(sz(1), num_samples, ssz(2));
    for sig_num = 1:ssz(2)
        for i = 0:sz(1) - 1
            from = sample_intervals(i + 1, 1);
            to = from + num_samples;
            from = from + 1;
            windows(i + 1,:,sig_num) = signals(from:to,sig_num);
        end
    end
end

