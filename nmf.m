clearvars;

%données initiales
I = imread('data/image1.png');

%dimensions de l'image
[nI, pI, qI] = size(I);

%initialisation de la matrice des données
k = 0;
n = qI;
p = nI*pI;
V = zeros(n, p);
for i = 1:nI
    for j = 1:pI
        k = k+1;
        V(:,k) = I(i,j,:); 
    end
end

if min(V(:,:))<0, error('Valeurs négatives'); end

V = double(V);

%dimensions des matrices correspondantes
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

iter = 0;
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
    iter = iter + 1;
end


%Séparation de la composante diffuse et spéculaire de l'image
WD = zeros(n, r-1);
HD = zeros(r-1, p);

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

RID = zeros(nI,pI,qI);
RIS = zeros(nI,pI,qI);
mask = zeros(nI,pI);

for i = 1:nI
    for j = 1:pI
        k = k+1;
        RID(i,j,:) = RD(:,k); 
        RIS(i,j,:) = RS(:,k);
        if norm(RIS(i,j))<30
            mask(i,j) = 1;
        else
            mask(i,j) = 0;
        end
    end
end

%Utilisation de l'algorithme d'inpainting
res = I;

% for i = 1:qI
%     res(:,:,i) = inPainting(double(I(:,:,i)),mask);
% end


CIS = RID.*RIS./255;

%affichage pour les tests

figure

subplot(2,3,1)
imshow(I)
title('Image originale')

subplot(2,3,2)
imshow(uint8(RID))
title('Composante diffuse')

subplot(2,3,3)
imshow(uint8(RIS))
title('Composante spéculaire')

subplot(2,3,4)
imshow(uint8(RID+RIS))
title('Image restituée')

subplot(2,3,5)
imshow(uint8(CIS+double(I)-RIS))
title('Image sans spécularité')

subplot(2,3,6)
imshow(uint8(res))
title('Image reconstituée par inpainting')