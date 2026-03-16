import 'package:flutter/material.dart';
import 'package:flutter_application_1_10feb/app_scaffold.dart';
import 'package:flutter_application_1_10feb/grid_view.dart';
import 'package:flutter_application_1_10feb/list_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(mychildren: 
    Column(
      children: [Text("Home Page"),
      TextButton(onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (builder){
          return ListViewDemo();
        }));
      }, child: Text("View List")),

      TextButton(onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (BuildContext builder){ return AppScaffold(mychildren: Text("This is about us page"));
        }));
      }, child: Text("About Us")),
      TextButton(onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (BuildContext builder){ return GridViewDemo();
        }));
      }, child: Text("Grid View"))
      ],
    )
    );
  }
}