function [fft_windows, num_windows] = get_fft_windows(windows)
    %size(windows) = {numar_ferestre, numar_esantioane_fereastra,
    % numar_sunete}
    sz = size(windows);
    num_coef = 256;
    fft_windows = zeros(sz(1), num_coef, sz(3));
    for i=1:sz(1)
        for j=1:sz(3)
            fft_windows(i,:,j) = fft(windows(i, :, j), num_coef);
        end
    end
    num_windows = sz(1);
end

