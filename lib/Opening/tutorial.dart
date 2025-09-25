import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/cupertino.dart';



class TutorialPage extends StatefulWidget {
  const TutorialPage({super.key});

  @override
  State<TutorialPage> createState() => _TutorialPageState();
}

class _TutorialPageState extends State<TutorialPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          child: Column(
            children: [
              Container(child: Row(
                children: [
                  Image.asset('assets/images/logo.png', width: 100, height: 100,),
                  TextButton(onPressed: () {}, child: Text("TEst", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),))
                ],
                
              ),)
            ],
          ),
        ),
      ),
    );
  }
}