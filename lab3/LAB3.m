%κλεισιμο και καθαρισμα ολων
close all; clear all; clc;

%στα 2009b εμφανιζει warning οτι η blkproc θα καταργηθει!!
warning off all; 

%Διαβασμα εικονας και μετατροπη σε double (τα προβληματα συμβατοτητας εχουν
%λυθει παρακατω χωρις να παρουσιαζει προβλημα η im2double)
I = im2double(imread('flowers.tif'));

%Βασικες αρχικοποιήσεις
h = waitbar(0,'Please wait...');            %εμφανιση μπαρας αναμονης
steps = 20;                                 %συνολο βηματων επαναληψης                        
SNR = zeros(1,19);                          %αρχικοποιηση πινακα SNR
CR = zeros(1,19);                           %αρχικοποιηση πινακα CR
lamda = zeros(1,19);                        %αρχικοποιηση πινακα λ

%Επαναληπτικη διαδικασια υπολογισμου SNR,CR και λ μεσω των συναρτησεων
for i = 2:steps;                            %για ολα τα βηματα       
    waitbar((i-1)/steps)                    %εμφανιση μπαρας αναμονης
    k_Y = i;                                %το k_Y 
    k_C = i/2;                              %to k_C=k_Y/2
    [Z_Y,Z_Cb,Z_Cr] = dct_block(I,i,i/2);   %βλεπε dct_block
    [SNR_Z(i-1), CR_Z(i-1)] = ...           %βλέπε idct_zigzag
        idct_zigzag(Z_Y, Z_Cb, Z_Cr, I);
    lamda_Z(i-1) = 1/CR_Z(i-1);             %λ=1/CR
    
    %υπολογισμος σχεσης q με την μεταβολη του i απο τη σχεση ευθείας
    %f(x)-f(x0) = λ (x-x0) άρα 
    %q(i)-q(2) = [(q(20)-q(2))/(20-2)]*(i-2) , με q(1)=0.2 και q(20)=16
    q = ((16-0.2)/(20-2))*i + 0.2 - ((16-0.2)/(20-2))*2;
    
    [Q_Y,Q_Cb,Q_Cr] = dct_quant(I,q);       %βλεπε dct_quant       
    [SNR_Q(i-1), CR_Q(i-1)] = ...           %βλεπε idct_quant
        idct_quant(Q_Y, Q_Cb, Q_Cr, I, q);
    lamda_Q(i-1) = 1/CR_Q(i-1);             %λ=1/CR 
    
end
close(h)                                    %κλεισε παραθυρο αναμονης

% Τα ζητουμενα plots
figure; hold on; box on;
plot(lamda_Z,SNR_Z,'LineWidth',2);
plot(lamda_Q,SNR_Q,'r','LineWidth',2); 
xlabel('λ');
legend('SNR_Z(λ_z)','SNR_Q(λ_Q)',4);

%Uncomment για περισσοτερη πληροφορια!
%Αυτα ειναι προαιρετικα και δεν χρειαζονται καθως απεικονιζουν τα SNR και
%το λ ως συναρτηση του k_Y και Q ,ωστοσο εξαγονται χρησιμα αποτελεσματα
figure;
subplot(2,1,1); 
plot(2:20,SNR_Z);
title('Μέθοδος zig-zag');
xlabel('k _ Y');
legend('SNR');
subplot(2,1,2);
plot(2:20,lamda_Z,'r');
xlabel('k _ Y');
legend('λ')
figure;
subplot(2,1,1); 
plot(linspace(0.2,16,length(SNR_Q)),SNR_Q);
title('Μέθοδος quantization');
xlabel('q');
legend('SNR');
subplot(2,1,2);
plot(linspace(0.2,16,length(lamda_Q)),lamda_Q,'r');
xlabel('q');
legend('λ');












