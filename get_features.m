function [features] = get_features(signals)
    sample_rate = 44109; % hertz - Frecventa de esantionare a sunetelor
    size_signals = size(signals); % Dimensiunea matricii cu semnale
    sound_samples = size_signals(1); % Cate esantioane are fiecare sunet
    num_sounds = size_signals(2); % Cate sunete sunt in matrice
    N_coef = 12; % Numarul coeficienti mel-frequency cepstral
    
    % Impartirea duratei sunetului (secunde) in intervaluri care reprezinta
    % de cand pana cand e fiecare fereastra (tot in secunde)
    window_intervals = get_window_intervals(sound_samples / sample_rate);
    
    % Transformam intervalurile din secunde in esantioane, adica de la ce
    % esantion la ce esantion se refera o fereastra
    sample_intervals = get_sample_intervals(window_intervals);
    
    % Obtine ferestrele cu esantioane
    windows = get_windows(sample_intervals, signals);
    
    % Aplica transformata fourier rapida pe fiecare fereastra si pastram
    % doar primii 256 de coeficienti
    [fft_windows, num_windows] = get_fft_windows(windows);
    % size(fft_windows) = {num_ferestre, num_samples, num_semnale_audio} 362   256   300
    
    % Obtinem filtrul sub forma de triunghiuri
    triangle_filters = get_triangle_filters(N_coef);
    
    % Prealocam dimensiunea rezultatului 'features'
    features = zeros(num_sounds, 2 * N_coef + 1);
    
    % Iteram prin fiecare sunet
    for i = 1:num_sounds
        % Obtinem sunetul pentru calculul zero-crossing rate-ului
        from = sound_samples * (i - 1) + 1;
        to = sound_samples * i;
        sound = signals(from:to); % semnalul care trebuie prelucrat
        
        % Calculam zero-crossing rate-ul
        zero_crossing = mean(abs(diff(sign(sound)))); % source: https://www.mathworks.com/matlabcentral/answers/50070-how-can-i-calculate-zcr-zero-crossing-rate-threshold-for-a-given-signal
        
        % Obtinem o matrice care contine ferestrele de 256 de esantioane ale acestui sunet 
        frame = fft_windows(:,:,i)';
        
        % Ridicam la patrat modulul fiecarui coefifient apoi analizam fiecare fereastra
        frame = abs(frame).^2;
        
        % Aplicam filtrul tuturor ferestrelor si obtinem ca rezultat o
        % matrice cu suma tuturor coeficientilor spectrului ponderati
        filtered_frame = triangle_filters * frame;
        % Impartim la numarul de esantioane ca sa obtinem din suma, medie
        filtered_frame = filtered_frame ./ 256;
        % Acum avem media coeficientilor filtrati
        
        % Evitam existenta valorilor de 0 in matricea calculata mai devreme
        filtered_frame(filtered_frame==0)=10^-5;
        % Calculam logaritmul fiecarui termen din matrice
        filtered_frame = log(filtered_frame);
        
        % Calculam Media ferestrelor filtrate
        MFCC_mean = (sum(filtered_frame, 2) / num_windows)';
        % Calculam Varianta ferestrelor filtrate
        MFCC_variance = (var(filtered_frame, 0, 2))';

        % Asignare medie si varianta la MFCC
        MFCC = [MFCC_mean, MFCC_variance];
        % Asignare zero-crossing si MFCC
        features(i,:) = [MFCC, zero_crossing];
    end
end

