import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pepsi App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: PepsiPage(),
    );
  }
}

class PepsiPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final circleD = size.width * 1.112;

    final circle = Container(
      width: circleD,
      height: circleD,
      decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white),
    );

    final can = Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Image.asset(
          'assets/can.png',
          width: size.width * 0.65,
          fit: BoxFit.cover,
        ),
        SizedBox(width: size.width * 0.65 * 0.28)
      ],
    );

    final name = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 32),
          Text(
            'Classic Diet Pepsi',
            style: TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          Text(
            'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no',
            style: TextStyle(color: Color(0xFFE9E9E9), fontSize: 15),
            // maxLines: 2,
          ),
        ],
      ),
    );

    final buyButton = SafeArea(
      top: false,
      child: RaisedButton(
        color: Colors.white,
        onPressed: () {},
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        child: Container(
          alignment: Alignment.center,
          width: size.width * 0.8,
          height: 50,
          child: Text(
            'Buy Now',
            style: TextStyle(color: Color(0xFF3851FB)),
          ),
        ),
      ),
    );

    return Scaffold(
        backgroundColor: Color(0xFF2151A1),
        body: Container(
          height: double.infinity,
          width: double.infinity,
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Positioned(child: circle, top: -circleD / 2 + 20),
              Positioned(
                top: circleD / 4 - 20,
                left: 0,
                right: 0,
                bottom: 0,
                child: Column(
                  children: <Widget>[can, name, Selector(), Spacer(), buyButton],
                ),
              ),
            ],
          ),
        ));
  }
}

class Selector extends StatefulWidget {
  @override
  _SelectorState createState() => _SelectorState();
}

class _SelectorState extends State<Selector> {
  final prices = <String>['7.00', '8.45', '9.99'];
  var curIndex = 1;
  @override
  Widget build(BuildContext context) {
    final p = prices[curIndex].split('.');
    return Container(
      height: 120,
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Row(
        children: <Widget>[
          Text('€ ', style: TextStyle(color: Colors.white, fontSize: 26)),
          AnimatedSwitcher(
            duration: Duration(milliseconds: 200),
            transitionBuilder: (widget, animation) => ScaleTransition(scale: animation, child: widget),
            child: RichText(
                key: ValueKey(curIndex),
                text: TextSpan(style: TextStyle(color: Colors.white, fontSize: 26), children: [
                  TextSpan(text: p[0], style: TextStyle(fontSize: 40)),
                  TextSpan(text: '.'),
                  TextSpan(text: p[1], style: TextStyle(fontSize: 25))
                ])),
          ),
          Spacer(),
          Item(
            curIndex: curIndex,
            index: 0,
            onTap: () => setState(() {
              curIndex = 0;
            }),
          ),
          Item(
            curIndex: curIndex,
            index: 1,
            onTap: () => setState(() {
              curIndex = 1;
            }),
          ),
          Item(
            curIndex: curIndex,
            index: 2,
            onTap: () => setState(() {
              curIndex = 2;
            }),
          )
        ],
      ),
    );
  }
}

class Item extends StatelessWidget {
  final int curIndex;
  final int index;
  final GestureTapCallback onTap;
  const Item({Key key, this.curIndex, this.index, this.onTap}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final selected = curIndex == index;
    String size;
    switch (index) {
      case 0:
        size = 'S';
        break;
      case 1:
        size = 'M';
        break;
      case 2:
        size = 'L';
        break;
    }
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        height: selected ? 80 : 63,
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.all(16),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4), color: selected ? Color(0xFFCADFFE) : Color(0xFFEFEFEF)),
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Image.asset(selected ? 'assets/cup_checked.png' : 'assets/cup_unchecked.png'),
            Text(size, style: TextStyle(color: selected ? Color(0xFF3851FB) : Color(0xFFB2B2B2)))
          ],
        ),
      ),
    );
  }
}
