# LectureAI

## Einleitung
Hier wird der Aufbau der LectureAI Klasse beschrieben.


## Grundunterscheidung

Die Klasse `LectureAI` enthält die Methode `parseEvent()`, welche eine einzelne Vorlesung analysiert und
ein `AnalyzedLecture`-Struct mit passenden Vorlesungszeitpunkten zurückgibt.

Zuerst wird eine Grundunterscheidung nach Vorlesungstyp getroffen:
* Für Block-Events werden die Zeitpunkte verwendet, welche die Hochschul-API zurückliefert.
* Andere Events mit fester Zeit benötigen eine komplexere Behandlung

## Berechnung der Termine für Fixzeit-Events

Um die passenden Termine zu berechnen, werden nacheinenader folgende Schritte ausgeführt:

1. Berechnung aller möglichen Datumswerte in einem Zeitraum. `LectureDateCalculator`
2. Analyiseren des Lecture-Kommentars.   
    a) Sammeln von mehreren sogennante Comment-Facts. (Beispiel: `start_kw` + `50`)  
    b) Berechnung der finalen Datumswerten aus den möglichen Datumswerten und den gesammelten Comment-Facts 