import 'package:flutter/material.dart';
import 'package:trashbin/Opening/tutorial.dart';
import 'package:trashbin/Opening/tutorial2.dart';
import 'package:trashbin/Opening/tutorial3.dart';

class TutorialScreen extends StatefulWidget {
  const TutorialScreen({super.key});

  @override
  State<TutorialScreen> createState() => _TutorialScreenState();
}

class _TutorialScreenState extends State<TutorialScreen> {
  final PageController _controller = PageController();
  final int totalPages = 3;
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _controller,
        onPageChanged: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        children: [
          TutorialPage(
            controller: _controller,
            pageIndex: 0,
            totalPages: totalPages,
          ),
          Tutorial2Page(
            controller: _controller,
            pageIndex: 1,
            totalPages: totalPages,
          ),
          Tutorial3Page(
            controller: _controller,
            pageIndex: 2,
            totalPages: totalPages,
          ),
        ],
      ),
    );
  }
}
