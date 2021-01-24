import 'package:Feelie/Camera/camera.dart';
import 'package:Feelie/Messages/messages.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/page_view.dart';

import 'MainPage/mainPage.dart';

class pageView extends StatefulWidget {
  num screenHeight;
  num screenWidth;

  pageView({
    @required this.screenHeight,
    @required this.screenWidth,
  });
  @override
  _pageViewState createState() => _pageViewState();
}

var currentPage = 1;
var varBottomIndex = 1;

class _pageViewState extends State<pageView> {
  @override
  Widget build(BuildContext context) {
    var pageViewController = PageController(initialPage: currentPage);
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        onTap: (bottomIndex) {
          currentPage = bottomIndex;
          pageViewController.animateToPage(currentPage, duration: Duration(milliseconds: 500), curve: Curves.ease);
        },
        currentIndex: currentPage,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.camera), label: 'Camera'),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.message), label: 'Messages'),
        ],
      ),
      body: PageView(
        controller: pageViewController,
        onPageChanged: (pageIndex) {
          setState(() {
            currentPage = pageIndex;
          });
        },
        children: [
          camera(screenHeight: widget.screenHeight, screenWidth: widget.screenWidth),
          mainPage(screenHeight: widget.screenHeight, screenWidth: widget.screenWidth),
          messages(screenHeight: widget.screenHeight, screenWidth: widget.screenWidth),
        ],
      ),
    );
  }
}
