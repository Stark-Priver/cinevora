# Cinevora

A premium multimedia streaming UI application built with Flutter.

## Features

- **Home** — Featured banner, Continue Watching, Movies, Anime, YouTube, Music, Manga sections
- **Search** — Full-text search across all content types with filter chips
- **Browse** — Category grid (Movies, Anime, Manga, Animation, Trending, etc.)
- **Manga** — Grid browser + full reader (vertical scroll & page swipe modes)
- **Music** — Track list, Now Playing card, Full-screen player, Queue bottom sheet
- **Video Player** — Fullscreen landscape player with auto-hide controls
- **Mini Player** — Persistent music bar above bottom navigation
- **Detail Screens** — Movie detail (with related), Anime detail (with episode list)

## Tech Stack

| Layer | Technology |
|---|---|
| Framework | Flutter 3.x |
| State Management | Riverpod 2 |
| Fonts | Google Fonts (DM Sans) |
| Images | CachedNetworkImage + Unsplash |
| Data | Mock data (no backend) |

## Design System

```
Background:     #0B0F1A
Surface:        #121726
Primary:        #6C5CE7
Accent:         #00D1FF  (used sparingly)
Text Primary:   #FFFFFF
Text Secondary: #AAB0C0
Divider:        rgba(255,255,255,0.08)
```

- **No gradients** anywhere
- **No glow / neon** effects
- **Subtle glass** — blur 10, opacity 0.04, used sparingly
- **Animations** — 150–200ms, scale 1.0 → 1.03, fade transitions
- **8pt spacing system** throughout

## Project Structure

```
lib/
├── main.dart                          # Entry point
├── app_shell.dart                     # Bottom nav + MiniPlayer shell
├── core/
│   └── theme/
│       └── app_theme.dart            # Colors, ThemeData, typography
├── models/
│   └── models.dart                   # Movie, Anime, MusicTrack, Manga, YouTubeVideo
├── data/
│   ├── mock_data.dart                # All mock content
│   └── providers.dart               # Riverpod providers
├── widgets/
│   ├── shared_widgets.dart           # GlassContainer, MediaCard, ChipFilter, etc.
│   └── mini_player.dart             # Persistent music mini-player
└── features/
    ├── home/
    │   └── home_screen.dart
    ├── search/
    │   └── search_screen.dart
    ├── browse/
    │   └── browse_screen.dart
    ├── manga/
    │   ├── manga_screen.dart
    │   └── manga_reader_screen.dart
    ├── music/
    │   ├── music_screen.dart
    │   └── full_player_screen.dart
    ├── media/
    │   ├── movie_detail_screen.dart
    │   └── anime_detail_screen.dart
    └── player/
        └── video_player_screen.dart
```

## Getting Started

### Prerequisites

- Flutter SDK >= 3.0.0
- Dart SDK >= 3.0.0
- Android Studio / VS Code with Flutter extension

### Installation

```bash
# Clone or extract the project
cd cinevora

# Install dependencies
flutter pub get

# Run on connected device or emulator
flutter run
```

### Build

```bash
# Android
flutter build apk --release

# iOS
flutter build ipa --release
```

## State Management

All state is managed via **Riverpod 2**:

| Provider | Purpose |
|---|---|
| `currentTabProvider` | Bottom navigation index |
| `playerProvider` | Music playback (track, play/pause, progress) |
| `searchProvider` | Search query, filter, results |
| `mangaReaderProvider` | Reader mode, current chapter/page, UI visibility |
| `moviesProvider` | Movies list |
| `animeProvider` | Anime list |
| `tracksProvider` | Music tracks |
| `mangaListProvider` | Manga list |
| `youtubeVideosProvider` | YouTube videos |
| `continueWatchingProvider` | Continue watching items |

## Key Components

### `MediaCard`
Reusable poster card with scale animation, rounded corners, optional badge.

### `GlassContainer`
Subtle glass effect using `BackdropFilter`. Blur 10, opacity 0.04.

### `MiniPlayer`
Fixed bar above bottom nav. Shows album art, title, controls. Tap to expand to `FullPlayerScreen`.

### `ChipFilter`
Animated filter chip row for search/browse filtering.

### `SectionHeader`
Title + optional "See all" action, consistent padding.

## Extending the App

### Add real video playback
Replace `VideoPlayerScreen`'s placeholder with `video_player` package:
```dart
dependencies:
  video_player: ^2.8.1
```

### Add Supabase backend
```dart
dependencies:
  supabase_flutter: ^2.3.0
```

Replace `MockData` providers with Supabase queries in `providers.dart`.

### Add actual audio playback
```dart
dependencies:
  just_audio: ^0.9.36
  audio_service: ^0.18.12
```

Extend `PlayerNotifier` to control a `just_audio` player instance.
