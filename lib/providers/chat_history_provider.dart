import 'package:flutter/material.dart';

class ChatHistoryProvider extends ChangeNotifier {
  // ignore: prefer_final_fields
  List<Map<String, String>> _chatHistory = [
    {"role": "system", "content": "You are a helpful assistant named ava."},
    {"role": "assistant", "content": "Hi, my name is Ava."},
  ];

  List<Map<String, String>> get chatHistory => _chatHistory;

  void addUserPrompt(String userPrompt) {
    _chatHistory.add({"role": "user", "content": userPrompt});
    notifyListeners();
  }

  void addGPTResponse(String gptResponse) {
    _chatHistory.add({"role": "assistant", "content": gptResponse});
    notifyListeners();
  }
}
