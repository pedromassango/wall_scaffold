import 'package:flutter/material.dart';
import 'package:wall_scaffold/wall_scaffold.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  int _currentIndex = 0;
  PageController _pageController = PageController();

  final List<String> _tabTitles = [
    'Home',
    'News',
    'Notifications',
    'Settings'
  ];

  void _onItemSelected(int page) {
    // Update current item index
    setState(() => _currentIndex = page);

    // show the page of the newly selected item
    _pageController.jumpToPage(page);
  }

  @override
  Widget build(BuildContext context) {
    return WallScaffold(
      wallContent: WallContent.withOptions(
        backgroundColor: Colors.blue,
        itemColor: Colors.black,
        selectedItemColor: Colors.white,
        currentIndex: _currentIndex,
        onItemSelected: (index) => _onItemSelected(index),
        items: _tabTitles.map((title) {
          return WallItem(title: Text(title));
        }).toList(),
      ),
      mainContent: Scaffold(
        appBar: AppBar(
          title: Text(
            _tabTitles.elementAt(_currentIndex),
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.white,
        ),
        body: PageView(
          controller: _pageController,
          physics: NeverScrollableScrollPhysics(),
          children: _tabTitles.map((tabTitle) {
            return Container(
              color: Colors.primaries.elementAt(_currentIndex),
              child: Center(child: Text(tabTitle),),
            );
          }).toList(),
        ),
      ),
    );
  }
}