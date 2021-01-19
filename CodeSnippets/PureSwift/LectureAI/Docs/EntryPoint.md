# Lecture AI

## Einstiegspunkt in das Projekt

Alles beginnt mit folgendem API Aufruf:

```swift
let dateUtil = TestDateUtil() // für tests
ODER
let dateUtil = DateUtil() // für produktivsystem

let ai = LectureAI(dateUtil)
let analyzedEvent = ai.parseEvent(
    term: "WS", 
    lecture: testLecture
)
```

LectureAI ist eine künstliche Intelligenz, die versucht die korrekten Zeitpunkte einer Vorlesung herauszufinden.
Dies ist notwendig, da die Web-API der Hochschule keine verlässlichen Start- und Endzeitpunkte zu einer Vorlesung liefert.
Außerdem werden ausgenommene Termine (z.B. Kalenderwochen in denen die Vorlesung nicht stattfindet) 
in dem Klartext-Feld "comment" kodiert.

Ein konkretes Beispiel, wie der fehlerhafte JSON aussieht, den die Hochschul-API liefert, 
ist in dem Kapitel [Problematik](Problem.md) zu finden.

Wenn man eine Instanz der Klasse `LectureAI` erstellt, 
muss als erster Parameter eine Instanz der Klasse `DateUtil` übergeben werden. 

Die konkrete Implementierung von `DateUtil` unterscheidet sich je nachdem, 
ob die `LectureAI`-Klasse zum Beispiel aus Unit-Tests getestet oder produktiv genutzt werden soll.
* Die `DateUtil` Klasse bezieht Daten, wie aktuellen Tag über die Swift-Date API.
* Die Unterklasse `TestDateUtil` hat Variablen, die statisch immer das gleiche Datum zurückgeben. 
  Dies hat den Vorteil, dass unabhänig vom aktuellen Zeitpunkt der Code immer zum gleichen Ergebnis kommt. 
Mehr dazu auch [im Kapitel Tests](Tests.md)  
  
Die Methode `parseEvent()` liefert für den Semestertyp (WS/SS) 
und einem Lecture-Objekt - welches eine Abbildung der Stundenplan Web-API auf Swift-Structs ist -
ein [`AnalyzedLecture`](../Sources/LectureAI/Models/AnalyzedLecture.swift)-Objekt zurück.

Dieses enthält folgende Informationen:
* Alle Informationen aus dem Lecture-Struct der API
* Eine Liste an [Events](../Sources/LectureAI/Models/AnalyzedLecture.swift), an denen die Vorlesung stattfindet.
  (Ein Event besteht immer aus Länge der Vorlesung in Minuten, sowie Start- und Endzeitpunkt als Swift-Dates)

Diese Informationen werden benötigt, um ein Event zum Beispiel später in den Smartphone-Kalender einzutragen.