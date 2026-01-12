# 🏗️ Architecture du Système (High-Level Design) - CleanCity

Ce document présente la conception de haut niveau de l'application mobile **CleanCity**. Il détaille comment l'architecture choisie répond aux exigences fonctionnelles et techniques du projet **SE3140**.

---

## 1. Schéma Global de l'Architecture (Mermaid)

Le diagramme suivant illustre l'organisation en couches et la communication entre l'application mobile, le serveur d'hébergement et les services de données.

```mermaid
graph TD
    subgraph "Niveau Présentation (Application Mobile)"
        A[App Citoyen - Android/iOS]
        B[App Équipe de Nettoyage]
        C[App Administrateur]
    end

    subgraph "Niveau Hébergement (Point d'Entrée)"
        D[Serveur VPS - Hosting de l'Application & API]
    end

    subgraph "Niveau Services & Données (Backend BaaS)"
        E[Firebase Auth - Sécurité]
        F[Cloud Firestore - Base de Données NoSQL]
        G[Cloud Storage - Stockage des Images]
    end

    %% Flux d'interactions
    A & B & C <-->|Interface utilisateur mobile| D
    D <-->|SDK Firebase Mobile| E
    D <-->|Flux de données JSON| F
    D <-->|Upload/Download Photos HD| G
