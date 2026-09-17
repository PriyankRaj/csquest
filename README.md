# Computer Science Quest

A gamified way to learn computer science subjects (Process Quest) and
drag-and-drop coding (Code Quest), built as a native Flutter app for Android
and iOS.

Bottom navigation switches between the two quests; each keeps its own
navigation stack. This is a vertical-slice scaffold: one fully working
subject (Operating Systems) and one fully working topic (Bring a Character
to Life), with the rest of the curriculum listed as "Coming soon".

## Run it

```bash
flutter pub get
flutter run            # picks from connected devices/emulators/simulators
flutter test           # widget + end-to-end flow tests
```

## iml/idea files

`cs_quest.iml` is a JetBrains project marker; harmless to ignore if you're
not using IntelliJ/Android Studio.
