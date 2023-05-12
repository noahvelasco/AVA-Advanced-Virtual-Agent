<p align="center">
<img src="./assets/images/splash.png" alt="Alternative text" title="Image title" height="300"/>
</p>

# AVA - Advanced Virtual Agent

*AVA* stands for ***advanced virtual agent*** and is meant to help anyone with quick/on-tap question handling on mobile platforms. Created by Noah Velasco, AVA started as a personal project and will continue to be supported until further notice. This repository can be used by anyone however requires API key's anyone can generate for free from [OpenAI](https://platform.openai.com/account/api-keys) and [ElevenLabs](https://docs.elevenlabs.io/authentication/01-xi-api-key). The goal is to create a plug and play virtual agent that anyone can use with minor constraints such as the overall UI/UX experience.


<h3 align="center">Technologies Used</h3>
<p align="center">
<a href="https://dart.dev" target="_blank" rel="noreferrer"> <img src="https://www.vectorlogo.zone/logos/dartlang/dartlang-icon.svg" alt="dart" width="40" height="40"/>
<a href="https://flutter.dev" target="_blank" rel="noreferrer"><img src="https://www.vectorlogo.zone/logos/flutterio/flutterio-icon.svg" alt="flutter" width="40" height="40"/></a><a href="https://beta.elevenlabs.io/" target="_blank" rel="noreferrer"><img src="https://upload.wikimedia.org/wikipedia/commons/9/99/Eleven_Labs.png" alt="flutter" height="40"/></a><a href="https://openai.com/blog/chatgpt" target="_blank" rel="noreferrer"> <img src="https://i.insider.com/63ef9e660270b1001984d9ce?width=1300&format=jpeg&auto=webp" alt="flutter" height="40"/></a><a href="https://pub.dev/packages/sqflite" target="_blank" rel="noreferrer"> <img src="https://www.vectorlogo.zone/logos/sqlite/sqlite-ar21.svg" alt="flutter" height="40"/></a>
</p>

---
## Live Demo
- TBA

---
## Features & TODO's
- [x] Light/Dark mode implementation
- [x] Basic input and output from GPT-3.5-Turbo
- [x] Reads GPT-3.5-Turbo output using ElevenLabs Text-To-Speech
- [x] Modify/Update request parameters of GPT and ElevenLabs using sliders
- [x] About and license page
- [x] Modify/Update the API key's in App
- [x] Introduction page for initial user setup
- [ ] Validate API keys before submission
- [ ] Store user settings and API keys locally using sqflite
- [ ] Prompt selection
- [ ] Custom prompt creation

---
## How to use
1. Download this repository
2. Run `flutter pub get` in `./ava_v2`
3. Run `flutter run` in `lib/main.dart`

---

## Build Info
* Flutter 3.7.3
* Dart 2.19.2
* DevTools 2.20.1


---
## Possible Issues
### Android
* Enable developer mode on your phone

### iOS
*  Enable developer mode on your phone