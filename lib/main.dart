import 'dart:collection';
import 'dart:core';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:lol_team_app_deneme/Data.dart';
import 'package:lol_team_app_deneme/UserssAdd.dart';
import 'package:lol_team_app_deneme/userspage.dart';
import 'firebase_options.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
 await Firebase.initializeApp(
   options: DefaultFirebaseOptions.currentPlatform,
 );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:  MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {



  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var refLol=FirebaseDatabase.instance.ref().child("users_data");

  Future<void>add(int sonuc,String id)async{
    var result=HashMap<String,dynamic>();
    result["count"]=sonuc;
    refLol.child(id).update(result);




  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        title: Text("Team Mate App"),

      ),
      body: Container(
        decoration: BoxDecoration(image: DecorationImage(image: AssetImage("lib/photos/sb-teemo.jpg"),fit: BoxFit.cover,opacity: 200),),
        child: StreamBuilder<DatabaseEvent>(
            stream: refLol.onValue,
            builder: (context,event){
              if(event.hasData){
                var dataList=<Data>[];
                var value=event.data!.snapshot.value as dynamic;
                if(value!=null){
                  value.forEach((key,n){
                    var valueData=Data.fromJson(key,n);
                    dataList.add(valueData);

                  });
                }
                return ListView.builder(
                    itemCount: dataList.length,
                    itemBuilder: (context,i){
                      var users=dataList[i];
                      return SizedBox(height: 120,
                        child: Card(child:
                        Row(children: [
                          Container(width: 60,height: 60,
                              child: Image.network(users.img)),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("${users.name} ${users.surname}"),

                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(users.nick),
                                )

                              ],
                            ),
                          ),
                          Spacer(),


                          Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(height: 30,width: 60,
                                    child: ElevatedButton(onPressed: (){
                                      int result=users.count+1;
                                      add(result, users.id);
                                      print(users.count.toString());

                                    }, child: Icon (Icons.add, size: 20,))),
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Text(users.count.toString(), style: TextStyle(
                                                                              fontWeight: FontWeight.bold ,
                                                                              fontSize:20,
                                                                               color: users.count > 2 ? Colors.redAccent : Colors.green ),),
                                ),
                                SizedBox(
                                    height: 30,width: 60,
                                    child: ElevatedButton(onPressed: (){


                                      if
                                      (users.count>0){ int result=users.count-1;
                                      add(result, users.id);}

                                      print(users.count.toString());

                                    }, child:  Icon (Icons.remove, size: 20,),)),

                              ],
                            ),
                          ),
                          GestureDetector(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>UserPage(users.name, users.surname, users.nick, users.count, users.img,users.id)));

                              },
                              child: Icon(Icons.arrow_forward_ios_rounded))



                        ],)

                          ,),
                      );






                    });
              }else{
                return Center(child: LoadingAnimationWidget.inkDrop(color: Colors.blue, size: 100));}



            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>UsersAdd()));
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
