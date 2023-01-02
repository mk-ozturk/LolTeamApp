import 'dart:collection';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lol_team_app_deneme/main.dart';

class UsersAdd extends StatelessWidget {
  const UsersAdd({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var refLol=FirebaseDatabase.instance.ref().child("users_data");
    Future<void> kayit(String nameAdd, String surnameAdd, String imgAdd,String nickAdd)async{
      var bilgi=HashMap<String, dynamic>();
      bilgi["id"]="";
      bilgi["img"]=imgAdd;
      bilgi["name"]=nameAdd;
      bilgi["nick"]=nickAdd;
      bilgi["surname"]=surnameAdd;
      bilgi["count"]=0;
      refLol.push().set(bilgi);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MyHomePage()));



    }



    var screensize= MediaQuery.of(context).size;
    final scrheight=screensize.height;
    final scrwidth=screensize.width;
    var nameField=TextEditingController();
    var surnameField=TextEditingController();
    var nickField=TextEditingController();
    var picField=TextEditingController();
    return Scaffold(
        appBar: AppBar(
          title: Text("Lol Gardaşı Ekle"),
        ),
        body: Center(child:
        Container(
          decoration: BoxDecoration(image: DecorationImage(image: AssetImage("lib/photos/sb-teemo.jpg"),fit: BoxFit.cover,opacity: 200),),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacer(flex: 2,),
            Row(mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: SizedBox(width: scrwidth/5*2,
                    child: TextField(
                      controller:nameField ,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Ad",
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: SizedBox(width: scrwidth/5*2,
                    child: TextField(
                      controller: surnameField,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Soyad"

                      ),
                    ),
                  ),
                ),
              ],
            ),
            Spacer(flex: 1,),
            Padding(
              padding: const EdgeInsets.only(left: 30.0,right: 30),
              child: TextField(
                controller: nickField,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Nick Name"

                ),
              ),
            ),
              Spacer(flex: 1,),
            Padding(
              padding: const EdgeInsets.only(left: 30.0,right: 30),
              child: TextField(
                controller: picField,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Profil Fotoğrafı Url"
              ),

              ),
            ),
              Spacer(flex: 2,),



            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              Container(width: 100,
                child: ElevatedButton(onPressed: (){
                  kayit(nameField.text, surnameField.text,picField.text , nickField.text);
                  print("${nameField.text} ${surnameField.text} ${nickField.text} ${picField.text} ");
                }, child: Text("Ekle")),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Container(width: 100,
                  child: ElevatedButton(onPressed: (){
                    Navigator.pop(context);
                  }, child: Text("İptal")),
                ),
              )

            ],),
              Spacer(flex: 1,)



          ],),
        )

          ,)
    );



  }
}

