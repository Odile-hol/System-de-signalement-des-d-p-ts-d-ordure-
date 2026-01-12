## 📊 Analyse et Conception

### Diagramme de Cas d'Utilisation (UML)




#### 👥 Les Acteurs et leurs Rôles :

* **Citoyen** : 
    * Signale les dépôts d'ordures sauvages avec photos et géolocalisation.
    * Consulte la carte de propreté en temps réel.
    * Suit l'évolution de ses signalements (En attente / Traité).
* **Équipe de nettoyage** :
    * Consulte la liste des tâches assignées par l'administration.
    * Met à jour le statut des interventions sur le terrain.
    * Fournit une preuve visuelle (photo) après le nettoyage.
* **Administrateur** :
    * Gère les comptes utilisateurs et les accès.
    * Assigne les interventions aux équipes disponibles.
    * Modère les signalements pour éviter les abus.
    * Analyse les statistiques globales de la ville.

#### 🔐 Sécurité et Authentification
Toutes les actions critiques (signalement, modification de statut, gestion) sont protégées par un cas d'utilisation **« S'authentifier »**. 
Les équipes de nettoyage et les administrateurs possèdent des codes de sécurité spécifiques pour valider leur identité professionnelle.
![Diagramme de Cas d'Utilisation](casUtilisation.PNG)
