import 'package:flutter/material.dart';
import 'package:nature_sites_app/data.dart';

void main() {
  runApp(SitesApp());
}

class SitesApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SitesApp();
}

class _SitesApp extends State<SitesApp> {
  int _selectedSite = -1;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nature Sites',
      home: Navigator(
        pages: [
          MaterialPage(
            key: ValueKey('SitePage'),
            child: SitesScreen(
              onTapped: _handleSiteTapped,
            ),
          ),
          if (_selectedSite != -1)
            MaterialPage(
              key: ValueKey(_selectedSite),
              /*
              страница заповедника строится по индексу заповедника,
              выбранного пользователем;
              этот индекс соответствует информации о заповеднике,
              представленной в массивах в data.dart
               */
              child: SiteDetailScreen(index: _selectedSite)
            )
        ],
        //возврат со страницы заповедника на список заповедников
        onPopPage: (route, result) {
          if (!route.didPop(result)) return false;

          setState(() {
            _selectedSite = -1;
          });

          return true;
        },
      )
    );
  }

  void _handleSiteTapped(int index) {
    setState(() {
      _selectedSite = index;
    });
  }
}

//страница со списком заповедников
class SitesScreen extends StatelessWidget {
  ValueChanged<int> onTapped;

  SitesScreen({required this.onTapped});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Заповедники России"),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: sites.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage(sitesImages[index]),),
            title: Text(sites[index]),
            subtitle: Text(sitesEng[index]),
            //выбор заповедника (его индекса) пользователем
            onTap: () => onTapped(index),
          );
        },
      )
    );
  }
}

//страница конкретного заповедника
class SiteDetailScreen extends StatelessWidget {
  int index;

  SiteDetailScreen({required this.index});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(sites[index]),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image(image: AssetImage(sitesImages[index]), ),
              const SizedBox(height: 20.0,),
              Text(sitesDescription[index])
            ],
          ),
      ))
    );
  }
}