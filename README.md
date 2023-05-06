![AVA Logo](./assets/images/logo-no-background.png)
# AVA - Advanced Virtual Agent

*AVA* stands for ***advanced virtual agent*** and is meant to help anyone with quick/on-tap question handling on mobile platforms. Created by Noah Velasco, AVA started as a personal project and will continue to be supported until further notice. This repository can be used by anyone however requires API key's anyone can generate for free from [OpenAI](https://platform.openai.com/account/api-keys) and [ElevenLabs](https://docs.elevenlabs.io/authentication/01-xi-api-key). The goal is to create a plug and play virtual agent that anyone can use with minor constraints such as the overall UI/UX experience.

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
~~- [ ] Validate API keys before submission~~
- [ ] Prompt selection
- [ ] Custom prompt creation
- [ ] Voice selection of up to 3 different voices
- [ ] Introduction page for initial user setup

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

### iOS (tbh idc about this rn)
*  Enable developer mode on your phone