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
          child: Stack(
            children: [
              Image.asset( 
                'assets/images/bg-splash.png',
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 30, left: 30, right: 30),
                    child:
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset(
                              'assets/images/Logo.png',
                              width: 40,
                              height: 40,
                            ),
                          TextButton(onPressed: () {}, child: Text(
                            'SKIP',
                            style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold
                          ),
                          ))
                        ],
                      ),
                  ),
                  Image.asset(
                    'assets/images/tutorial1.png',
                    width: 300,
                    height: 300,
                  ),
                  Container(
                    child:
                      Column(
                        children: [
                          Text(
                            'Lorem Ipsum',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.black
                            ),
                          ),
                        ],
                    ),
                  )
                ],
              )
            ],
          ),
        )
      ),
    );
  }
}