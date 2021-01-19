# Problem 

## Einleitung

Nachdem wir uns Daten verschiedenster Vorlesungen angesehen haben, sind uns einige Probleme mit der Struktur bzw. den Inhalt der Daten aufgefallen.

Hier wird die Wichtigkeit der LectureAI bzw. das Problem der von der Hochschul-API gelieferten Daten beschrieben.

## Beispieldaten einer Vorlesung
Die Daten der API werden in folgender Struktur angeboten:
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
Diese Daten zurückgelieferten Daten sind für uns wichtig, um eine Vorlesung in den Kalender des Nutzers hinzufügen zu können.
```json
{
    "starttime": "09:45",
    "endtime": "11:15",
    "startdate": "04.03.2020",
    "enddate": "20.01.2021",
    "comment": "Storytelling \/ KW 41- KW 3, außer KW 47 virtuell"
}
```
Leider sind viele dieser Date nicht brauchbar. In diesem Fall ist das startdate falsch, da die Vorlesung für das Wintersemester angeboten wird. Außerdem ist das comment-Attribut für eine begrenzt logische AI nicht analysierbar.

Sonderfälle, wie oben gezeigt, treten häufig auf, sodass wir die Analyse der Kommentare zu einer Vorlesung begrenzen mussten.