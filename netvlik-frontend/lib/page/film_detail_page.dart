import 'package:flutter/material.dart';
import 'package:netvlik/Model/film.dart';
import 'package:netvlik/page/detail/description.dart';
import 'package:netvlik/page/detail/review.dart';

class FilmDetailPage extends StatelessWidget {
  final Film film;
  const FilmDetailPage({super.key, required this.film});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text(film.name),
            bottom: const TabBar(tabs: [
              Tab(
                icon: Icon(Icons.description),
                text: 'Description',
              ),
              Tab(
                icon: Icon(Icons.reviews),
                text: 'Review',
              ),
            ]),
          ),
          body: TabBarView(
            children: [
              DescriptionDetail(film: film),
              ReviewDetail(film: film),
            ],
          ),
        ));
  }
}
