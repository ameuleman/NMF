# NMF
Utilisation de la factorisation par matrices non négatives afin de réduire la composante spéculaire et faciliter le traitement d'image.

##Prérequis
Nous utilisons *ShearLab 3D* pour reconstruire l'image par inpainting, il est donc nécessaire d'ajouter ***ShearLab3D v1.1*** et ***2D Experiments*** au path de Matlab. Ils sont disponibles sur http://www3.math.tu-berlin.de/numerik/www.shearlab.org/software.

Les résultats obtenus par inpainting n'étant pas satisfaisants et longs à obtenir, il est possible de désactiver son utilisation en commentant dans ***nmf.m*** à la ligne 120 : 

	for i = 1:qI
  	  res(:,:,i) = inPainting(double(I(:,:,i)),mask);
	end

##Utilisation
Les images initiales sont stockées dans le répertoire *data/*.

***nmf.m*** permet de traiter les images en couleurs et les images en noir et blanc. Pour changer l'image à traiter, on modifie les données initiales au début de ce fichier. Par exemple, pour traiter la cinquième image : 

	%données initiales
	I = imread('data/image5.jpg');

L'exécution du programme peut prendre plusieurs minutes et dépend de la taille de l'image.

##Résultats des tests
Les résultats correspondant aux différentes images de test sont disponibles dans le répertoire *resultats/*. 

*premiers_res.png* correspond aux résultats obtenus avant l'amélioration de la méthode.
