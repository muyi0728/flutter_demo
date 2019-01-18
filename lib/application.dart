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

  PageController _pageController;
  int _pageIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  void onTap(int index) {
    _pageController.animateToPage(index, duration: const Duration(milliseconds: 300), curve: Curves.ease);
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
          controller: _pageController,
          physics: NeverScrollableScrollPhysics(),
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
          onTap: (int index) {
            _pageController.jumpToPage(index);
            setState(() {
              _pageIndex = index;
            });
          },
          currentIndex: _pageIndex,
          type: BottomNavigationBarType.fixed,
        ),
      ),
    );
  }
}