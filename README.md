# Cleancity 🌍

**Cleancity** est une solution mobile innovante développée dans le cadre du cours **SE3140 : Software Design and Modelling**. [cite_start]L'application vise à résoudre le problème des décharges sauvages en milieu urbain en facilitant la communication entre les citoyens et les services de propreté municipaux.

## 📌 Problématique & Objectif
Actuellement, le suivi des dépôts d'ordures illégaux repose sur des méthodes manuelles peu réactives. [cite_start]**Cleancity** numérise ce processus pour permettre une remontée d'informations en temps réel, optimisant ainsi les tournées de collecte et améliorant la salubrité publique[].

## 🛠️ Fonctionnalités Principales (MVP)
[cite_start]L'application s'articule autour de trois profils d'utilisateurs:
* [cite_start]**Citoyens :** Création de compte, signalement avec photo, géolocalisation automatique et suivi de l'historique
* **Administrateurs :** Visualisation globale des signalements, validation des requêtes et assignation des tâches aux équipes.
* **Équipes de Nettoyage :** Réception des ordres de mission, navigation vers le site via GPS et validation de l'intervention.

## 📈 Gestion de Projet (Agile Scrum)
[cite_start]Le projet suit la méthodologie **Scrum** pour assurer une livraison itérative et transparente.
* **Product & Sprint Backlog :** Consultable dans le fichier `backlog.md`.
* [cite_start]**Suivi des tâches :** Nous utilisons un tableau Trello pour gérer le workflow (To Do, In Progress, Review, Done) .

🔗 **Lien du tableau Trello :** [Projet Clean City] https://trello.com/b/fEAjuKzF/projet-clean-city

## 🏗️ Architecture & Design
[cite_start]Ce projet met l'accent sur la conception logicielle rigoureuse (LLD & HLD):
* [cite_start]**UML :** Diagrammes de cas d'utilisation, de classes, de séquence, d'activité et de déploiement (disponibles dans le dossier `/design`) 
* [cite_start]**Design Patterns :** Implémentation de 4 patterns (Singleton, Factory, etc.) pour garantir une architecture robuste et évolutive.

## 💻 Stack Technique
* [cite_start]**Frontend :** Flutter / Dart (Application multiplateforme).
* **Backend :** [Ajoute ici : Firebase ou Node.js/MySQL] pour la persistance des données.
* [cite_start]**DevOps :** Déploiement automatisé sur serveur **VPS** .

## 📋 Installation & Lancement
```bash
# Cloner le projet
git clone [https://github.com/](https://github.com/)[odile hol]/cleancity.git

# Installer les dépendances
flutter pub get

# Lancer l'application
flutter run
