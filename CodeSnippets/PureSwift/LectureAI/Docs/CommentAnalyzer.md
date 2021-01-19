# CommentAnalyzer
## Einleitung
[`CommentAnalyzer`](../Sources/LectureAI/CommentAnalyzer.swift) sucht in den Kommentaren von Veranstaltungen nach Informationen über Besonderheiten zum Ablauf der Veranstaltung.
Die offizielle Web-API der Hochschule stellt leider keine gut Verarbeitbare Daten zum Ablauf einer Veranstaltung zur Verfügung wie (14-tägig, Startwoche, Gruppeninformationen) deshalb versucht die Klasse [`CommentAnalyzer`](../Sources/LectureAI/CommentAnalyzer.swift) womöglich diese Informationen aus den Kommentaren der Veranstaltung zu lesen.

## Gesuchte Informationen

- [x] Veranstaltungs Beginn: Regex
- [x] Auflistung von Terminen: Regex
- [ ] 14-tägig: Regex TODO: verfahren mit Pausen(z.B. Ferien)
- [ ] Kombinationen

## Comments Propertys
Maschine leserliche Version der Informationen die durch `analyzeComment` gefunden wurden.
### Intervall
 * `weekly`(*Standard*) Veranstaltung wöchentlich
 * `bi_weekly` Veranstaltung 14-tägig
 * `not_defined` Unbekanntes Wiederholungs Intervall(z.B. Blockveranstaltungen)

### Typen
 * `start_kw(Int)` Erste Vorlesung in Kalenderwoche int
 * `excluded_kws([Int])` Veranstaltungen nicht in Kalenderwochen [int]
 * `list_kws([Int])` Veranstaltungen in Kalenderwochen [int]
 * `no_info` Wenn keine Informationen zur Verfügung stehen oder zu Komplex zum auslesen sind.
