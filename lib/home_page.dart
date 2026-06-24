import 'package:dranzerx/features_box.dart';
import 'package:dranzerx/gemini_service.dart';
import 'package:dranzerx/pallete.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final SpeechToText speechToText = SpeechToText();
  String lastWords = '';
  final GeminiService geminiService = GeminiService();

  @override
  void initState() {
    super.initState();
    initSpeech();
  }

  /// Initialize speech + check permission
  Future<void> initSpeech() async {
    bool available = await speechToText.initialize(
      onStatus: (status) => print("STATUS: $status"),
      onError: (error) => print("ERROR: $error"),
    );

    if (available) {
      print("🎤 Speech recognition initialized");
    } else {
      print("❌ Speech recognition unavailable. Permission denied?");
    }
  }

  /// Start listening
  Future<void> startListening() async {
    await speechToText.listen(
      onResult: onSpeechResult,
      listenMode: ListenMode.confirmation,
    );
    print("🎙️ Listening…");
  }

  /// Stop listening
  Future<void> stopListening() async {
    await speechToText.stop();
    print("🛑 Stopped listening");
  }

  /// Callback when speech is recognized
  void onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      lastWords = result.recognizedWords;
    });

    print("👉 You said: ${result.recognizedWords}");
  }

  @override
  void dispose() {
    speechToText.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'DranzerX',
          style: TextStyle(
            fontFamily: 'RobotoSlab',
            color: Pallete.boxFontColor,
          ),
        ),
        centerTitle: true,
        leading: Icon(Icons.menu),
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 15),

            Center(
              child: CircleAvatar(
                radius: 60,
                backgroundColor: Pallete.assistantCircleColor,
                backgroundImage: AssetImage('assets/images/person.png'),
              ),
            ),

            // Greeting bubble
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              margin: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              decoration: BoxDecoration(
                border: Border.all(color: Pallete.borderColor),
                borderRadius: BorderRadius.circular(20).copyWith(topLeft: Radius.zero),
              ),
              child: Text(
                'Good Morning, what task can I do for you?',
                style: TextStyle(
                  fontFamily: 'RobotoSlab',
                  fontSize: 23,
                  color: Pallete.mainFontColor,
                ),
              ),
            ),

            // Features
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 22),
                child: Text(
                  'Here are a few features',
                  style: TextStyle(
                    fontFamily: 'RobotoSlab',
                    fontWeight: FontWeight.bold,
                    color: Pallete.boxFontColor,
                    fontSize: 15,
                  ),
                ),
              ),
            ),

            Column(
              children: [
                FeaturesBox(
                  color: Pallete.firstSuggestionBoxColor,
                  headerText: 'Gemini',
                  descriptionText: 'A smarter way to stay organized and informed with Gemini AI',
                ),
                FeaturesBox(
                  color: Pallete.secondSuggestionBoxColor,
                  headerText: 'Hugging Face',
                  descriptionText: 'Create stylish images using Hugging Face image generation APIs',
                ),
                FeaturesBox(
                  color: Pallete.thirdSuggestionBoxColor,
                  headerText: 'Smart Voice Assistant',
                  descriptionText: 'A voice assistant powered by Gemini AI and Hugging Face APIs',
                ),
              ],
            ),

            SizedBox(height: 20),

            // Show last spoken words
            Text(
              lastWords.isEmpty ? "" : "You said: $lastWords",
              style: TextStyle(
                fontFamily: 'RobotoSlab',
                fontSize: 18,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Pallete.firstSuggestionBoxColor,
        child: Icon(
          speechToText.isListening ? Icons.stop : Icons.mic,
          color: Pallete.boxFontColor,
        ),
        onPressed: () async {
          if (speechToText.isListening) {
          final speech =  await geminiService.isArtPromptAPI(lastWords);
          print(speech);
            await stopListening();
          } else {
            await startListening();
          }
        },
      ),
    );
  }
}
