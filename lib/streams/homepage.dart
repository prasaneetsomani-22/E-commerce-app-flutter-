import 'package:e_commerce/tabs/hometab.dart';
import 'package:e_commerce/tabs/savedtab.dart';
import 'package:e_commerce/tabs/searchtab.dart';
import 'package:e_commerce/widgets/bottom_tabs.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int _tabno = 0;
  PageController _controller;

  @override
  void initState() {
    // TODO: implement initState
    _controller = PageController();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

            Expanded(
              child: PageView(
                controller: _controller,
                onPageChanged: (num){
                  setState(() {
                    _tabno = num;
                  });
                },
                children: [
                  HomeTab(),
                  SearchTab(),
                  SavedTab()
                ],
              ),
            ),
            BottomTabs(selectedtab: _tabno,ontabclick: (num){
              _controller.animateToPage(num, duration: Duration(microseconds: 3000), curve: Curves.easeInOut);
            },)
          ]
        ),
      )
    );
  }
}
