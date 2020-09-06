import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:band_names/models/band.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

List<Band> bands = [
  Band(id:'1', name:'Metalica', votes:5), 
  Band(id:'2', name:'Queen', votes:1), 
  Band(id:'3', name:'Guns and Roses', votes:2),
  Band(id:'4', name:'Bon Jovi', votes:4),
];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title:Text('BandNames', style: TextStyle(color:Colors.black87),),
        backgroundColor:Colors.white
      ),
      body: ListView.builder(
        itemBuilder: ( context, index) => buildListTile(bands[index]),
        itemCount: bands.length,
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 1,
        child: Icon(Icons.add),
        onPressed: (){
          addNewBand();
        }
      ),
    );
  }

  Widget buildListTile(Band band) {
    return Dismissible(
      key: Key(band.id),
      onDismissed: (direction){
        print(direction);
        print(band.id);
      },
      background: Container(
        padding: EdgeInsets.only(left:8.0),
        color:Colors.red,
        child:Align(
          alignment: Alignment.centerLeft,
          child:Text('Delete Band', style: TextStyle(color:Colors.white),)
        ),
      ),
      direction: DismissDirection.startToEnd,
          child: ListTile(
        leading: CircleAvatar(
          child:Text(band.name.substring(0,2)),
          backgroundColor: Colors.blue[100],
        ),
        title: Text(band.name),
        trailing: Text('${band.votes}', style: TextStyle(fontSize:20),),
        onTap: (){
          print(band.name);
        },
      ),
    );
  }

  addNewBand(){
    final textController = new TextEditingController();

    if(Platform.isAndroid){
      return     showDialog(
      context: context,
      builder: (context){
        return AlertDialog(
          title: Text('New band name: '),
          content: TextField(
            controller: textController,
          ),
          actions: [
            MaterialButton(
              textColor: Colors.blue,
              elevation: 5,
              child: Text('Add'),
              onPressed: (){
                addBandToList(textController.text);
                print(textController.text);
              }
            )
          ],
        );
      }
    );
    }else{
      showCupertinoDialog(
        context: context, 
        builder: (context){
          return CupertinoAlertDialog(
            title: Text('New band name: '),
            content: CupertinoTextField(
            controller: textController,
          ),
          actions: [
            CupertinoDialogAction(
              isDefaultAction: true,
              child: Text('Add'),
              onPressed: (){
                addBandToList(textController.text);
                print(textController.text);
              }
            ),
            CupertinoDialogAction(
              isDestructiveAction: true,
              child: Text('Dismiss'),
              onPressed: () => Navigator.pop(context)
            )
          ],
          );
        }
      );
    }


  }

  void addBandToList(String name){

    if(name.length > 1){

      this.bands.add(new Band(id:DateTime.now().toString(), name:name, votes: 0));
          setState(() {
      
    }); 

    }



    Navigator.pop(context);

  }

}