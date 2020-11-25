import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class CapacityButtons extends StatefulWidget {
  final List capacitylist;
  final Function(String) selectedcapacity;
  CapacityButtons({this.capacitylist,this.selectedcapacity});
  @override
  _CapacityButtonsState createState() => _CapacityButtonsState();
}

class _CapacityButtonsState extends State<CapacityButtons> {
  int _selected = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0),
      child: Row(
        children: [
          for(var i = 0;i < widget.capacitylist.length;i++)
            GestureDetector(
              onTap: (){
                widget.selectedcapacity(widget.capacitylist[i]);
                setState(() {
                  _selected = i;
                });
              },
              child: Container(
                width: 42.0,
                height: 42.0,
                margin: EdgeInsets.symmetric(horizontal: 4.0),
                decoration: BoxDecoration(
                  color: _selected == i ? Theme.of(context).accentColor :Color(0xffDCDCDC),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                alignment: Alignment.center,
                child:Text('${widget.capacitylist[i]}',style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.w600,color: _selected == i?Colors.white:Colors.black),)
              ),
            )
        ],
      ),
    );
  }
}
