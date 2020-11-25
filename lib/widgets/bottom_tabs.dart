import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
class BottomTabs extends StatefulWidget {
  final int selectedtab;
  final Function(int) ontabclick;
  BottomTabs({this.selectedtab,this.ontabclick});

  @override
  _BottomTabsState createState() => _BottomTabsState();
}

class _BottomTabsState extends State<BottomTabs> {

  int _activetab;


  Future<void> alertdailogbox(){
    return showDialog(context: context,
    barrierDismissible: false,
    builder: (context){
      return AlertDialog(
        title: Text('Logout'),
        content: Text('Do you really want to logout?',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
        actions: [
          GestureDetector(
            onTap: (){
              FirebaseAuth.instance.signOut().then((value){
                Navigator.pop(context);
              });
            },
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Theme.of(context).accentColor,
                borderRadius: BorderRadius.circular(12.0)
              ),
              child: Text('Confirm',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 16),),
            ),
          ),
          SizedBox(width: 10,),
          GestureDetector(
            onTap: (){
              Navigator.pop(context);
            },
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Color(0xffDCDCDC),
                  borderRadius: BorderRadius.circular(12.0)
              ),
              child: Text('Cancel',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
            ),
          ),
          SizedBox(
            width: 30,
          )
        ],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    _activetab = widget.selectedtab??0;
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(12.0),topRight: Radius.circular(12.0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 1.0,
            blurRadius: 32.0
          )
        ]


      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          BottomTabsButton(icon: Icons.home,selected: _activetab == 0,onPressed: (){
            widget.ontabclick(0);
          },),
          BottomTabsButton(icon: Icons.search,selected: _activetab == 1,onPressed: () {
            widget.ontabclick(1);
          }),
          BottomTabsButton(icon: Icons.favorite,selected: _activetab == 2,onPressed: (){
              widget.ontabclick(2);
          },),
          BottomTabsButton(icon: Icons.arrow_forward,selected: _activetab == 3,onPressed: (){
             alertdailogbox();
    },)

        ]
      )
    );
  }
}

class BottomTabsButton extends StatelessWidget {

  final IconData icon;
  final bool selected;
  final Function onPressed;
  BottomTabsButton({this.icon,this.selected,this.onPressed});

  @override
  Widget build(BuildContext context) {
    bool _selected = selected??false;
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(width: 3.0,style: BorderStyle.solid,color: _selected?Theme.of(context).accentColor:Colors.transparent)
          )
        ),
        padding: EdgeInsets.all(10.0),
        child: Icon(icon,size: 40.0,color: _selected?Theme.of(context).accentColor:Colors.black,
        ),
      ),
    );
  }
}

