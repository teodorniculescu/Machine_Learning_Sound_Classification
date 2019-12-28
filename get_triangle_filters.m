function [filters] = get_triangle_filters(N_coef)
    freq = get_intervals(N_coef);
    fs = 44109;
    frequency = (0:255)/256*fs;
    filters = zeros(N_coef, 256);
    
    for coef = 1:N_coef
        val = zeros(1, 256);
        upper = freq(coef + 1); % frecventa de sfarsit a triunghiului
        lower = freq(coef); % frecventa de inceput a triunghiului
        mid = (upper + lower) / 2; % frecventa la care triunghiul are val 1
        
        % calculam pantele laturilor triunghiului
        m_st = 1 / (mid - lower);
        m_dr = 1 / (mid - upper);
        
        % calculeaza folosind ecuatia dreptei, valorile triunghiurilor
        for t = 1:256
            % linia din stanga a triunghiuliu
            if (frequency(t) > lower && frequency(t) <= mid)
                val(t) = m_st * (frequency(t) - lower);
            % linia din dreapta a triunghiuliu
            elseif (frequency(t) >= mid && frequency(t) < upper)
                val(t) = m_dr * (frequency(t) - upper);
            else
                % valorile care sunt in afara triunghiului
                val(t) = 0;
            end
        end
        filters(coef,:) = val;
    end
end

