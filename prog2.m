clearvars;

%données initiales
I = imread('Documents/projet_zakha/faces/face00001.pgm');
V = double(I);
%V = V(100:150,110:160);
%V = rand(256,256);

if min(V(:,:))<0, error('Valeurs négatives'); end

%dimensions
[n, p] = size(V);
r = input('Entrez r : ');

%sparceness
sW = 0;
sH = 0.4;

%initialisation de W et H
W = rand(n,r);
H = rand(r,p);

if sW > 0
    L1W = sqrt(n)*(1-sW)+sW;
    for i=1:r
        W(:,i) = projeter(W(:,i)',L1W,1)';
    end
end

if sH > 0
    L1 = (1-sH)*sqrt(p)+sH;
    for i=1:r
        H(i,:) = projeter(H(i,:),L1,1);
    end
end

WOld = zeros(n,r);
HOld = zeros(r,p);

%tolérances
epsW = 1e-5;
epsH = 1e-5;


iter = 0
muW = 0.85;
muH = 0.85;
while iter<1500%norm(W-WOld) > epsW || norm(H-HOld) > epsH
    %if norm(W-WOld) > epsW
        if sW > 0
            WOld = W;
            muW = 1.2*muW;
            flagW = true;
            obj = norm(V-W*H);
            
            while flagW
               W = W-muW*(W*H-V)*H';
               %projection
               L2W = arrayfun(@(i) norm(W(:,i)), 1:r);
               for i=1:r
                   W(:,i) = projeter(W(:,i)',L1W*L2W(i),L2W(i))';
               end

               
               if norm(V-W*H) < obj || muW < 1e-200
                   flagW = false;
               else
                   muW = muW/2;
               end
            end
            
        else%algo multiplicatif
            W = W.*(V*H')./(W*H*H');
        end
    %end
    
    %if norm(H-HOld) > epsH
        if sH > 0
            HOld = H;
            muH = 1.2*muH;
            flagH = true;
            obj = norm(V-W*H);
            
            while flagH
               H = H-muH*W'*(W*H-V);
               %projection
               L1 = (1-sH)*sqrt(p)+sH;
                for i=1:r
                    H(i,:) = projeter(H(i,:),L1,1);
                end
                
                if norm(V-W*H) < obj || muH < 1e-200
                    flagH = false;
                else
                    muH = muH/2;
                end
            end
        else%algo mutiplicatif
            H = H.*(W'*V)./(W'*W*H);
        end
    %end
    iter = iter +1
end

R = uint8(W*H);
%affichage pour les tests
%norm(uint8(V)-R)

figure
title('Méthode NMF')
subplot(1,4,1)
title('Image originale')
imshow(uint8(V))

subplot(1,4,2)
title('W')
imshow(uint8(W))

subplot(1,4,3)
title('H')
imshow(uint8(H))

subplot(1,4,4)
title('Image restituée')
imshow(uint8(R))