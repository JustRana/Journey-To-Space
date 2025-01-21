import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:space_game/pages/EducationPage.dart';

class SettingsPage extends StatefulWidget {
  final int characterIndex;
  final String name;

  SettingsPage({required this.characterIndex, required this.name});

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late int _characterIndex;
  late String _name;
  Color _aboutContainerColor = Color.fromARGB(255, 223, 223, 223);
  Color _shareContainerColor = Color.fromARGB(255, 223, 223, 223);
  Color _contactContainerColor = Color.fromARGB(255, 223, 223, 223);

  final List<String> characterImages = [
    'assets/images/character/Ch1.png',
    'assets/images/character/Ch2.png',
    'assets/images/character/Ch3.png',
    'assets/images/character/Ch4.png',
    'assets/images/character/Ch5.png',
    'assets/images/character/Ch6.png',
  ];

  @override
  void initState() {
    super.initState();
    _characterIndex = widget.characterIndex;
    _name = widget.name;
  }

  void _editProfile() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return EditProfile(
          characterIndex: _characterIndex,
          name: _name,
          onSave: (newCharacterIndex, newName) {
            setState(() {
              _characterIndex = newCharacterIndex;
              _name = newName;
            });
            Navigator.pop(context);
          },
        );
      },
    );
  }

  Widget _buildSettingOption(String title, Color color, VoidCallback onTap) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) {
        setState(() {
          if (title == 'حول التطبيق') {
            _aboutContainerColor = Colors.white;
          } else if (title == 'مشاركة التطبيق') {
            _shareContainerColor = Colors.white;
          } else if (title == 'التواصل معنا') {
            _contactContainerColor = Colors.white;
          }
        });
      },
      onExit: (_) {
        setState(() {
          if (title == 'حول التطبيق') {
            _aboutContainerColor = Color.fromARGB(255, 223, 223, 223);
          } else if (title == 'مشاركة التطبيق') {
            _shareContainerColor = Color.fromARGB(255, 223, 223, 223);
          } else if (title == 'التواصل معنا') {
            _contactContainerColor = Color.fromARGB(255, 223, 223, 223);
          }
        });
      },
      child: InkWell(
        onTap: onTap,
        child: AnimatedContainer(
          duration: Duration(milliseconds: 300),
          padding: EdgeInsets.all(16.0),
          width: MediaQuery.of(context).size.width * 0.8,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Text(
            title,
            textAlign: TextAlign.right,
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 74, 74, 74),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 246, 249, 255),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      _name,
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: _editProfile,
                    ),
                  ],
                ),
                SizedBox(width: 16.0),
                CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage(characterImages[_characterIndex]),
                  backgroundColor: Colors.transparent,
                ),
              ],
            ),
            SizedBox(height: 16.0),
            _buildSettingOption(
              'حول التطبيق',
              _aboutContainerColor,
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AboutPage()),
                );
              },
            ),
            SizedBox(height: 16.0),
            _buildSettingOption(
              'مشاركة التطبيق',
              _shareContainerColor,
              () {
                Share.share('com.example.app');
              },
            ),
            SizedBox(height: 16.0),
            _buildSettingOption(
              'التواصل معنا',
              _contactContainerColor,
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ContactUs()),
                );
              },
            ),
            SizedBox(height: 16.0),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EducationPage(
                        characterIndex: _characterIndex,
                        name: _name,
                      ),
                    ),
                  );
                },
                child: Text('العودة إلى صفحة التعليم'),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(150, 50), 
                
                ),
              ),
            ),
            Spacer(),
            Align(
              alignment: Alignment.bottomCenter,
              child: Text(
                '1.0.0 (2024.07.16)',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EditProfile extends StatefulWidget {
  final int characterIndex;
  final String name;
  final Function(int, String) onSave;

  EditProfile({
    required this.characterIndex,
    required this.name,
    required this.onSave,
  });

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  late int _characterIndex;
  late TextEditingController _nameController;

  final List<String> characterImages = [
    'assets/images/character/Ch1.png',
    'assets/images/character/Ch2.png',
    'assets/images/character/Ch3.png',
    'assets/images/character/Ch4.png',
    'assets/images/character/Ch5.png',
    'assets/images/character/Ch6.png',
  ];

  @override
  void initState() {
    super.initState();
    _characterIndex = widget.characterIndex;
    _nameController = TextEditingController(text: widget.name);
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField(
            controller: _nameController,
            decoration: InputDecoration(labelText: 'اسم المستخدم'),
          ),
          SizedBox(height: 16.0),
          GridView.builder(
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 6, // عدد العناصر في كل صف
              childAspectRatio: 1, // نسبة العرض إلى الارتفاع لكل عنصر
            ),
            itemCount: characterImages.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _characterIndex = index;
                  });
                },
                child: CircleAvatar(
                  backgroundImage: AssetImage(characterImages[index]),
                  backgroundColor: _characterIndex == index
                      ? Color.fromARGB(255, 60, 162, 13)
                      : Colors.transparent,
                ),
              );
            },
          ),
          SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () {
              widget.onSave(_characterIndex, _nameController.text);
            },
            child: Text('حفظ'),
          ),
        ],
      ),
    );
  }
}


class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff2c1f6e),
        title: Text('حول التطبيق'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'حول التطبيق',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 25.0),
                Text(
                  'مرحبًا بك في تطبيقنا التعليمي الممتع والمبتكر الذي يختص بعلوم الفضاء! يهدف هذا التطبيق إلى تقديم تجربة تعليمية تفاعلية للأطفال من خلال دمج الألعاب التعليمية مع العناصر المرئية الجذابة باللغة العربية. نهدف إلى تعزيز المعرفة والمهارات الأساسية لدى الأطفال بطريقة ممتعة ومشوقة.',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
                SizedBox(height: 16.0),
                Text(
                  'مميزات التطبيق:',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  'تجربة تعليمية تفاعلية: يتميز التطبيق بمجموعة متنوعة من الألعاب التعليمية التي تساعد الأطفال على التعلم بطرق مبتكرة.\nرسومات جذابة: تصميمات رائعة ورسومات ملونة تجذب انتباه الأطفال وتزيد من تفاعلهم.\nاستكشاف الفضاء: يضم التطبيق مغامرات فضائية مشوقة، حيث يمكن للأطفال تعلم معلومات عن الكواكب، النجوم، والمجرات.',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
                SizedBox(height: 16.0),
                Text(
                  'هدفنا:',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  'نحن نسعى إلى توفير بيئة تعليمية آمنة وممتعة للأطفال من جميع الأعمار باللغة العربية. من خلال هذا التطبيق، نأمل في إلهام الأطفال وحبهم للتعلم عن الفضاء، وتحفيز فضولهم الفكري، ومساعدتهم على اكتساب مهارات جديدة بطريقة مسلية وممتعة.',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
                SizedBox(height: 16.0),
                Text(
                  'لماذا الفضاء؟',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  'الفضاء هو مجال شاسع ومليء بالعجائب التي تثير الفضول والإلهام. من خلال استكشاف الفضاء، يمكن للأطفال تعلم الكثير عن الكون الذي نعيش فيه، مما يعزز حبهم للعلوم والتكنولوجيا.',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
                SizedBox(height: 16.0),
                Text(
                  'نحن نؤمن بأن التعليم يمكن أن يكون ممتعًا وفعالًا في نفس الوقت. شكرًا لاختياركم تطبيقنا ونتمنى لكم تجربة تعليمية مثمرة وممتعة في عالم الفضاء.',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}



class ContactUs extends StatelessWidget {
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final appBarColor = Color(0xff2c1f6e);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarColor,
        title: Text('التواصل معنا'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: Text(
                    'التواصل معنا',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 8.0),
                Center(
                  child: Text(
                    'إذا كان لديك أي اقتراحات تحسينية لا تتردد في اقتراحها علينا',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.grey[700],
                    ),
                  ),
                ),
                SizedBox(height: 24.0),
                TextField(
                  controller: _emailController,
                  textAlign: TextAlign.right,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'البريد الإلكتروني',
                    alignLabelWithHint: true,
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16.0),
                TextField(
                  controller: _messageController,
                  textAlign: TextAlign.right,
                  maxLines: 5,
                  decoration: InputDecoration(
                    labelText: 'الرسالة',
                    alignLabelWithHint: true,
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16.0),
                Align(
                  alignment: Alignment.center,
                  child: ElevatedButton(
                    onPressed: () {
                      String email = _emailController.text.trim();
                      String message = _messageController.text.trim();

                      if (email.isEmpty || !email.contains('@')) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('يرجى إدخال عنوان بريد إلكتروني صحيح.'),
                          ),
                        );
                      } else if (message.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('يرجى إدخال رسالة.'),
                          ),
                        );
                      } else {
                        print('البريد الإلكتروني: $email');
                        print('الرسالة: $message');
                        _emailController.clear();
                        _messageController.clear();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: appBarColor,
                      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    ),
                    child: Text('إرسال'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}