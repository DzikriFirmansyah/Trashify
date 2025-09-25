import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


class TutorialPage extends StatefulWidget {
  const TutorialPage({super.key});

  @override
  _TutorialPageState createState() => _TutorialPageState();
}

class _TutorialPageState extends State<TutorialPage> {
  int _currentPageIndex = 0;

  void _navigateToPage(int index) {
    setState(() {
      _currentPageIndex = index;
    });
  }

  final List<String> _tutorialPages = [
    'Selamat Datang di UdaraKu',
    'Pernahkah Anda Mempertimbangkan Kualitas Udara Ruangan Anda?',
    'Pantau dan Tingkatkan Kualitas Udara Ruangan dalam Satu Genggaman dengan UdaraKu',
  ];

  final List<String> _tutorialPages2 = [
    'Membantu Anda memantau udara bersih untuk hidup sehat',
    'Udara yang bersih memiliki manfaat bagi kesehatan, mental dan lingkungan, termasuk meningkatkan kualitas tidur, konsentrasi dan perlindungan terhadap penyakit pernapasan.',
    'Perhatikan udara yang Anda hirup setiap hari. UdaraKu selalu siap membantu.',
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Stack(
          children: [
            if (_currentPageIndex != 2)
              Container(
                decoration: const BoxDecoration(
                  color: Colors.white
                ),
              ),
            if (_currentPageIndex == 2)
              Container(
                decoration: const BoxDecoration(
                  color: Colors.white
                ),
              ),
            Container(
              padding: const EdgeInsets.all(30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    'assets/images/Logo.png',
                    width: 40,
                    height: 40,
                  ),
                  Visibility(
                    visible: _currentPageIndex != 2,
                    child: TextButton(
                      onPressed: () {
                      },
                      child: const Text(
                        'Skip',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(15, 80, 15, 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsetsDirectional.fromSTEB(20, 20, 20, 0),
                            child: SizedBox(
                              height: 40,
                              child: Text(
                                _tutorialPages[_currentPageIndex],
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          SizedBox(
                              height: 400,
                              child: _currentPageIndex == 0
                                  ? Image.asset(
                                      'assets/images/content1.png',
                                      width: 200,
                                      height: 200,
                                    )
                                  : _currentPageIndex == 1
                                      ? Image.asset(
                                          'assets/images/content2.png',
                                          width: 300,
                                          height: 300,
                                        )
                                      : Container()),
                          Padding(
                            padding:
                                const EdgeInsetsDirectional.fromSTEB(20, 20, 20, 0),
                            child: SizedBox(
                              height: 40,
                              child: Text(
                                _tutorialPages2[_currentPageIndex],
                                textAlign: TextAlign.center,
                                style: const TextStyle(fontSize: 14.0),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Column(
                  children: [
                    if (_currentPageIndex == 2)
                      ElevatedButton(
                        onPressed: () {
                        },
                        style: ButtonStyle(
                          shape:
                              WidgetStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                        child: const Text(
                          'Start',
                          style: TextStyle(
                              color: Color.fromRGBO(44, 123, 195, 100)),
                        ),
                      ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 10, 40),
                          child: IconButton(
                            icon: const Icon(Icons.arrow_back),
                            onPressed: _currentPageIndex > 0
                                ? () {
                                    _navigateToPage(_currentPageIndex - 1);
                                  }
                                : null,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 40),
                          child: InkWell(
                            onTap: () {
                              _navigateToPage(0);
                            },
                            child: Icon(
                              Icons.horizontal_rule_sharp,
                              color: _currentPageIndex == 0
                                  ? const Color.fromARGB(255, 39, 39, 39)
                                  : const Color.fromARGB(255, 201, 201, 201),
                              size: 40,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 40),
                          child: InkWell(
                            onTap: () {
                              _navigateToPage(0);
                            },
                            child: Icon(
                              Icons.horizontal_rule_sharp,
                              color: _currentPageIndex == 1
                                  ? const Color.fromARGB(255, 39, 39, 39)
                                  : const Color.fromARGB(255, 201, 201, 201),
                              size: 40,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 40),
                          child: InkWell(
                            onTap: () {
                              _navigateToPage(0);
                            },
                            child: Icon(
                              Icons.horizontal_rule_sharp,
                              color: _currentPageIndex == 2
                                  ? const Color.fromARGB(255, 39, 39, 39)
                                  : const Color.fromARGB(255, 201, 201, 201),
                              size: 40,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 0, 50),
                          child: IconButton(
                            icon: const Icon(Icons.arrow_forward),
                            onPressed: _currentPageIndex < 2
                                ? () {
                                    _navigateToPage(_currentPageIndex + 1);
                                  }
                                : null,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
