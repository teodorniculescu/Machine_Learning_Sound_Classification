    
    

% Tema PS 2019
% Autor: Niculescu Teodor-Vicentiu

clear all 
close all

% [audio_train,labels_train, audio_test,labels_test] = load_data();
load('data.mat')

% calculam featureurile pentru datasetul de train / test
% get_features primeste toate sunetele din set date intr-o matrice
% de dimensiune Numar_sunete x Numar_esantioane si returnează toate
% featurile acestor sunete intr-o matrice de dimensiune Numar_sunete x (2 * N + 1)
% TODO: calculati featurile MFCC si zero-crossing
feat_train = get_features(audio_train);
feat_test = get_features(audio_test);

% antrenam un clasificator
lda=fitcdiscr(feat_train,labels_train,'discrimType','pseudoLinear' );

% prezicem clasele pentru datasetul de train si de test
pred_train = predict(lda,feat_train);
pred_test = predict(lda,feat_test);


% calculam acuratetea pe train si test
acc_test  = mean(pred_test(:) == labels_test(:));
acc_train = mean(pred_train(:) == labels_train(:));

sprintf('Accuracy on train: %0.2f', acc_train)
sprintf('Accuracy on test: %0.2f', acc_test)

% alegem random un fisier audio si verificam daca am clasificat corect
labels_name = ["Dog","Rooster", "Rain" , "Waves","Fire","Baby",...
    "Sneezing","Clock","Helicopter","Chainsow"];

% TODO: verificati calitativ cateva exemple din setul de test. 
% comparati clasa corecta si clasa presiza cu sunetul auzit
for r = 1:99
    sprintf('Corect: %s, Prezis: %s', labels_name(labels_test(r)), labels_name(pred_test(r)))
end