import 'package:flutter/material.dart';
import 'package:weather_app/services/weather_service.dart';
import 'package:weather_app/pages/weather_page.dart';

class LanguagePage extends StatefulWidget {
  const LanguagePage({super.key});

  @override
  State<LanguagePage> createState() => _LanguagePageState();
}

class _LanguagePageState extends State<LanguagePage> {

  final _weatherService = WeatherService('c24cd5b2f824e0172c4fac058738658a');
  final Map<String, String> languageOptions = {
    'af': 'Afrikaans', 'ar': 'العربية', 'az': 'Azərbaycan', 
    'be': 'Беларуская', 'bg': 'Български', 
    'ca': 'Català', 'cz': 'Čeština', 
    'da': 'Dansk', 'de': 'Deutsch', 
    'el': 'Ελληνικά', 'en': 'English', 'es': 'Español', 'eu': 'Euskara', 
    'fi': 'Suomi', 'fr': 'Français', 
    'gl': 'Galego',
    'he': 'עברית', 'hi': 'हिन्दी', 'hr': 'Hrvatski', 'hu': 'Magyar', 
    'id': 'Bahasa Indonesia', 'is': 'Íslenska', 'it': 'Italiano', 
    'ja': '日本語', 
    'ka': 'ქართული', 'km': 'ខ្មែរ', 'kn': 'ಕನ್ನಡ', 'ku': 'Kurmancî', 
    'la': 'Latviešu', 
    'lt': 'Lietuvių', 
    'mk': 'Македонски', 'ml': 'മലയാളം', 'mn': 'Монгол', 
    'no': 'Norsk', 
    'pl': 'Polski', 'pt': 'Português - Portugal', 'pt_br': 'Português - Brasil', 
    'ro': 'Română', 'ru': 'Русский', 
    'sk': 'Slovenčina', 'sl': 'Slovenščina', 'sq': 'Shqip', 'sr': 'Српски', 'sv': 'Svenska', 
    'th': 'ไทย', 'tr': 'Türkçe',
    'uk': 'Українська', 
    'vi': 'Tiếng Việt', 
    'zh_cn': '简体中文', 'zh_tw': '繁體中文', 'zu': 'Zulu',
  };
  List<String> languageList = [];
  String? selectedLanguage;

  @override
  void initState() {
    super.initState();

    languageList = languageOptions.values.toList();
    selectedLanguage = 'English';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFFB3E5FC),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            chooseLanguage(),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _weatherService.userLang = languageOptions.keys.firstWhere(
                    (key) => languageOptions[key] == selectedLanguage
                  );
                });
                Navigator.pushReplacement(
                  context, 
                  MaterialPageRoute(builder: (context) => WeatherPage(_weatherService))
                );
              },
              child: Text(
                'OK'
              )
            )
          ],
        ),
      ),
    );
  }

  chooseLanguage() {

    return DropdownButton(
      items: languageList.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      value: selectedLanguage,
      onChanged: (value) {
        setState(() {
          selectedLanguage = value;
        });
      }
    );

  }
}