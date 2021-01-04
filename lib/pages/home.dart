import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:encuesta_app/models/band.dart';
import 'dart:io';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Band> bands = [
    Band(id: "1", name: "Metallica", votes: 5),
    Band(id: "2", name: "Queen", votes: 1),
    Band(id: "3", name: "Bon jovi", votes: 3),
    Band(id: "4", name: "cuarteto de nos", votes: 4),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("BandNames", style: TextStyle(color: Colors.black87)),
        backgroundColor: Colors.white,
      ),
      body: ListView.builder(
        itemCount: bands.length,
        itemBuilder: (_, i) => _bandTile(bands[i]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addNewBand,
        child: Icon(Icons.add),
      ),
    );
  }

  Dismissible _bandTile(Band band) {
    return Dismissible(
      direction: DismissDirection.startToEnd,
      key: Key(band.id),
      onDismissed: (direction) {
        print(direction);
        //TODO: Llamar el borrado
      },
      background: Container(
        padding: EdgeInsets.only(left: 10),
        alignment: Alignment.centerLeft,
        color: Colors.red,
        child: Text(
          "Delete Band",
          style: TextStyle(color: Colors.white),
        ),
      ),
      child: ListTile(
        leading: CircleAvatar(
          child: Text(band.name.substring(0, 2)),
          backgroundColor: Colors.blue[100],
        ),
        title: Text(band.name),
        trailing: Text(
          "${band.votes}",
          style: TextStyle(fontSize: 20),
        ),
        onTap: () {
          print(band.name);
        },
      ),
    );
  }

  addNewBand() {
    final textController = TextEditingController();
    if (Platform.isAndroid) {
      return showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("New Band Name: "),
          content: TextField(
            autofocus: true,
            controller: textController,
          ),
          actions: [
            MaterialButton(
              child: Text("Add"),
              elevation: 5,
              textColor: Colors.blue,
              onPressed: () => addBandToList(textController.text),
            ),
          ],
        ),
      );
    }
    showCupertinoDialog(
      context: context,
      builder: (_) => CupertinoAlertDialog(
        title: Text("New Band Name: "),
        content: CupertinoTextField(
          controller: textController,
        ),
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            child: Text("Add"),
            onPressed: () => addBandToList(textController.text),
          ),
          CupertinoDialogAction(
            isDestructiveAction: true,
            child: Text("Dismiss"),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  void addBandToList(String name) {
    if (name.length > 1) {
      this.bands.add(Band(id: DateTime.now().toString(), name: name, votes: 0));
      setState(() {});
    }
    Navigator.pop(context);
  }
}
