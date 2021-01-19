# API-Vorschläge
Vorschläge für API Änderungen um sie besser automatisiert Bearbeiten zu können.

Vorschläge aus Sicht von Stundenplan App Entwicklung.

## Aktuelle JSON Rückgabe
```json
{
    "id": "3864519",
    "label": "Gestaltungsprojekte 1",
    "docent": "XXXXX",
    "type": "HF",
    "style": "Vorlesung Fixzeit",
    "group": "",
    "starttime": "09:45",
    "endtime": "11:15",
    "startdate": "04.03.2020",
    "enddate": "20.01.2021",
    "day": "Mittwoch",
    "room": "virt_XXXXX",
    "splusname": "GestaltP1§XXXXX%68395 $ 2",
    "comment": "Storytelling \/ KW 41- KW 3, außer KW 47 virtuell",
    "sp": "-"
}
```
## JSON Rückgabe laut Doc
```json
{
    "version": Aktuelle Schnittstellenversion,
    "schedule": [
        {
            "id": String Tabellen-ID,
            "label": String Vorlesungsbezeichner,
            "docent": String Dozentenname,
            "type": String Vorlesungs Typ, AWPM oder FWPM bei Wahlpflichtfächer, sonst HF,
            "style": String Art der Vorlesung,
            "group": String Gruppe,
            "starttime": String Startzeitpunt der Vorlesung (HH:mm),
            "endtime": String Endzeitpunt der Vorlesung (HH:mm),
            "startdate": String Datum der ersten Vorlesung (dd.mm.yyyy),
            "enddate": String Datum der letzten Vorlesung (dd.mm.yyyy),
            "day": String Wochentag,
            "room": String Raum,
            "splusname": String SplusName,
			"comment": String Kommentar der Vorlesung,
            "sp": String Die SP Information, "-" wenn keiner vorhanden ist und z.B. "SP (MB)" wenn ein SP vorhanden ist
        },
        {
            ...
        }
    ]
}
```

## Gesuchte Informationen

 * startdate: vorhanden nicht immer Richtig
 * starttime: vorhanden verwendbar
 * endtime: vorhanden verwendbar
 * interval: nicht vorhanden(siehe unten)
 * group: vorhanden nicht einheitlich verwendet
 
### Startdate
Datum von der ersten Veranstaltung. 

Aktuelle Verwendung nicht klar. Laut Dokumentation gewünschtes Verhalten.

### Starttime
Uhrzeit Start der Veranstaltung.

### Endtime
Uhrzeit Ende der Veranstaltung.

### Intervall
Rhythmus der Vorlesung.

Besser Liste von Terminen an denen die Veranstaltung stattfindet.

### Group
Gruppe bei Aufgeteilten Veranstaltungen.

Vorschlag jede Gruppe eigene Veranstaltung, momentan teilweise gleiche Veranstaltung aber 14-tägiger Rhythmus.

## Vorschlag
Statt Zwei Scheduele Objekten bei Vorlesungen mit mehren Veranstaltungen, ein Objekt mit einer Liste an Terminen an denen die Veranstaltung statt findet. 

Weiterer Vorteil Intervall der Vorlesung ist klar.

Mögliche Problematik:
 * keine Übersicht über alle Veranstalltungen(Veranstalung anzeigen ohne Datums werte)
