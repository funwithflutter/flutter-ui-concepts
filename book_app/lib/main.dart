import 'package:flutter/material.dart';

void main() => runApp(BookApp());

class BookApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Readable',
      theme: ThemeData(
        textTheme: TextTheme(
            title: TextStyle(
              fontSize: 24.0,
              color: Colors.white,
              fontWeight: FontWeight.w300,
              letterSpacing: 1,
            ),
            subtitle: TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.w300,
                letterSpacing: 1)),
        iconTheme: IconThemeData(color: Colors.white, size: 28),
        fontFamily: 'OpenSansCondensed',
      ),
      home: Home(),
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: backgroundGradient(),
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.bottomCenter,
              child: CustomBottomNav(),
            ),
            Column(
              children: <Widget>[
                CustomBanner(),
                BookListView(
                  title: "YOUR TITLES",
                  books: [
                    'american.jpg',
                    'harry.jpg',
                    'harry1.png',
                    'harry2.jpeg',
                    'kiterunner.jpg',
                    'notw.jpg',
                    'trevor.jpeg',
                    'ready.jpg'
                  ],
                ),
                BookListView(
                  title: "CLASSICS",
                  books: [
                    'catch22.jpg',
                    'grapes.jpeg',
                    'greatgatsby.jpeg',
                    'huckle.jpeg',
                    'lotr.jpg',
                    'mockingbird.jpg',
                    'oldmanandthesea.jpg'
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  BoxDecoration backgroundGradient() {
    return BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        tileMode: TileMode.mirror,
        stops: [0.0, 0.4, 0.6, 1],
        colors: [
          Colors.blueGrey[800],
          Colors.blueGrey[700],
          Colors.blueGrey[700],
          Colors.blueGrey[800],
        ],
      ),
    );
  }
}

class BookListView extends StatelessWidget {
  final String title;
  final List<String> books;

  const BookListView({Key key, @required this.title, @required this.books})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: LinePainter(),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 36.0),
            child: Text(title, style: Theme.of(context).textTheme.subtitle),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 16),
            height: 200,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: books.length,
              itemBuilder: (BuildContext context, int index) {
                return BookCard(
                  file: books[index],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class BookCard extends StatelessWidget {
  final String file;

  static const filePath = 'assets/images/';

  const BookCard({Key key, @required this.file}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.red,
        boxShadow: [
          BoxShadow(
            color: Colors.black,
            spreadRadius: 1,
            offset: Offset(4, 5),
            blurRadius: 5,
          )
        ],
      ),
      child: Image.asset(filePath + file),
    );
  }
}

class CustomBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: LinePainter(),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16),
        height: 90.0,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 40,
            ),
            Row(
              children: <Widget>[
                Text(
                  'READABLE',
                  style: Theme.of(context).textTheme.title,
                ),
                Expanded(
                  child: Container(),
                ),
                Icon(Icons.search),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CustomBottomNav extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Icon(Icons.refresh),
          Icon(Icons.person_outline),
          Icon(Icons.info_outline),
        ],
      ),
    );
  }
}

class LinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 0.2
      ..style = PaintingStyle.stroke;

    Path path = Path();
    path.moveTo(0, size.height + 10);
    path.lineTo(size.width, size.height + 10);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
