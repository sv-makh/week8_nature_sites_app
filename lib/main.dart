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

  /*List<String> sites = [
    "Алтайский заповедник",
    "Байкальский заповедник",
    "Командорский заповедник"
  ];

  List<String> sitesEng = [
    "Altai Nature Reserve",
    "Baikal Nature Reserve",
    "Komandorsky Nature Reserve"
  ];

  List<String> sitesImages = [
    "assets/images/1Uchar_Waterfalls.jpg",
    "assets/images/2Baical_reservate.jpg",
    "assets/images/3Medny.jpg"
  ];*/

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
              child: SiteDetailScreen(index: _selectedSite)
            )
        ],
        onPopPage: (route, result) => route.didPop(result),
      )
    );
  }

  void _handleSiteTapped(int index) {
    setState(() {
      _selectedSite = index;
    });
  }
}

class SitesScreen extends StatelessWidget {
  ValueChanged<int> onTapped;

  SitesScreen({required this.onTapped});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView.builder(
        itemCount: sites.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage(sitesImages[index]),),
            title: Text(sites[index]),
            subtitle: Text(sitesEng[index]),
            onTap: () => onTapped(index),
          );
        },
      )
    );
  }
}