import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_translate/google_translate.dart';

final supportedLanguages = [
  {'name': 'French', 'code': 'fr'},
  {'name': 'English', 'code': 'en'},
  {'name': 'Spanish', 'code': 'es'},
  {'name': 'Arabic', 'code': 'ar'},
  {'name': 'Yoruba', 'code': 'yo'},
  {'name': 'Goun', 'code': 'gun'},
];

class ResultScreen extends StatelessWidget {
  final String text;

  const ResultScreen({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Texte Scanné'),
      ),
      body: Container(
        padding: EdgeInsets.all(30.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(text),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final selectedLanguage = await showDialog<Map<String, String>?>(
            context: context,
            builder: (context) {
              return SimpleDialog(
                title: const Text('Choissisez une langue'),
                children: supportedLanguages.map((language) {
                  return SimpleDialogOption(
                    child: Text(language['name']!),
                    onPressed: () {
                      Navigator.pop(context, language);
                    },
                  );
                }).toList(),
              );
            },
          );

          if (selectedLanguage != null) {
            try {
              final translation = await GoogleTranslate.initialize(
                  apiKey: text, targetLanguage: selectedLanguage['code']!);
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Traduction: ${translation}')));
            } catch (e) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text('Erreur: $e')));
            }
          }
        },
        child: const Icon(Icons.translate),
      ),
    );
  }
}
