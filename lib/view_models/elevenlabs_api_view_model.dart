import 'package:ava_v2/database/api_key_storage_helper.dart';
import 'package:ava_v2/providers/export_providers.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import 'package:provider/provider.dart';

class ELAPIViewModel extends ChangeNotifier {
//For the Text To Speech
  Future<void> playTextToSpeech(
    BuildContext context,
    APIKeyStorageHelper apiStorage,
  ) async {
    //display the loading icon while we wait for request
    // setState(() {
    //   _isLoadingVoice = true; //progress indicator
    // });

    final settingsProvider =
        Provider.of<SettingsProvider>(context, listen: false);

    final isLoadingVoiceProvider =
        Provider.of<LoadingIconELProvider>(context, listen: false);

    final chatHistoryProvider =
        Provider.of<ChatHistoryProvider>(context, listen: false);

    final player = AudioPlayer(); //audio player that will be playing the audio

    isLoadingVoiceProvider.setIsLoading(true);

    String apiKey = (await apiStorage.getELAPIKey()) ?? "";
    String url =
        'https://api.elevenlabs.io/v1/text-to-speech/21m00Tcm4TlvDq8ikWAM';
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'accept': 'audio/mpeg',
        'xi-api-key': apiKey,
        'Content-Type': 'application/json',
      },
      body: json.encode({
        "text": chatHistoryProvider.chatHistory.last['content'],
        "voice_settings": {
          "stability": settingsProvider.elLabsExpr,
          "similarity_boost": settingsProvider.elLabsClar,
        }
      }),
    );

    isLoadingVoiceProvider.setIsLoading(false);

    if (response.statusCode == 200) {
      final bytes = response.bodyBytes; //get the bytes ElevenLabs sent back
      await player.setAudioSource(MyCustomSource(
          bytes)); //send the bytes to be read from the JustAudio library
      player.play(); //play the audio
    } else {
      // throw Exception('Failed to load audio');
      return;
    }
  } //getResponse from Eleven Labs
}

// Feed your own stream of bytes into the player - Taken from JustAudio package
class MyCustomSource extends StreamAudioSource {
  final List<int> bytes;
  MyCustomSource(this.bytes);

  @override
  Future<StreamAudioResponse> request([int? start, int? end]) async {
    start ??= 0;
    end ??= bytes.length;
    return StreamAudioResponse(
      sourceLength: bytes.length,
      contentLength: end - start,
      offset: start,
      stream: Stream.value(bytes.sublist(start, end)),
      contentType: 'audio/mpeg',
    );
  }
}
