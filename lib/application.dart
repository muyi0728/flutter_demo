import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import './routers/application.dart';
import './routers/routes.dart';
import './pages/home_page/index.dart';
import './pages/account_page/index.dart';
import './pages/categories_page/index.dart';
import './pages/socia_page/index.dart';
import './pages/Cart_page/index.dart';


class Application extends StatefulWidget {
  _ApplicationState createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {
  _ApplicationState() {
    final router = new Router();
    Routes.configureRoutes(router);
    ApplicationRouter.router = router;
  }

  PageController pageController;
  int _pageIndex = 0;

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: this._pageIndex);
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  void onTap(int index) {
    pageController.animateToPage(index, duration: const Duration(milliseconds: 300), curve: Curves.ease);
  }

  void onPageChanged(int index) {
    setState(() {
      this._pageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: PageView(
          children: <Widget>[
            HomePage(),
            CategoriesPage(),
            SocialPage(),
            CartPage(),
            AccountPage(),
          ],
          controller: pageController,
          onPageChanged: onPageChanged,
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('Home')),
            BottomNavigationBarItem(icon: Icon(Icons.dashboard), title: Text('Categories')),
            BottomNavigationBarItem(icon: Icon(Icons.explore), title: Text('Social')),
            BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), title: Text('Cart')),
            BottomNavigationBarItem(icon: Icon(Icons.account_box), title: Text('Account')),
          ],
          fixedColor: Colors.orange,
          onTap: onTap,
          currentIndex: _pageIndex,
          type: BottomNavigationBarType.fixed,
        ),
      ),
    );
  }
}