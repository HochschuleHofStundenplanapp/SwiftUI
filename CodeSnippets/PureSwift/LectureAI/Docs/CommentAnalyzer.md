# CommentAnalyzer
## Einleitung
[`CommentAnalyzer`](../Sources/LectureAI/CommentAnalyzer.swift) sucht in den Kommentaren von Veranstaltungen nach Informationen über Besonderheiten zum Ablauf der Veranstaltung.

Die offizielle Web-API der Hochschule stellt leider keine gut Verarbeitbaren Daten zum Ablauf einer Veranstaltung zur Verfügung (14-tägig, Startwoche, Gruppeninformationen), deshalb versucht die Klasse [`CommentAnalyzer`](../Sources/LectureAI/CommentAnalyzer.swift) womöglich diese Informationen aus den Kommentaren der Veranstaltung zu lesen.

## Gesuchte Informationen

- [x] Veranstaltungs Beginn: Regex
- [x] Auflistung von Terminen: Regex
- [ ] 14-tägig: Regex TODO: Vorgehen bei unterbrechung des Intervalls(z.B. Ferien)
- [ ] Kombinationen

# Patterns
Auflistung von bekannten Regex Patterns und deren Funktion
## Start Kalenderwoche
`startKw1 = "(start|begin|beginn|beginning|ab):?\\s*(calendar)?\\s*(week|kw)\\s*(kw)?\\s*(\\d{1,2})"` 
> (start|begin|beginn|beginning|ab) gefolgt von (week|kw) gefolgt von Zahl.
> Beispiele:
> * "- Übungen - Start KW 17 (vorzugsweise für BW)" rückgabe `start_kw(17)`
> * "- Online-Anmeldung 01.04. - 06.04.2020 - Beginn KW 18 - max. 20 TN" rückgabe  `start_kw(18)`

`startKw2 = "(start|begin|beginn|ab)\\s*(\\d{1,2})\\.?\\s*kw"`
> (start|begin|beginn|ab) gefolgt von "Zahl" gefolt von "KW"
> Beispiele: 
> * "- Übungen über Tutor, Beginn 20. KW (= 11.05.20)" rückgabe start_kw(20)
> * "-lecture - (every second week) (language: english) start week KW 18 - online in moodle -" rückgabe start_kw(18)
## Liste von Veranstaltungs Wochen
let listKw1 = "kw\\s\\d+(,+\\s*\\d+)+(\\s*und\\s*\\d+)*"  //z.B. "14, 15, 16 und 18"
## 14-tägiger Rhythmus
let biWeekly1 = "14-tägig"
let biWeekly2 = "14 days"
let biWeekly3 = "every second week"
## Ausschluss Pattern
let dontParse = "kw.*kw.*"  //Wenn KW mehrmals vorkommt nicht parsen da zu viele sonderfälle
//comments mit - nicht möglich! -> "- ONLINE - KW 41 - 43 (Kick-Off und Coaching)"
## CommentFact
Maschine leserliche Version der Informationen die durch `analyzeComment` gefunden wurden.
### Intervall`public enum CommentFactInterval`
 * `weekly`(*Standard*) Veranstaltung wöchentlich
 * `bi_weekly` Veranstaltung 14-tägig
 * `not_defined` Unbekanntes Wiederholungs Intervall(z.B. Blockveranstaltungen)

### Typen`public enum CommentFactType`
 * `start_kw(Int)` Erste Vorlesung in Kalenderwoche int
 * `excluded_kws([Int])` Veranstaltungen nicht in Kalenderwochen [int]
 * `list_kws([Int])` Veranstaltungen in Kalenderwochen [int]
 * `no_info` Wenn keine Informationen zur Verfügung stehen oder zu Komplex zum auslesen sind.
