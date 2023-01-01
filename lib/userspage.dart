import 'dart:collection';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lol_team_app_deneme/main.dart';






class UserPage extends StatefulWidget {

  String upName;
  String upSurname;
  String upNick;
  int    upCount;
  String upUrl;
  String upId;
  UserPage(this.upName, this.upSurname, this.upNick, this.upCount, this.upUrl,this.upId);

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    var refLol=FirebaseDatabase.instance.ref().child("users_data");

    Future<void>delete(String id)async{
         refLol.child(id).remove();




    }

    var screen = MediaQuery.of(context).size;
    final width= screen.width;



    return Scaffold(
      appBar: AppBar(
        title:Text( "Kullanıcı Özellikleri"),
        actions: [
          IconButton(onPressed: (){
            showDialog(context: context,
                builder:(BuildContext context)=>
                    AlertDialog(
                      title: Text("Oyuncuyu Sil"),
                      content: Text("Oyuncuyu Silmek İstediğinize emin misiniz?"),
                      actions: [
                        ElevatedButton(onPressed: (){
                          delete(widget.upId);
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>MyHomePage()));},
                            child: Text("Evet")),
                        ElevatedButton(onPressed: (){
                            Navigator.pop(context);},
                            child: Text("Hayır"))

                        ],



                    ) );

          }, icon: Icon(Icons.delete))
        ],
      ),
      body: Center(child:
      Column(mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Spacer(flex: 3,),
        Container(
            width: 200,height: 200,
            child: Image.network(Uri.parse(widget.upUrl).toString())),
        Spacer(flex: 1,),
        Text("${widget.upName} ${widget.upSurname}", style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
        Text(widget.upNick,style: TextStyle(fontWeight: FontWeight.bold ),),
        Spacer(flex: 1,),
        Text("${widget.upCount.toString()}",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
          Spacer(flex: 3,)




      ],)

        ,)


    );
  }
}
