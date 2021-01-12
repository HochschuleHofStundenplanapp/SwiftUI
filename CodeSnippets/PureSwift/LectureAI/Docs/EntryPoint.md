# Lecture AI

## Einstiegspunkt in das Projekt

Alles beginnt mit folgendem API Aufruf:

```
let ai = LectureAI(dateUtil)
let analyzedEvent = ai.parseEvent(
    term: "WS", 
    lecture: testLecture
)
```

LectureAI bekommt eine Instanz des Typs `DateUtil` übergeben. 
Die konkrete Implementierung von `DateUtil` unterscheidet sich je nachdem, 
ob die `LectureAI`-Klasse aus Unit-Tests getestet oder produktiv genutzt wird.
Mehr dazu [im Kapitel Tests](Tests.md)  

Die Methode `parseEvent()` liefert für den Semestertyp (WS/SS) 
und einem Lecture-Objekt - welches eine Abbildung der Stundenplan Web-API auf Swift-Structs ist -
ein [`AnalyzedLecture`](../Sources/LectureAI/Models/AnalyzedLecture.swift)-Objekt zurück.

Dieses enthält folgende Informationen:
* Alle Informationen aus dem Lecture-Struct der API
* Eine Liste an [Events](../Sources/LectureAI/Models/AnalyzedLecture.swift), an denen die Vorlesung stattfindet.
  (Ein Event besteht immer aus Länge der Vorlesung in Minuten, sowie Start- und Endzeitpunkt als Swift-Dates)

Diese Informationen werden benötigt, um ein Event später in den Smartphone-Kalender einzutragen.