# CommentAnalyzer

## Einleitung
[`CommentAnalyzer`](../Sources/LectureAI/CommentAnalyzer.swift) sucht in den Kommentaren von Veranstaltungen nach Informationen über Besonderheiten zum Ablauf der Veranstaltung.

Die offizielle Web-API der Hochschule stellt leider keine gut Verarbeitbaren Daten zum Ablauf einer Veranstaltung zur Verfügung (14-tägig, Startwoche, Gruppeninformationen), deshalb versucht die Klasse [`CommentAnalyzer`](../Sources/LectureAI/CommentAnalyzer.swift) womöglich diese Informationen aus den Kommentaren der Veranstaltung zu lesen.

## Gesuchte Informationen

- [x] Veranstaltungs Beginn: Regex
- [x] Auflistung von Terminen: Regex
- [ ] 14-tägig: Regex TODO: Vorgehen bei unterbrechung des Intervalls(z.B. Ferien)
- [ ] Kombinationen

## Patterns
Auflistung von bekannten Regex Patterns und deren Funktionen

Kommentare werden vor der Überprüfung, durch die Funktion `.lowercased()` zu Kleingeschrieben umgewandelt.

### Start Kalenderwoche
`startKw1 = "(start|begin|beginn|beginning|ab):?\\s*(calendar)?\\s*(week|kw)\\s*(kw)?\\s*(\\d{1,2})"` 
> (start|begin|beginn|beginning|ab) gefolgt von (week|kw) gefolgt von "Zahl".  
> Beispiele:
> * "- Übungen - Start KW 17 (vorzugsweise für BW)" rückgabe `start_kw(17)`
> * "- Online-Anmeldung 01.04. - 06.04.2020 - Beginn KW 18 - max. 20 TN" rückgabe  `start_kw(18)`

`startKw2 = "(start|begin|beginn|ab)\\s*(\\d{1,2})\\.?\\s*kw"`
> (start|begin|beginn|ab) gefolgt von "Zahl" gefolt von "kw"  
> Beispiele:
> * "- Übungen über Tutor, Beginn 20. KW (= 11.05.20)" rückgabe `start_kw(20)`
> * "-lecture - (every second week) (language: english) start week KW 18 - online in moodle -" rückgabe `start_kw(18)`

### Liste von Veranstaltungs Wochen
`listKw1 = "kw\\s\\d+(,+\\s*\\d+)+(\\s*und\\s*\\d+)*"`
> "kw" gefolgt von Komma separierter Liste von "Zahlen" gefolgt von optionalen "und" + "Zahl"    
> Beispiel:
> * "KW 17, 18, 19, 21, 22 und 23" rückgabe `list_kws([17, 18, 19, 21, 22, 23])`

TODO:
 * "Ausstellungsdesign /  KW 43, 45, 47, virtuell" rückgabe ´list_kws([43, 45, 47)]` falsch positiv. Nicht bekannt welche anderen Listen existieren die andere Bedeutung haben.
 * "- ONLINE - KW 41 - 43 (Kick-Off und Coaching)"

### 14-tägiger Rhythmus
`biWeekly1 = "14-tägig"`
> sucht nach "14-tägig"  
> Beispiel:
> * "SAP ERP Simulation / - 14-tägig - ab KW 17" rückgabe `bi_weekly`

`biWeekly2 = "14 days"`
> sucht nach "14 days"  
> Beispiel:
> * "- Exercises - (all 14 days, begin: calendar Week 18)" rückgabe `bi_weekly`

`biWeekly3 = "every second week"`
> sucht nach "every second week"  
> Beispiel:
> * "-lecture - (every second week) (language: english) start week KW 18 - online in moodle -" rückgabe `bi_weekly`

### Ausschluss Pattern
Wenn "kw" mehrmals in einen Kommentar vorkommt werden keine Annahmen getroffen um falsch positiv zu vermeiden.

`dontParse = "kw.*kw.*"`
> sucht nach mehrmaligen vorkommen von "kw"  
> Beispiel:
> * "KW 42 - 3, außer KW 43, 47, 53, 1" rückgabe `no_info`
## CommentFact
Maschine leserliche Version der Informationen die durch `analyzeComment` gefunden wurden.

### Intervall
`public enum CommentFactInterval`
 * `weekly`(*Standard*) Veranstaltung wöchentlich
 * `bi_weekly` Veranstaltung 14-tägig
 * `not_defined` Unbekanntes Wiederholungs Intervall(z.B. Blockveranstaltungen)

### Typen
`public enum CommentFactType`
 * `start_kw(Int)` Erste Vorlesung in Kalenderwoche int
 * `excluded_kws([Int])` Veranstaltungen nicht in Kalenderwochen [int]
 * `list_kws([Int])` Veranstaltungen in Kalenderwochen [int]
 * `no_info` Wenn keine Informationen zur Verfügung stehen oder zu Komplex zum auslesen sind.
