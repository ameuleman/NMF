function s = projeter(x,L1,L2);
%projeter un vecteur sur les vecteurs à composantes positives ou nulles
%le plus proche au sens des moindres carrés

n = length(x);

s = x+(L1-sum(x))/n;
e = ones(n,1)';
Z = [];
q = 0;

flag = true;

while flag
    m = L1/(n-q)*e;
    m(Z) = 0;
    
    %calcul de alpha
    tmp = s-m;
    c = [sum(tmp.^2) 2*sum(m.*tmp) sum(m.^2)-L2^2];
    delta = c(2)^2-4*c(1)*c(3);
    %r = [(-c(2)-sqrt(delta))/(2*c(1)) (-c(2)+sqrt(delta))/(2*c(1))];
    alpha = (-c(2)+real(sqrt(delta)))/(2*c(1));
        
    s = m+alpha*tmp;
    
    if any(s(:)<0)%si s a des composantes négatives
        %recherche des valeurs négatives
        Z = find(s<=0);
        q = length(Z);
    
        %on annule les composantes negatives de s
        s(Z) = 0;
    
        c = (sum(s)-L1)/(n-q);
        s = s-c;
        s(Z) = 0;
    else
        flag = false;
    end
end

end