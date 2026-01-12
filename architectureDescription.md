## 🛠️ Justification du Choix Architectural

Pour le projet **CleanCity**, nous avons implémenté une **Architecture Client-Serveur de type 3-Tier (N-Tier)** exploitant un modèle **BaaS (Backend-as-a-Service)**. Ce choix n'est pas fortuit et répond à des besoins techniques précis.

### 1. Structure de l'Architecture en 3 Couches
L'application est découpée en trois niveaux de responsabilité :

1.  **Couche de Présentation (Front-end Mobile) :**
    * Développée pour les plateformes mobiles, elle gère l'interface utilisateur et l'interaction avec le matériel (Caméra pour les photos de déchets, GPS pour la localisation).
2.  **Couche d'Application & Distribution (Hébergement VPS) :**
    * Le **serveur VPS** agit comme le pivot du système. Il assure la disponibilité publique de l'application et sert de passerelle sécurisée pour la distribution des services.
3.  **Couche de Données (Backend Cloud / Firebase) :**
    * Cette couche gère la persistance (Firestore) et le stockage des fichiers lourds (Cloud Storage). Le modèle BaaS permet une gestion des données sans serveur (Serverless), optimisant les performances mobiles.



### 2. Pourquoi ce choix pour CleanCity ?

* **Synchronisation en Temps Réel (Real-time) :** La gestion de la salubrité urbaine nécessite une réactivité immédiate. Firebase permet de notifier les équipes de nettoyage dès qu'un citoyen valide un signalement sur son mobile.
* **Sécurité et Gestion des Rôles :** Grâce à l'intégration de Firebase Auth, nous garantissons une séparation stricte des fonctionnalités : un citoyen ne peut pas modifier le statut d'une tâche de nettoyage, et une équipe ne peut pas supprimer un signalement.
* **Optimisation Mobile :** Le modèle BaaS réduit la charge de calcul sur le téléphone, prolongeant l'autonomie de la batterie des utilisateurs sur le terrain tout en offrant une base de données NoSQL flexible pour l'évolution du projet.
* **Conformité DevOps :** L'utilisation du VPS nous permet de mettre en pratique les compétences d'administration système et de déploiement continu exigées dans le cadre du module SE3140.

### 3. Comparaison Technique

| Caractéristique | Architecture Traditionnelle | Architecture CleanCity (BaaS) |
| :--- | :--- | :--- |
| **Vitesse de réponse** | Dépendante du serveur local | Optimisée par le CDN de Firebase |
| **Gestion des Images** | Complexe (Stockage disque local) | Simplifiée (Cloud Storage spécialisé) |
| **Sécurité** | À coder entièrement | Nativement gérée par Google Cloud |
| **Déploiement** | Long et fastidieux | Agile et orienté Mobile |
