import 'package:flutter/material.dart';
import 'package:sqllite_app/src/models/trail.dart';
import 'package:sqllite_app/src/services/db_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final dbService = DatabaseService();

  @override
  void dispose() {
    dbService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(  
      appBar: AppBar(),
      body: FutureBuilder<List<Trail>>(
        future: dbService.getTrails(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Center(child: CircularProgressIndicator(),);
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context, index){
              return ListTile(
                title: Text(snapshot.data[index].name),
                leading: Text(snapshot.data[index].difficulty),
                trailing: Text(snapshot.data[index].distance.toString()),
              );
            });
        }
      )
    );
  }
}