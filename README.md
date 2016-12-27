# NMF
<p>Utilisation de la factorisation par matrices non négatives afin de réduire la composante spéculaire et faciliter le traitement d'image.</p>

##Prérequis
<p>Nous utilisons ShearLab 3D pour reconstruire l'image, il est donc nécessaire d'ajouter *ShearLab3D v1.1* et *2D Experiments* au path de Matlab. Ils sont disponibles sur http://www3.math.tu-berlin.de/numerik/www.shearlab.org/software.</p>

##Utilisation
<p>Les images initiales sont stockées dans le répertoir *data/*.</p>
<p>*nmf_couleur.m* permet de traiter les images en couleur et les images en noir et blanc. Pour changer l'image à traiter, on modifie les données initiales dans ces fichier. Par exemple, pour traiter la cinquième image :

	%données initiales
	I = imread('data/image5.jpg');
</p>
<p>L'exécution du programme peut prendre plusieurs minutes et dépend de la taille de l'image.</p>

##Résultats des tests
<p>Les résultats correspondant aux différentes images de test sont disponibles dans le répertoire *resultats/*. </p>
<p>*premiers_res.png* correspond aux résultats optenu avant l'amélioration de la méthode.</p>
