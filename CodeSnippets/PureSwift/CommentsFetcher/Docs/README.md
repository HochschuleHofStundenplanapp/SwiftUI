A description of this package.


# CommentsFetcher

## Einleitung

Der CommentsFetcher nutzt die Pipelines, um an Daten - z.B. Kommentare - der Vorlesungen zu kommen. Mit den Informationen der Lectures kann die LectureAI getestet werden.

![DateUtil+TestDateUtil](Resources/CommentsFetcher.PNG)

## LectureDownloader

Der LectureDownloader ist ein Clerk, welcher die Daten aller Vorlesungen herunterlädt, indem er die Pipeline-Klasse verwendet. Die Daten werden dann in json-files gespeichert. 

*Der LectureDownloader wird nur zum Testen der LectureAI gebraucht. Nachdem die Vorlesungen heruntergeladen wurden, wird er nicht mehr gebraucht*.

## Pipelines

* bietet Methoden, mit welchen der LectureDownloader arbeiten kann.

## CommentsFetcher

Der CommentsFetcher ist ein Clerk, welcher die Kommentare aus lokalen Daten lädt. Diese Daten, welche Informationen zu den Vorlesungen enthalten, wurden vorher vom LectureDownloader bereitgestellt.

* die Methode loadAndStoreAllComments() filtert dabei alle Kommentare aus den Daten und speichert sie dann in eine eigen json-file (comments.json)

* Das ComentInfo-struct bestimmt, welche Informationen aus den Files geladen werden sollen 

## Models

Die Models richtigen sich nach der Datenstruktur der Hochschul-API. Aus dieser Struktur wurden Structs erstellt, um die Studiengänge, Vorlesungen, Änderungen, etc. abbilden zu können.

## Tests 

* alle Tests mit `swift test` ausführen
* Test können gefiltert werden
    * Beispiel: Nur Tests der DatenUtilTests Klasse ausführen: `swift test --filter DateUtil`


