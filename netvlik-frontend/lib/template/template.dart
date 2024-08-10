import 'package:flutter/material.dart';
import 'package:netvlik/page/home_page.dart';
import 'package:netvlik/page/film_page.dart';
import 'package:netvlik/page/login.dart';
import 'package:netvlik/utils/user_provider.dart';
import 'package:provider/provider.dart';

class Template extends StatefulWidget {
  const Template({super.key});

  @override
  State<Template> createState() => _TemplateState();
}

class _TemplateState extends State<Template> {
  int _pageIndex = 0;

  void _logOut() {
    Provider.of<UserProvider>(context, listen: false).logOut();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
      (Route<dynamic> route) => false,
    );
  }

  final List<Widget> _pages = [const HomePage(), const FilmPage()];

  final List<String> _titles = ['Home', 'Film'];

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[_pageIndex]),
        titleTextStyle: const TextStyle(
          fontSize: 16,
        ),
        backgroundColor: const Color.fromRGBO(251, 2, 2, 1),
        elevation: 0,
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: (String value) {
              userProvider.toggleTheme(value);
            },
            itemBuilder: (BuildContext context) {
              return {'Dark', 'Light'}.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
            icon: const Icon(Icons.brightness_4),
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              _logOut();
            },
          ),
        ],
      ),
      body: _pages[_pageIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _pageIndex,
        onTap: (int index) {
          setState(() {
            _pageIndex = index;
          });
        },
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.movie),
            label: 'Item',
          ),
        ],
      ),
    );
  }
}
