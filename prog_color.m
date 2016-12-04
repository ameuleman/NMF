clearvars;

%données initiales
I = imread('sample1.png');

%dimensions de l'image
[nI, pI, qI] = size(I);
if qI~=3, error('problème de couleur'); end

%initialisation de la matrice des données
k = 0;
for i = 1:nI
    for j = 1:pI
        k = k+1;
        V(:,k) = I(i,j,:); 
    end
end

if min(V(:,:))<0, error('Valeurs négatives'); end

V = double(V);

%dimensions des matrices correspondantes
[n, p] = size(V);
r = 2;

%sparceness
sH1 = 0.001;
sH2 = 0.4;

%initialisation de W et H
W = rand(n,r);
H = rand(r,p);

L1 = (1-sH1)*sqrt(p)+sH1;
for l = 1:(r-1)
    H(l,:) = projeter(H(l,:),L1,1);
end
L1 = (1-sH2)*sqrt(p)+sH1;
H(2,:) = projeter(H(2,:),L1,1);
    
WOld = zeros(n,r);
HOld = zeros(r,p);

%tolérances
epsW = 1e-5;
epsH = 1e-5;

iter = 0
muW = 0.85;
muH = 0.85;
while iter<500
    W = W.*(V*H')./(W*H*H');
    
    HOld = H;
    muH = 1.2*muH;
    flag = true;
    obj = norm(V-W*H);
            
    while flag
        H = H-muH*W'*(W*H-V);
        %projection
        L1 = (1-sH1)*sqrt(p)+sH1;
        for l = 1:(r-1)
            H(l,:) = projeter(H(l,:),L1,1);
        end
        L1 = (1-sH2)*sqrt(p)+sH1;
        H(r,:) = projeter(H(r,:),L1,1);
    
            
        if norm(V-W*H) < obj || muH < 1e-200
            flag = false;
        else
            muH = muH/2;
        end
    end
    iter = iter + 1
end


%Séparation de la composante diffuse et spéculaire de l'image

for i = 1:(r-1)
    WD(:,i) = W(:,i);
    HD(i,:) = H(i,:);
end
WS = W(:,r);

HS = H(r,:);

RD = (WD*HD);
RS = (WS*HS);

%Reconstruction de l'image en matrice de tableaux
k = 0;

for i = 1:nI
    for j = 1:pI
        k = k+1;
        RID(i,j,:) = RD(:,k); 
        RIS(i,j,:) = RS(:,k); 
    end
end

CIS = RID.*RIS./255;

%affichage pour les tests

figure

subplot(1,5,1)
imshow(I)
title('Image originale')

subplot(1,5,2)
imshow(uint8(RID))
title('Composante diffuse')

subplot(1,5,3)
imshow(uint8(RIS))
title('Composante spéculaire')

subplot(1,5,4)
imshow(uint8(RID+RIS))
title('Image restituée')

subplot(1,5,5)
imshow(uint8(CIS+double(I)-RIS))
title('Image sans spécularité')
