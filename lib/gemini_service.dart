import 'dart:convert';

import 'package:dranzerx/secrets.dart';
import 'package:http/http.dart' as http;

class GeminiService {
  // this is the class which im making in which i'm gonna add some functions which can help in the working of chatgpt things by providing openAi services.

  final List<Map<String, String>> parts = [];

  get text => null;

  Future<String> isArtPromptAPI(String prompt) async {
    // this functions told us that the user wants to generate a picture or what a text solution.
    // so that the function can tell the app that which type of thing the app needs to process.
    try {
      final res = await http.post(
        Uri.parse(
          'https://generativelanguage.googleapis.com/v1beta/models/gemini-1.0-pro:generateContent?key=$geminiAPIKey',
        ),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "contents": [
            {
              "parts": [
                {
                  "text":
                  "Does this message want to generate an image, art, or picture? "
                      "Answer only Yes or No.\nMessage: $prompt"
                }
              ]
            }
          ]
        }),
      );

      if (res.statusCode == 200) {
        final data = jsonDecode(res.body);
        final answer =
        data['candidates'][0]['content']['parts'][0]['text']
            .toString()
            .toLowerCase();

        print('Gemini decision: $answer');

        if (answer.contains('yes')) {
          return await huggingFaceAPI(prompt);
        } else {
          return await geminiAPI(prompt);
        }
      }

      return 'Internal server error';
    } catch (e) {
      return 'Error: $e';
    }
  }

  // and when the user tells that the user wants to use gemini or the huggingFace then one of the function is used from these two below.

  Future<String> geminiAPI(String prompt) async {
    try {
      final res = await http.post(
        Uri.parse(
          'https://generativelanguage.googleapis.com/v1beta/models/gemini-1.0-pro:generateContent?key=$geminiAPIKey',
        ),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "contents": [
            {
              "parts": [
                {"text": prompt}
              ]
            }
          ]
        }),
      );

      if (res.statusCode == 200) {
        final data = jsonDecode(res.body);
        final text =
        data['candidates'][0]['content']['parts'][0]['text'];

        print('Gemini says: $text');
        return text;
      }

      return 'Gemini failed to respond';
    } catch (e) {
      return 'Error: $e';
    }
  }

  Future<String> huggingFaceAPI(String prompt) async {
    return 'HUGGINGFACE IMAGE GENERATED';
  }
}