function [windows] = get_window_intervals(sound_duration)
	window_offset = 0.01;
    window_duration = 0.025;
    num_windows = ceil((sound_duration - window_duration) / window_offset);
    
    windows = zeros(num_windows, 2);
    for i = 0:num_windows - 1
        offset = window_offset * i;
        window = [offset, offset + window_duration];
        windows(i + 1,:) = window;
    end
end

