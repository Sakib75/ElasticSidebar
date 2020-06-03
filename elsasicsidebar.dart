import 'package:flutter/material.dart';
void main() => runApp(HomePage());




class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Offset _offset = Offset(0,0);
  double _radius = 75;
  bool isMenuOpen = false;


  @override
  Widget build(BuildContext context) {
    double sideBarsize = MediaQuery.of(context).size.width * 0.65;
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.dark,
        accentColor: Colors.deepOrangeAccent,
      ),
      home: SafeArea(
        child: Scaffold(
          body: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  Color.fromRGBO(255, 65, 108, 1.0),
                  Color.fromRGBO(255, 75, 73, 1.0)
                ])
            ),
            width: MediaQuery.of(context).size.width,
            child: Stack(
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      isMenuOpen = false;
                    });
                  },
                  child: Container(
                    child: Center(
                      child: MaterialButton(
                          color: Colors.white,
                          child: Text(
                            "Helo World",
                            style: TextStyle(color: Colors.black),
                          ),
                          onPressed: () {}),
                    ),
                  ),
                ),
                AnimatedPositioned(
                  duration: Duration(milliseconds: 2000),
                  top: 0,
                  left: isMenuOpen? 0: - sideBarsize + 20,
                  curve: Curves.elasticOut,
                  child: SizedBox(
                    width: sideBarsize,
                    child: GestureDetector(
                      onPanUpdate: (details) {
                        setState(() {
                          if(details.localPosition.dx <= sideBarsize) {
                            _offset = details.localPosition;
                          }
                        }

                        );
                        if(details.localPosition.dx>sideBarsize-20 && details.delta.distanceSquared>2){
                          setState(() {
                            isMenuOpen = true;
                          });
                        }
                        if(details.localPosition.dx>sideBarsize && details.delta.distanceSquared>-2){
                          setState(() {
                            isMenuOpen = true;
                          });
                        }
                      },
                      onPanEnd: (details) {
                        setState(() {
                          _offset = Offset(0,0);
                        });
                      },
                      child: Stack(
                        children: [
                          CustomPaint(
                            size: Size(sideBarsize, MediaQuery.of(context).size.height),
                            painter: MyCustomPainer(radius: _radius,offset: _offset),
                          ),
                          Container(
                            padding: EdgeInsets.only(bottom: 30),
                            height: MediaQuery.of(context).size.height,
                            width: sideBarsize,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Spacer(),
                                Container(
                                  height: MediaQuery.of(context).size.height * 0.25,
                                  child: Center(
                                    child: Container(
                                      width: 150,
                                      child: Image.asset('images/dp.png'),
                                    ),
                                  ),
                                ),
                                Divider(thickness: 1,),
                                Container(
                                  child: Column(
                                    children: [
                                      MyButton(
                                        text: "Profile",
                                        iconData: Icons.person,
                                      ),
                                      MyButton(
                                        text: "Payments",
                                        iconData: Icons.payment,),
                                      MyButton(
                                        text: "Notifications",
                                        iconData: Icons.notifications, ),
                                      MyButton(
                                        text: "Settings",
                                        iconData: Icons.settings, ),
                                      MyButton(
                                        text: "My Files",
                                        iconData: Icons.filter, )

                                    ],
                                  ),
                                ),
                                Spacer(),
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: IconButton(
                                    enableFeedback: true,
                                    icon: Icon(Icons.keyboard_backspace,color: Colors.black45,size: 30,),
                                    onPressed: (){
                                      this.setState(() {
                                        isMenuOpen = false;
                                      });
                                    },),
                                )
                              ],
                            ),
                          )

                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MyCustomPainer extends CustomPainter {
  MyCustomPainer({@required this.radius,@required this.offset});
  double getControlPointX(double width ) {
    if(offset.dx == 0) {
      return width;
    } else {
      return offset.dx>width?offset.dx:width + 75;
    }
  }
  final double radius;
  final Offset offset;
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = Colors.white..style = PaintingStyle.fill;
    Path path = Path();
    path.moveTo(-size.width, 0);
    path.lineTo(size.width, 0);
    path.quadraticBezierTo(getControlPointX(size.width), offset.dy, size.width, size.height);
    path.lineTo(-size.width, size.height);
    path.close();


    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}


class MyButton extends StatelessWidget {
  final String text;
  final IconData iconData;
  final double textSize = 18;
  final double height = 50 ;

  MyButton({this.text, this.iconData,});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialButton(
      height: height,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Icon(
            iconData,
            color: Colors.black45,
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            text,
            style: TextStyle(color: Colors.black45, fontSize: textSize),
          ),
        ],
      ),
      onPressed: () {},
    );
  }
}
