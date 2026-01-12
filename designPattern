# 🛠️ Stratégie des Design Patterns - CleanCity

Ce document présente les **quatre modèles de conception** (Design Patterns) choisis pour structurer l'application CleanCity. Ces choix garantissent un code modulaire, une maintenance facilitée et une expérience utilisateur robuste.

---

## 1. Singleton (Patron de Création)
**Rôle : Gestion centralisée des ressources critiques.**

* **Description :** Ce pattern garantit qu'une classe n'a qu'une seule instance et fournit un point d'accès global à celle-ci.
* **Application dans CleanCity :** Utilisé pour le service d'authentification et l'accès à la base de données Firebase.
* **Impact Projet :** Il évite d'ouvrir des connexions multiples et redondantes. Cela optimise la consommation de données et préserve l'autonomie de la batterie du smartphone en centralisant les appels réseaux.



---

## 2. Factory Method (Patron de Création)
**Rôle : Instanciation dynamique des profils utilisateurs.**

* **Description :** Définit une interface pour la création d'objets, mais laisse les sous-classes décider de la classe à instancier.
* **Application dans CleanCity :** Création des profils types : **Citoyen**, **Équipe de nettoyage**, ou **Administrateur**.
* **Impact Projet :** Lors de la connexion, le système reçoit un rôle. La Factory instancie automatiquement le bon profil avec ses permissions spécifiques. Cela permet d'ajouter de nouveaux rôles (ex: Inspecteur municipal) sans modifier le code existant de l'interface.



---

## 3. Observer (Patron de Comportement)
**Rôle : Synchronisation des données en temps réel.**

* **Description :** Définit une dépendance de type "un-à-plusieurs" entre des objets afin que tout changement d'état d'un objet soit notifié automatiquement à ses dépendants.
* **Application dans CleanCity :** Mise à jour en direct de la carte des signalements de déchets.
* **Impact Projet :** Lorsqu'un citoyen signale un nouveau déchet, l'équipe de nettoyage voit l'alerte apparaître instantanément sur sa carte sans action manuelle. C'est le moteur de la réactivité du service CleanCity.



---

## 4. State (Patron de Comportement)
**Rôle : Pilotage du cycle de vie des signalements.**

* **Description :** Permet à un objet de modifier son comportement lorsque son état interne change, l'objet semblant alors changer de classe.
* **Application dans CleanCity :** Gestion du flux de travail d'un signalement : **Signalé** ➔ **En cours** ➔ **Traité**.
* **Impact Projet :** Un signalement ne se comporte pas de la même manière selon son avancement. Par exemple, le système empêche une équipe de marquer un déchet comme "Traité" s'il n'a pas été préalablement "Accepté". Cela sécurise la logique métier sur le terrain.



---

## 📊 Synthèse de l'apport architectural

| Design Pattern | Objectif Principal | Bénéfice pour l'utilisateur |
| :--- | :--- | :--- |
| **Singleton** | Cohérence système | Application stable, fluide et économe en ressources. |
| **Factory** | Flexibilité | Interface personnalisée selon le rôle de l'utilisateur. |
| **Observer** | Réactivité | Informations terrain mises à jour en temps réel. |
| **State** | Fiabilité | Suivi rigoureux et sans erreur du processus de nettoyage. |

---
