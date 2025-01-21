import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class PlanetPage extends StatefulWidget {
  final String planetName;
  final String planetRoute;

  PlanetPage({required this.planetName, required this.planetRoute});

  @override
  _PlanetPageState createState() => _PlanetPageState();
}

class _PlanetPageState extends State<PlanetPage> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;
  late List<String> _planetImages;
  late String _planetVideo;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _planetImages = getPlanetImages(widget.planetRoute);
    _planetVideo = getPlanetVideo(widget.planetRoute);

    _controller = VideoPlayerController.asset(_planetVideo);
    _initializeVideoPlayerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: Image.asset(
                        'assets/images/${widget.planetRoute}.png',
                        width: 280,
                        height: 280,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        widget.planetName,
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 12, 62, 106),
                        ),
                      ),
                      SizedBox(height: 8),
                      Divider(color: Colors.grey),
                      Text(
                        getPlanetDescription(widget.planetRoute),
                        textAlign: TextAlign.right,
                        style: TextStyle(fontSize: 16),
                      ),
                      Divider(color: Colors.grey),
                      SizedBox(height: 16),
                      Text(
                        'صور الكوكب',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 90, 95, 98),
                        ),
                      ),
                      SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: _planetImages.map((imagePath) {
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(35.0),
                            child: Image.asset(
                              imagePath,
                              width: 155,
                              height: 155,
                              fit: BoxFit.cover,
                            ),
                          );
                        }).toList(),
                      ),
                      Divider(color: Colors.grey),
                      SizedBox(height: 16),
                      Text(
                        'فيديو الكوكب',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 90, 95, 98),
                        ),
                      ),
                      SizedBox(height: 8),
                      FutureBuilder(
                        future: _initializeVideoPlayerFuture,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.done) {
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  if (_isPlaying) {
                                    _controller.pause();
                                  } else {
                                    _controller.play();
                                  }
                                  _isPlaying = !_isPlaying;
                                });
                              },
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  AspectRatio(
                                    aspectRatio: _controller.value.aspectRatio,
                                    child: VideoPlayer(_controller),
                                  ),
                                  if (!_isPlaying)
                                    Icon(
                                      Icons.play_circle_outline,
                                      size: 64,
                                      color: Colors.white.withOpacity(0.8),
                                    ),
                                ],
                              ),
                            );
                          } else {
                            return Center(child: CircularProgressIndicator());
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              top: 40,
              left: 20,
              child: IconButton(
                icon: Icon(Icons.arrow_back, color: const Color.fromARGB(255, 88, 87, 87)),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  String getPlanetDescription(String route) {
    switch (route) {
      case 'Neptune':
        return '⁠ثامن كوكب من الشمس\n⁠يُعد نبتون كوكبًا غازيًا\n⁠كتلته أقل من زحل والمشتري، لكنها كبيرة جدًا\n⁠درجة حرارته وضغطه عاليين جدًا\n⁠يحتوي على كمية كبيرة من غاز الهيدروجين والهيليوم والميثان\n⁠له لون أزرق بسبب غاز الميثان الذي يمتص الضوء الأحمر ويعكس الأزرق\n⁠يحتوي على ست حلقات ضبابية تتكون من جزيئات الجليد والغبار';
      case 'venus':
        return 'يعتبر كوكب الزهره انه اكثر الكواكب حرارة\nكوكب الزهره يدور حول نفسه بعكس اتجاه دوران الارض حول نفسها\nالشمس تشرق على كوكب الزهره من الغرب وليس من الشرق\nيستغرق الزهره ٢٣٤ يوما للدوران حول نفسه لانه بطيئ جدا';
      case 'earth':
        return 'ثالث الكواكب بُعداً عن الارض\nيغطي الماء 71% من سطح الارض\nغلافنا الجوي فيه الكثير من الأكسجين لنتنفسه\nتدور الارض حول نفسها مرة كل 24 ساعة فيحدث الليل والنهار\nتدور الارض حول الشمس مرة كل 365 فتحدث الفصول الاربعة (الشتاء والربيع والصيف والخريف)';
      case 'mars':
        return 'رابع أكبر كوكب في المجموعة الشمسية بعد عطارد والزهرة والأرض\nيُعد المريخ كوكب صخري مشابه للأرض\nكتلة المريخ وجاذبيته أقل بكثير من تلك الموجودة على كوكب زحل\nيتكون المريخ من صخور وأتربة ولا يحتوي على كميات كبيرة من الغازات مثل الهيدروجين';
      case 'jupiter':
        return 'اكبر الكواكب في المجموعة الشمسية\nلدى كوكب المشتري اكثر من 79 قمر\nاليوم في كوكب المشتري عبارة عن ١٠ ساعات فقط\nيستغرق كوكب المشتري ١٢ سنة ليدور دورة كامله حول الشمس\nكوكب المشتري هو الكوكب الخامس في المجموعة الشمسية';
      case 'saturn':
        return 'ثاني اكبر كوكب بعد المُشتري\n⁠يُعد زُحل كوكب غازي\n⁠كتلته وجاذبيته كبيرتين\n⁠درجة حرارته وضغطه عاليين\n⁠يحتوي على كمية كبيرة من غاز الهيدروجين\n⁠يحتوي على تسع حلقات تتكون من الجليد والغبار';
      case 'uranus':
        return 'كوكب اورانوس\nسابع الكواكب بعدا عن الشمس\nثالث اكبر اكبر الكواكب في المجموعة الشمسية\nعدد الاقمار التابعة له   ٢٧ قمرا\nاول كوكب تم اكتشافة عن طريق التسليكوب\nيدور اورانوس حول الشمس مرة كل ٨٤ سنة\nيستغرق ١٧ ساعة لاتمام دورة واحدة من دورانه حول نفسه\nلدى كوكب اورانوس ١٣ حلقة متمايزة واكثر الحلقات لمعانا ابسلون (ε)';
      case 'mercury':
        return 'أصغر الكواكب في المجموعة الشمسية وأقربها إلى الشمس\nيُعد عطارد كوكب صخري مشابه للأرض، حيث يتكون من صخور \nكتلة عطارد وجاذبيته منخفضة نسبيًا مقارنة بالكواكب الأخرى\nعطارد لا يحتوي على أي غلاف جوي يذكر، وبالتالي لا يمكن وجود حياة على سطحه\nلا يوجد على عطارد أية حلقات أو أقمار ';
      default:
        return 'لا يوجد وصف متاح.';
    }
  }

  List<String> getPlanetImages(String route) {
    switch (route) {
      case 'Neptune':
        return [
          'assets/images/Neptune1.jpg',
          'assets/images/Neptune2.jpg',
          'assets/images/Neptune_Full.jpg',
        ];
      case 'venus':
        return [
          'assets/images/الزهره1.jpg',
          'assets/images/الزهره2.jpg',
          'assets/images/الزهره3.jpg',
        ];
      case 'earth':
        return [
          'assets/images/الارض1.jpg',
          'assets/images/الارض2.jpg',
          'assets/images/الارض3.jpg',
        ];
      case 'mars':
        return [
          'assets/images/المريخ1.jpg',
          'assets/images/المريخ2.jpg',
          'assets/images/المريخ3.jpg',
        ];
      case 'jupiter':
        return [
          'assets/images/المشتري.jpg',
          'assets/images/المشتري2.jpg',
          'assets/images/المشتري3.jpg',
        ];
      case 'saturn':
        return [
          'assets/images/زحل.jpg',
          'assets/images/زحل2.jpg',
          'assets/images/زحل3.jpg',
        ];
      case 'uranus':
        return [
          'assets/images/اورانوس1.jpg',
          'assets/images/اورانوس2.jpg',
          'assets/images/اورانوس3.jpg',
        ];
      case 'mercury':
        return [
          'assets/images/عطارد1.jpg',
          'assets/images/عطارد2.jpg',
          'assets/images/عطارد3.jpg',
        ];
      default:
        return [
          'assets/images/default_1.png',
          'assets/images/default_2.png',
          'assets/images/default_3.png',
        ];
    }
  }

  String getPlanetVideo(String route) {
    switch (route) {
      case 'Neptune':
        return 'assets/Neptune.mp4';
      case 'venus':
        return 'assets/Venus.mp4';
      case 'earth':
        return 'assets/Earth.mp4';
      case 'mars':
        return 'assets/Mars.mp4';
      case 'jupiter':
        return 'assets/Jupiter.mp4';
      case 'saturn':
        return 'assets/Saturn.mp4';
      case 'uranus':
        return 'assets/Uranus.mp4';
      case 'mercury':
        return 'assets/Mercury.mp4';
      default:
        return 'assets/videos/default_video.mp4';
    }
  }
}