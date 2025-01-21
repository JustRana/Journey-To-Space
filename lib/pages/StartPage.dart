import 'package:flutter/material.dart';
import 'package:space_game/pages/EducationPage.dart';

class StartPage extends StatefulWidget {
  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  int selectedCharacterIndex = -1;
  final TextEditingController nameController = TextEditingController();

  final List<Map<String, String>> characters = [
    {'image': 'assets/images/character/Ch1.png', 'name': 'شخصية 1'},
    {'image': 'assets/images/character/Ch2.png', 'name': 'شخصية 2'},
    {'image': 'assets/images/character/Ch3.png', 'name': 'شخصية 3'},
    {'image': 'assets/images/character/Ch4.png', 'name': 'شخصية 4'},
    {'image': 'assets/images/character/Ch5.png', 'name': 'شخصية 5'},
    {'image': 'assets/images/character/Ch6.png', 'name': 'شخصية 6'},
  ];

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
                child: Image.asset("assets/images/bg_stars.png", fit: BoxFit.contain),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: 90),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: 1,
                      ),
                      itemCount: characters.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedCharacterIndex = index;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: selectedCharacterIndex == index
                                  ? const Color.fromARGB(123, 76, 175, 79)
                                  : Color.fromARGB(110, 255, 255, 255),
                              borderRadius: BorderRadius.circular(25),
                            ),
                            padding: EdgeInsets.all(10.0),
                            child: Image.asset(
                              characters[index]['image']!,
                              height: 30,
                              width: 30,
                            ),
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 30),
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: TextField(
                        controller: nameController,
                        textAlign: TextAlign.right,
                        decoration: InputDecoration(
                          labelText: 'ادخل اسمك',
                          filled: true,
                          fillColor: const Color.fromARGB(110, 255, 255, 255),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    ElevatedButton(
                      onPressed: () {
                        if (selectedCharacterIndex != -1 &&
                            nameController.text.isNotEmpty) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EducationPage(
                                characterIndex: selectedCharacterIndex,
                                name: nameController.text,
                              ),
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        primary: const Color.fromARGB(255, 243, 170, 33),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      child: Text('ابدأ التعليم'),
                    ),
                    SizedBox(height: 50),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}