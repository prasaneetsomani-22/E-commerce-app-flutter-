import 'package:flutter/material.dart';

class ImageSwipe extends StatefulWidget {
  final List imagelist;
  ImageSwipe({this.imagelist});
  @override
  _ImageSwipeState createState() => _ImageSwipeState();
}

class _ImageSwipeState extends State<ImageSwipe> {

  int _selectedpage = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 450,
        child: Stack(
          children: [
            PageView(
              onPageChanged: (num){
                setState(() {
                  _selectedpage = num;
                });
              },
              children: [
                for(var i=0; i<widget.imagelist.length;i++)
                  Container(
                    child: Image.network('${widget.imagelist[i]}',fit: BoxFit.cover,),
                  )
              ],
            ),
            Positioned(
              bottom: 10,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for(var i=0; i<widget.imagelist.length;i++)
                    AnimatedContainer(
                      duration: Duration(microseconds: 300),
                      curve: Curves.easeInCubic,
                      margin: EdgeInsets.symmetric(horizontal: 5.0),
                      width: _selectedpage == i?18.0: 12.0,
                      height: _selectedpage == i?18.0:12.0,

                      decoration: BoxDecoration(
                          color: _selectedpage == i?Theme.of(context).accentColor:Colors.black.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(_selectedpage == i ? 9.0:6.0)
                      ),
                    )
                ],
              ),
            )
          ],
        ));
  }
}
