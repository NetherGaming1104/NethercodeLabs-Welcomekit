### **ESX ONE-TIME WELCOME KIT**

# 🎁 NetherCode Labs WelcomeKit

[](https://www.google.com/search?q=LICENSE)
[](https://discord.gg/3tjY25zctJ)
[](https://forum.cfx.re/)

Ein schlankes und effizientes ESX-Skript, das neuen Spielern einmalig ein konfigurierbares Willkommens-Kit gewährt. Das Skript nutzt `oxmysql` zur persistenten Speicherung der Nutzung, um sicherzustellen, dass jeder Spieler die Belohnung **nur einmal** erhält, unabhängig von Server-Neustarts.

**Entwickelt von NetherCode Labs.**

-----

### ✨ Features

  * **Einmalige Nutzung:** Durchgehende Datenbankprüfung (`oxmysql`) stellt sicher, dass der Befehl nur einmal pro Spieler-Identifier funktioniert.
  * **Volle Konfigurierbarkeit:** Einfaches Einstellen von Bargeld, Bankguthaben, normalen Items und Waffen in der `config.lua`.
  * **Kategorie-Schalter:** Separate `enabled`-Optionen, um Geld, Items oder Waffen komplett zu deaktivieren.
  * **ESX Legacy / Extended Kompatibilität:** Für moderne ESX-Server entwickelt.

-----

### ⚙️ Installation

#### 1\. Ressourcen-Voraussetzungen

Stelle sicher, dass die folgenden Ressourcen auf deinem Server laufen:

  * **`es_extended`** (ESX-Framework)
  * **`oxmysql`** (Zum Ausführen der asynchronen Datenbankabfragen)

#### 2\. Datenbank-Setup (WICHTIG\!)

Führe den folgenden SQL-Befehl in deiner Datenbank (z.B. über phpMyAdmin) aus, um die Speichertabelle zu erstellen:

```sql
CREATE TABLE IF NOT EXISTS `welcomekit_used` (
    `identifier` VARCHAR(60) NOT NULL PRIMARY KEY,
    `date_used` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);
```

#### 3\. Skript-Setup

1.  Lade das Skript herunter und platziere den Ordner in deinem `resources`-Verzeichnis.

2.  Passe die Belohnungen in der Datei **`config.lua`** an.

3.  Füge das Skript zu deiner `server.cfg` hinzu:

    ```cfg
    ensure oxmysql    # Muss vor dem Skript gestartet werden
    start welcomekit  # Oder wie du den Ordner benannt hast
    ```

-----

### 🛠️ Konfiguration (`config.lua`)

Die Belohnungen werden in der `config.lua` definiert.

```lua
Config.Reward = {
    -- Geld-Belohnungen
    money = {
        enabled = true, -- Setze auf FALSE, um diese Belohnungen zu überspringen
        cash = 5000, 
        bank = 10000 
    },
    -- ... und so weiter für Items und Waffen
}
```

-----

### ⌨️ Nutzung im Spiel

Spieler können das Kit über den konfigurierten Befehl anfordern:

| Befehl | Beschreibung |
| :--- | :--- |
| `/welcome` | Fordert das einmalige Willkommens-Kit an. |

-----

### 📞 Support & Community

Trete unserem Discord bei, um Unterstützung zu erhalten, Fehler zu melden oder einfach nur Hallo zu sagen\!

**Discord-Link:** [https://discord.gg/3tjY25zctJ](https://discord.gg/3tjY25zctJ)

-----

### 🤝 Lizenz

Dieses Projekt steht unter der **MIT License**. Details siehe [LICENSE](https://www.google.com/search?q=LICENSE).


