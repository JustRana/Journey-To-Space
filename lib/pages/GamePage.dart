import 'package:flutter/material.dart';
import 'package:space_game/pages/EducationPage.dart';
import 'package:space_game/pages/ItemModel.dart';

class GamePage extends StatefulWidget {
  final int characterIndex;
  final String name;

  GamePage({required this.characterIndex, required this.name});

  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  List<ItemModel> items = [];
  List<ItemModel> items2 = [];
  int score = 0;
  bool gameOver = false;
  bool gameStarted = true;

  @override
  void initState() {
    super.initState();
    initGame();
  }

  void initGame() {
    gameOver = false;
    score = 0;
    items = [
      ItemModel(value: 'الارض', name: 'الارض', img: 'assets/images/Earth.png'),
      ItemModel(value: 'نبتون', name: 'نبتون', img: 'assets/images/Neptune.png'),
      ItemModel(value: 'زحل', name: 'زحل', img: 'assets/images/Saturn.png'),
      ItemModel(value: 'المريخ', name: 'المريخ', img: 'assets/images/Mars.png'),
      ItemModel(value: 'الزهرة', name: 'الزهرة', img: 'assets/images/Venus.png'),
      ItemModel(value: 'المشتري', name: 'المشتري', img: 'assets/images/Jupiter.png'),
      ItemModel(value: 'أورانوس', name: 'أورانوس', img: 'assets/images/Uranus.png'),
    ];
    items2 = List<ItemModel>.from(items);
    items.shuffle();
    items2.shuffle();
  }

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) gameOver = true;

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
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.arrow_back, color: Colors.white),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EducationPage(
                                  characterIndex: widget.characterIndex,
                                  name: widget.name,
                                ),
                              ),
                            );
                          },
                        ),
                        Spacer(),
                        Text(
                          'مرحبًا بك  في اللعبة!',
                          style: TextStyle(
                            fontSize: 20.0,
                            color: const Color.fromARGB(252, 255, 255, 255),
                          ),
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
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: 'النتيجة:',
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                          TextSpan(
                            text: '$score',
                            style: Theme.of(context)
                                .textTheme
                                .headline2
                                ?.copyWith(color: Color.fromARGB(255, 250, 251, 251)),
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (!gameOver)
                    Expanded(
                      child: Row(
                        children: [
                          Spacer(),
                          Expanded(
                            child: ListView.builder(
                              itemCount: items.length,
                              itemBuilder: (context, index) {
                                final item = items[index];
                                return Container(
                                  margin: EdgeInsets.all(2),
                                  child: Draggable<ItemModel>(
                                    data: item,
                                    childWhenDragging: CircleAvatar(
                                      backgroundColor: Color.fromARGB(80, 255, 255, 255),
                                      backgroundImage: AssetImage(item.img),
                                      radius: 150,
                                    ),
                                    feedback: CircleAvatar(
                                      backgroundColor: Color.fromARGB(80, 255, 255, 255),
                                      backgroundImage: AssetImage(item.img),
                                      radius: 80,
                                    ),
                                    child: CircleAvatar(
                                      backgroundColor: const Color.fromARGB(80, 255, 255, 255),
                                      backgroundImage: AssetImage(item.img),
                                      radius: 40,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          Spacer(flex: 2),
                          Expanded(
                            child: ListView.builder(
                              itemCount: items2.length,
                              itemBuilder: (context, index) {
                                final item = items2[index];
                                return DragTarget<ItemModel>(
                                  onAccept: (receivedItem) {
                                    if (item.value == receivedItem.value) {
                                      setState(() {
                                        items.remove(receivedItem);
                                        items2.remove(item);
                                        score += 10;
                                        item.accepting = false;
                                      });
                                    } else {
                                      setState(() {
                                        score -= 5;
                                        item.accepting = false;
                                      });
                                    }
                                  },
                                  onWillAccept: (receivedItem) {
                                    setState(() {
                                      item.accepting = true;
                                    });
                                    return true;
                                  },
                                  onLeave: (receivedItem) {
                                    setState(() {
                                      item.accepting = false;
                                    });
                                  },
                                  builder: (context, acceptedItems, rejectedItems) => Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: item.accepting
                                          ? Color.fromARGB(80, 255, 255, 255)
                                          : Color.fromARGB(80, 255, 255, 255),
                                    ),
                                    height: MediaQuery.of(context).size.width / 6.5,
                                    width: MediaQuery.of(context).size.width / 3,
                                    margin: EdgeInsets.all(8),
                                    alignment: Alignment.center,
                                    child: Text(
                                      item.name,
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context).textTheme.headline6,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          Spacer(),
                        ],
                      ),
                    ),
                  if (gameOver)
                    Center(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              result(),
                              style: Theme.of(context).textTheme.headline3,
                            ),
                          ),
                          Container(
                            height: MediaQuery.of(context).size.width / 20,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 243, 170, 33),
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: TextButton(
                              onPressed: () {
                                setState(() {
                                  initGame();
                                });
                              },
                              child: Text(
                                'العب مرةاخرى',
                                style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
                              ),
                            ),
                          ),
                          SizedBox(height: 60),
                          Image.asset(
                            'assets/images/game.png',
                            width: MediaQuery.of(context).size.width / 2,
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

  String result() {
    if (score >= 50) {
      return 'رائع , عمل جيد';
    } else {
      return 'محاولة جيدة يمكنك الحصول على نتيجة افضل';
    }
  }

  final List<String> characterImages = [
    'assets/images/character/Ch1.png',
    'assets/images/character/Ch2.png',
    'assets/images/character/Ch3.png',
    'assets/images/character/Ch4.png',
    'assets/images/character/Ch5.png',
    'assets/images/character/Ch6.png',
  ];
}