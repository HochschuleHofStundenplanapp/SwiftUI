# LectureAI

## Einleitung

LectureAI ist eine Intelligenz,
welche alle Zeitpunkte einer Vorlesung anhand des übergebenen Lecture-Objekts herausfindet.

Leider liefert die offizielle Web-API der Hochschule Hof aktuell
zu einer Vorlesung keinen verlässlichen Start- und Endzeitpunkt.
Deshalb müssen gewisse Grundannahmen getroffen werden,
anhand denen eine Liste an Vorlesungszeitpunkten generiert wird.
(z.B. Die ersten WS-Vorlesungen beginnen am Montag nach dem 01.10.)

Außerdem wird das Freitext-Kommentarfeld einer Vorlesung ausgewertet,
indem Vorlesungstermine nochmal genauer spezifiziert werden können.

Die Library soll später in der App verwendet werden, um Vorlesungen in den Smarphone-Kalender übertragen zu können.

## Dokumentation

* [Einstiegspunkt in die Library](Docs/EntryPoint.md)
* [Unit Tests](Docs/Tests.md)
* [Utility Klassen](Docs/Utils.md)
