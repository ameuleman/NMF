# NMF
Utilisation de la factorisation par matrices non négatives afin de réduire la composante spéculaire et faciliter le traitement d'image. Nos travaux se sont basés sur ces publications : *J. Mach P. Hoyer. Non-negative matrix factorization with sparseness constraints. Learning Res, (5) :1457–1469, 2004* donnant une implémentation de la méthode NMF avec contraintes de parcimonie et *M. S. Drew A. Madooeui. Detecting specular highlights in dermatological images.ICIP, 2015* qui décrit comment l'appliquer  aux images de la surface de la peaux afin d'isoler la composante spéculaire. 

## Prérequis
Nous utilisons *ShearLab 3D* pour reconstruire l'image par inpainting, il est donc nécessaire d'ajouter ***ShearLab3D v1.1*** et ***2D Experiments*** au path de Matlab. Ils sont disponibles sur http://www3.math.tu-berlin.de/numerik/www.shearlab.org/software.

Les résultats obtenus par inpainting n'étant pas satisfaisants et longs à obtenir, son utilisation est désactivée par défaut. il est possible de la réactiver en enlevant le commentaire dans ***nmf.m*** à la ligne 120 : 

	for i = 1:qI
  	  res(:,:,i) = inPainting(double(I(:,:,i)),mask);
	end

## Utilisation
Les images initiales sont stockées dans le répertoire *data/*.

***nmf.m*** permet de traiter les images en couleurs et les images en noir et blanc. Pour changer l'image à traiter, on modifie les données initiales au début de ce fichier. Par exemple, pour traiter la cinquième image : 

	%données initiales
	I = imread('data/image5.jpg');

L'exécution du programme peut prendre plusieurs minutes et dépend de la taille de l'image.

## Résultats des tests
Les résultats correspondant aux différentes images de test sont disponibles dans le répertoire *resultats/*. 

*premiers_res.png* correspond aux résultats obtenus avant l'amélioration de la méthode.

![result](/resultats/res1.png)
