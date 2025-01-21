import 'package:flutter/material.dart';
import 'package:space_game/pages/GamePage.dart';
import 'package:space_game/pages/PlanetPage.dart';
import 'package:space_game/pages/SettingsPage.dart';
import 'package:carousel_slider/carousel_slider.dart';

class EducationPage extends StatefulWidget {
  final int characterIndex;
  final String name;

  EducationPage({required this.characterIndex, required this.name});

  @override
  _EducationPageState createState() => _EducationPageState();
}

class _EducationPageState extends State<EducationPage> {
  final List<String> characterImages = [
    'assets/images/character/Ch1.png',
    'assets/images/character/Ch2.png',
    'assets/images/character/Ch3.png',
    'assets/images/character/Ch4.png',
    'assets/images/character/Ch5.png',
    'assets/images/character/Ch6.png',
  ];

  final List<Map<String, String>> planets = [
    {
      'image': 'assets/images/Neptune.png',
      'name': 'كوكب نبتون',
      'route': 'Neptune',
    },
    {
      'image': 'assets/images/Venus.png',
      'name': 'كوكب الزهرة',
      'route': 'venus',
    },
    {
      'image': 'assets/images/Earth.png',
      'name': 'كوكب الأرض',
      'route': 'earth',
    },
    {
      'image': 'assets/images/Mars.png',
      'name': 'كوكب المريخ',
      'route': 'mars',
    },
    {
      'image': 'assets/images/Jupiter.png',
      'name': 'كوكب المشتري',
      'route': 'jupiter',
    },
    {
      'image': 'assets/images/Saturn.png',
      'name': 'كوكب زحل',
      'route': 'saturn',
    },
    {
      'image': 'assets/images/Mercury.png',
      'name': 'كوكب عطارد',
      'route': 'mercury',
    },
    {
      'image': 'assets/images/Uranus.png',
      'name': 'كوكب أورانوس',
      'route': 'uranus',
    },
  ];

  int _currentIndex = 0;

  void _navigateToPage(BuildContext context, int index) {
    setState(() {
      _currentIndex = index;
    });

    switch (index) {
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => GamePage(
              characterIndex: widget.characterIndex,
              name: widget.name,
            ),
          ),
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SettingsPage(
              characterIndex: widget.characterIndex,
              name: widget.name,
            ),
          ),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xff1E72BA),
              Color(0xff2c1f6e),
            ],
          ),
        ),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.only(top: 110),
                child: Image.asset(
                  "assets/images/bg_stars.png",
                  fit: BoxFit.contain,
                ),
              ),
            ),
            SafeArea(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.arrow_back, color: Colors.white),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        Spacer(),
                        Text(
                          'مرحبًا ${widget.name}',
                          style: TextStyle(fontSize: 20.0, color: Colors.white),
                        ),
                        SizedBox(width: 10),
                        Image.asset(
                          characterImages[widget.characterIndex],
                          width: 60,
                          height: 60,
                        ),
                      ],
                    ),
                  ),
                  const Text(
                    "أستكشف الفضاء",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 20),
                  Expanded(
                    child: CarouselSlider(
                      items: planets.map((planet) {
                        return Container(
                          width: 250.0,
                          height: 230.0, // تقليل الارتفاع
                          padding: EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 8.0,
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Positioned(
                                top: -50,
                                left: 40,
                                child: Image.asset(
                                  planet['image']!,
                                  width: 150,
                                  height: 150,
                                ),
                              ),
                              Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      planet['name']!,
                                      style: TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                              Positioned(
                                bottom: 10,
                                left: 0,
                                right: 0,
                                child: Center(
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => PlanetPage(
                                            planetName: planet['name']!,
                                            planetRoute: planet['route']!,
                                          ),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      width: 60,
                                      height: 60,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.orange,
                                      ),
                                      child: Icon(
                                        Icons.arrow_forward,
                                        color: Colors.white,
                                        size: 25,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                      options: CarouselOptions(
                        autoPlay: false,
                        enlargeCenterPage: true,
                        aspectRatio: 1.8,
                        viewportFraction: 0.6,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          icon: Icon(Icons.school, color: _currentIndex == 0 ? const Color.fromARGB(255, 243, 170, 33) : Colors.white),
                          onPressed: () {
                            // Do nothing, already on education page
                            _navigateToPage(context, 0);
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.videogame_asset, color: _currentIndex == 1 ? const Color.fromARGB(255, 243, 170, 33) : Colors.white),
                          onPressed: () {
                            _navigateToPage(context, 1);
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.settings, color: _currentIndex == 2 ? const Color.fromARGB(255, 243, 170, 33) : Colors.white),
                          onPressed: () {
                            _navigateToPage(context, 2);
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}