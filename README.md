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
## Preview
<p align="center">
<img src=".\app_screenshots\home.png" alt="flutter" height="500"/>
<img src=".\app_screenshots\settings.png" alt="flutter" height="500"/>
<img src=".\app_screenshots\credits.png" alt="flutter" height="500"/>
</p>


---
## Live Demo

<p align =center>
<a href = "https://youtu.be/Li2T6gfwauY"><img src="https://i.ytimg.com/an_webp/Li2T6gfwauY/mqdefault_6s.webp?du=3000&sqp=CJKotKQG&rs=AOn4CLDSNZgVQnij7Slvgi13fq0sy_QljA" alt="ava demo" height="200"/></a>

<h3><a href = "https://youtu.be/Li2T6gfwauY">Demo Link (Youtube)</a></h3>

</p>

---
## Features & TODO's
- [x] Light/Dark mode implementation
- [x] Basic input and output from GPT-3.5-Turbo
- [x] Reads GPT-3.5-Turbo output using ElevenLabs Text-To-Speech
- [x] Modify/Update request parameters of GPT and ElevenLabs using sliders
- [x] About and license page
- [x] Modify/Update the API key's in App
- [x] Store user gpt and elevenlabs slider configuations (volatile)
- [x] Introduction page for initial user setup
- [x] Store user API keys using secure storage (non volatile memory)
- [x] Preset prompt selection using sqflite
- [x] Comment cleanup
- [x] Documentation

---
## How to use
1. Download flutter
2. Download this repo
3. `flutter run` in `./ava_v2/lib/main.dart`

---

## Build Info
* Flutter 3.7.12
* Dart 2.19.6
* DevTools 2.20.1

---
## Possible Issues

### Both
* Incompatible with Flutter 3.10

### Android
* Enable developer mode on your phone

### iOS
*  Enable developer mode on your phone