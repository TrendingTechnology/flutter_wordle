# Flutter Wordle clone

I wanted to challenge myself after writing a [version of Wordle using F#](https://github.com/johnnysbug/fsharp-command-line-wordle), so I decided to try Flutter. This was a fun project, since Flutter allows for rapid feedback cycles during UI development.

You should be able to clone this repo and run it yourself, given you have setup your Flutter development environment. Here's a link to Flutter's [online documentation](https://flutter.dev/docs) for getting started.

I tried to implement the majority of features seen in the actual [Wordle](https://www.nytimes.com/games/wordle/index.html) game. Here's a list of features:

- displays shake animation when a word doesn't exist in the word list or is shorter than five characters
- flips the letter tiles in a staggered manner when a guess is accepted
- gives feeback phrases when winning the game
- updates keyboard to show used letters with appropriate colors
- tracks game stats and persists them to the device (tested on iOS and Android, but may work in Chrome as well)
- generates a random word to guess for every new game (this is different than the official Wordle which generates a random word once a day)

### TODO:
- ~~animate winning word tiles~~
- implement hard mode
- implement dark/light theme settings
- ~~implement rules screen~~
- implement logic to generate a new word once a day that matches official game

<p align="center">
<img src="https://user-images.githubusercontent.com/1800439/160267131-11238e51-d079-4e7f-9f86-fdeddca1cfcd.gif" width="40%" />
<img src="https://user-images.githubusercontent.com/1800439/160973073-e59ee475-58b8-419d-a1be-e9283e269adc.png" width="40%" />
</p>
---

Here's few resources to get you started if this is your first time using Flutter:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
