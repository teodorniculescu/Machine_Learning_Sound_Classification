    
    

function freq = get_intervals(N)
% returneaza N intervale egal distribuite pe scala Mel
fs = 44109;
% vrem o multime de filtre bandpass 
% vrem frecvente intre 0 si fs/2
min_f = 0;
max_f = fs / 2;

% vrem ca filtrele sa aiba banda mai mare pentru frecventele inalte
%  pentru ca oricum nu sunt asa distinctive pentru recunoastere de sunete
% gasim volorile in scala mel pentru minimul si maximul frecventelor folosite
min_mel = 1127 * log(1+min_f/700);
max_mel = 1127 * log(1+max_f/700);
% intervale egal departate in mel vor fi din ce in ce mai mari in scala normala
mels = linspace(min_mel,max_mel,N+1);
% ne intoarcem in scala normala
freq = 700 * (exp(mels / 1127) - 1);

end