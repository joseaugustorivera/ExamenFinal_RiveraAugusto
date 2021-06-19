import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main()=>runApp(MiApp());
class MiApp extends StatelessWidget {
  const MiApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Augusto APP",
      home: Inicio(),
    );
  }
}

class Inicio extends StatefulWidget {
  Inicio({Key key}) : super(key: key);

  @override
  _InicioState createState() => _InicioState();
}

class _InicioState extends State<Inicio> {
  
  Future <List<Student>> getData() async {   //a
    var response=await http.get(
      Uri.parse("https://jsonplaceholder.typicode.com/comments"),
      headers: {"Accept":"Application/json"}  
    );

    var data=json.decode(response.body);  //a
    print(data);
    List<Student> students=[]; //a
    for(var s in data){ //a
      Student student=Student(s["postId"], s["name"], s["email"]); //a
      students.add(student); //a
    }
    print(students.length);
    return students; //a
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
         title:Text("Augusto APP Examen Final")
       ),
       
       body: Container(
         child: FutureBuilder(
           future: getData(),
           builder: (BuildContext context, AsyncSnapshot snapshot){
             print(snapshot.data);
             if(snapshot.data == null){
               return Container(child: Center(child: Text("Cargando..."),),);
             }
             else{
               return ListView.builder(
                 itemCount: snapshot.data.length,
                 itemBuilder: (BuildContext context, int postId){
                   return ListTile(title:Text(snapshot.data[postId].name),
                   subtitle: Text(snapshot.data[postId].email.toString()),

                   );
                 },
               );
             }
           },
         ),
     )
    );
  }
}

class Student {
  final int postid;
  final String name;
  final String email;

  Student (this.postid, this.name, this.email);
}