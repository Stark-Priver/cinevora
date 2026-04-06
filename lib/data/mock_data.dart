// lib/data/mock_data.dart
import '../models/models.dart';

class MockData {
  // Using Unsplash for realistic placeholder images
  static const List<Movie> movies = [
    Movie(
      id: 'm1',
      title: 'Obsidian Dusk',
      description:
          'A lone detective unravels a city-wide conspiracy hidden beneath layers of corruption, silence, and shadow. A story about truth, power, and sacrifice.',
      imageUrl:
          'https://images.unsplash.com/photo-1536440136628-849c177e76a1?w=400&q=80',
      backdropUrl:
          'https://images.unsplash.com/photo-1536440136628-849c177e76a1?w=1200&q=80',
      year: '2024',
      duration: '2h 18m',
      rating: 8.4,
      genres: ['Thriller', 'Crime', 'Drama'],
    ),
    Movie(
      id: 'm2',
      title: 'Pale Meridian',
      description:
          'An astronaut stranded on a distant moon must survive long enough to transmit a final message back to Earth.',
      imageUrl:
          'https://images.unsplash.com/photo-1446776811953-b23d57bd21aa?w=400&q=80',
      backdropUrl:
          'https://images.unsplash.com/photo-1446776811953-b23d57bd21aa?w=1200&q=80',
      year: '2024',
      duration: '1h 54m',
      rating: 7.9,
      genres: ['Sci-Fi', 'Drama'],
    ),
    Movie(
      id: 'm3',
      title: 'The Last Harbor',
      description:
          'Two siblings reunite after a decade apart to settle their father\'s mysterious estate on a windswept coastal island.',
      imageUrl:
          'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=400&q=80',
      backdropUrl:
          'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=1200&q=80',
      year: '2023',
      duration: '2h 03m',
      rating: 8.1,
      genres: ['Mystery', 'Drama'],
    ),
    Movie(
      id: 'm4',
      title: 'Iron Veil',
      description:
          'A geopolitical thriller set in a near-future Europe where a covert operative uncovers a sleeper cell network.',
      imageUrl:
          'https://images.unsplash.com/photo-1478720568477-152d9b164e26?w=400&q=80',
      backdropUrl:
          'https://images.unsplash.com/photo-1478720568477-152d9b164e26?w=1200&q=80',
      year: '2024',
      duration: '2h 31m',
      rating: 7.6,
      genres: ['Action', 'Thriller'],
    ),
    Movie(
      id: 'm5',
      title: 'Soft Architecture',
      description:
          'A documentary exploring how the spaces we inhabit shape our minds, memories, and identities.',
      imageUrl:
          'https://images.unsplash.com/photo-1545324418-cc1a3fa10c00?w=400&q=80',
      backdropUrl:
          'https://images.unsplash.com/photo-1545324418-cc1a3fa10c00?w=1200&q=80',
      year: '2023',
      duration: '1h 22m',
      rating: 8.7,
      genres: ['Documentary'],
    ),
  ];

  static const List<Anime> animeList = [
    Anime(
      id: 'a1',
      title: 'Riftborn',
      description:
          'In a fractured world where dimensions overlap, a young warrior discovers she can traverse the rifts — but each crossing costs her memories.',
      imageUrl:
          'https://images.unsplash.com/photo-1578632767115-351597cf2477?w=400&q=80',
      backdropUrl:
          'https://images.unsplash.com/photo-1578632767115-351597cf2477?w=1200&q=80',
      year: '2024',
      episodes: 24,
      rating: 9.1,
      genres: ['Action', 'Fantasy', 'Adventure'],
      status: 'Ongoing',
    ),
    Anime(
      id: 'a2',
      title: 'Null Protocol',
      description:
          'A hacker in Neo-Osaka uncovers a digital ghost living inside the city\'s neural network.',
      imageUrl:
          'https://images.unsplash.com/photo-1558618666-fcd25c85cd64?w=400&q=80',
      backdropUrl:
          'https://images.unsplash.com/photo-1558618666-fcd25c85cd64?w=1200&q=80',
      year: '2023',
      episodes: 12,
      rating: 8.6,
      genres: ['Cyberpunk', 'Thriller'],
      status: 'Completed',
    ),
    Anime(
      id: 'a3',
      title: 'Solace Garden',
      description:
          'A quiet slice-of-life about a florist who discovers her shop is a nexus point for souls passing between worlds.',
      imageUrl:
          'https://images.unsplash.com/photo-1490750967868-88df5691cc7b?w=400&q=80',
      backdropUrl:
          'https://images.unsplash.com/photo-1490750967868-88df5691cc7b?w=1200&q=80',
      year: '2024',
      episodes: 13,
      rating: 8.9,
      genres: ['Slice of Life', 'Fantasy'],
      status: 'Completed',
    ),
    Anime(
      id: 'a4',
      title: 'Gravestone Kings',
      description:
          'Five delinquents with supernatural abilities are recruited into an ancient order to protect the living from wandering spirits.',
      imageUrl:
          'https://images.unsplash.com/photo-1518709268805-4e9042af2176?w=400&q=80',
      backdropUrl:
          'https://images.unsplash.com/photo-1518709268805-4e9042af2176?w=1200&q=80',
      year: '2024',
      episodes: 24,
      rating: 8.3,
      genres: ['Supernatural', 'Action'],
      status: 'Ongoing',
    ),
  ];

  static const List<MusicTrack> tracks = [
    MusicTrack(
      id: 't1',
      title: 'Hollow Frequencies',
      artist: 'Lunar Static',
      album: 'Negative Space',
      albumArt:
          'https://images.unsplash.com/photo-1493225457124-a3eb161ffa5f?w=400&q=80',
      duration: '4:12',
      durationSeconds: 252,
    ),
    MusicTrack(
      id: 't2',
      title: 'Glass Weather',
      artist: 'The Pale Circuit',
      album: 'Shatterpoint',
      albumArt:
          'https://images.unsplash.com/photo-1470225620780-dba8ba36b745?w=400&q=80',
      duration: '3:47',
      durationSeconds: 227,
    ),
    MusicTrack(
      id: 't3',
      title: 'Dusk Protocol',
      artist: 'Feral Signal',
      album: 'Dead Channel',
      albumArt:
          'https://images.unsplash.com/photo-1511671782779-c97d3d27a1d4?w=400&q=80',
      duration: '5:03',
      durationSeconds: 303,
    ),
    MusicTrack(
      id: 't4',
      title: 'Carbon Memory',
      artist: 'Mute City Ensemble',
      album: 'Archive Vol. 2',
      albumArt:
          'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=400&q=80',
      duration: '3:29',
      durationSeconds: 209,
    ),
    MusicTrack(
      id: 't5',
      title: 'Signal Decay',
      artist: 'Lunar Static',
      album: 'Negative Space',
      albumArt:
          'https://images.unsplash.com/photo-1493225457124-a3eb161ffa5f?w=400&q=80',
      duration: '4:55',
      durationSeconds: 295,
    ),
    MusicTrack(
      id: 't6',
      title: 'Peripheral Drift',
      artist: 'Asha Veil',
      album: 'Margins',
      albumArt:
          'https://images.unsplash.com/photo-1465225314224-587cd83d322b?w=400&q=80',
      duration: '3:18',
      durationSeconds: 198,
    ),
  ];

  static final List<Manga> mangaList = [
    const Manga(
      id: 'mg1',
      title: 'The Quiet Fracture',
      description:
          'A renowned architect begins to see cracks appearing in reality itself — mirroring the fractures in his own mind. A psychological journey through perception.',
      coverUrl:
          'https://images.unsplash.com/photo-1544716278-ca5e3f4abd8c?w=400&q=80',
      author: 'Kenji Mura',
      genres: ['Psychological', 'Mystery', 'Seinen'],
      chapters: 87,
      rating: 9.2,
      chapterList: [
        MangaChapter(
          number: 1,
          title: 'The First Crack',
          pages: [
            'https://images.unsplash.com/photo-1544716278-ca5e3f4abd8c?w=800&q=80',
            'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=800&q=80',
            'https://images.unsplash.com/photo-1536440136628-849c177e76a1?w=800&q=80',
          ],
        ),
        MangaChapter(
          number: 2,
          title: 'Widening Fault',
          pages: [
            'https://images.unsplash.com/photo-1446776811953-b23d57bd21aa?w=800&q=80',
            'https://images.unsplash.com/photo-1478720568477-152d9b164e26?w=800&q=80',
          ],
        ),
      ],
    ),
    const Manga(
      id: 'mg2',
      title: 'Iron Folklore',
      description:
          'Tales from a world where myth and machine coexist — ancient gods pilot mechs and shamans debug code.',
      coverUrl:
          'https://images.unsplash.com/photo-1518709268805-4e9042af2176?w=400&q=80',
      author: 'Rae Tomoko',
      genres: ['Mecha', 'Fantasy', 'Shonen'],
      chapters: 143,
      rating: 8.7,
      chapterList: [
        MangaChapter(
          number: 1,
          title: 'The Waking Giant',
          pages: [
            'https://images.unsplash.com/photo-1518709268805-4e9042af2176?w=800&q=80',
            'https://images.unsplash.com/photo-1558618666-fcd25c85cd64?w=800&q=80',
          ],
        ),
      ],
    ),
    const Manga(
      id: 'mg3',
      title: 'Tidal Memory',
      description:
          'A marine biologist discovers an underwater civilization with no concept of the future — only an endless, layered past.',
      coverUrl:
          'https://images.unsplash.com/photo-1559827260-dc66d52bef19?w=400&q=80',
      author: 'Hana Ozu',
      genres: ['Sci-Fi', 'Slice of Life', 'Josei'],
      chapters: 52,
      rating: 9.0,
      chapterList: [
        MangaChapter(
          number: 1,
          title: 'Below Surface',
          pages: [
            'https://images.unsplash.com/photo-1559827260-dc66d52bef19?w=800&q=80',
            'https://images.unsplash.com/photo-1490750967868-88df5691cc7b?w=800&q=80',
          ],
        ),
      ],
    ),
    const Manga(
      id: 'mg4',
      title: 'Ember States',
      description:
          'Post-collapse. A group of artists preserves culture in a world that has forgotten art entirely.',
      coverUrl:
          'https://images.unsplash.com/photo-1541233349642-6e425fe6190e?w=400&q=80',
      author: 'Sol Drift',
      genres: ['Post-Apocalyptic', 'Drama'],
      chapters: 31,
      rating: 8.4,
      chapterList: [
        MangaChapter(
          number: 1,
          title: 'Ash and Canvas',
          pages: [
            'https://images.unsplash.com/photo-1541233349642-6e425fe6190e?w=800&q=80',
          ],
        ),
      ],
    ),
  ];

  static const List<YouTubeVideo> youtubeVideos = [
    YouTubeVideo(
      id: 'yt1',
      title: 'How Film Noir Defined Modern Cinema',
      channel: 'Frames & Form',
      thumbnailUrl:
          'https://images.unsplash.com/photo-1485846234645-a62644f84728?w=480&q=80',
      duration: '18:42',
      views: '1.2M views',
      uploadedAgo: '3 weeks ago',
    ),
    YouTubeVideo(
      id: 'yt2',
      title: 'The Sound Design of Blade Runner 2049',
      channel: 'Audio Architecture',
      thumbnailUrl:
          'https://images.unsplash.com/photo-1535016120720-40c646be5580?w=480&q=80',
      duration: '24:11',
      views: '847K views',
      uploadedAgo: '1 month ago',
    ),
    YouTubeVideo(
      id: 'yt3',
      title: 'Studio Ghibli and the Art of Stillness',
      channel: 'Animated Thought',
      thumbnailUrl:
          'https://images.unsplash.com/photo-1614267157481-ca2b81ac6fcc?w=480&q=80',
      duration: '31:05',
      views: '3.4M views',
      uploadedAgo: '2 months ago',
    ),
    YouTubeVideo(
      id: 'yt4',
      title: 'Why Manga Panels Are a Masterclass in Composition',
      channel: 'Ink and Frame',
      thumbnailUrl:
          'https://images.unsplash.com/photo-1578632767115-351597cf2477?w=480&q=80',
      duration: '22:37',
      views: '612K views',
      uploadedAgo: '5 days ago',
    ),
  ];

  static const List<ContinueWatching> continueWatching = [
    ContinueWatching(
      id: 'cw1',
      title: 'Obsidian Dusk',
      imageUrl:
          'https://images.unsplash.com/photo-1536440136628-849c177e76a1?w=400&q=80',
      progress: 0.42,
      type: 'Movie',
      subtitle: '52 min remaining',
    ),
    ContinueWatching(
      id: 'cw2',
      title: 'Riftborn',
      imageUrl:
          'https://images.unsplash.com/photo-1578632767115-351597cf2477?w=400&q=80',
      progress: 0.75,
      type: 'Anime',
      subtitle: 'Ep 14 - The Crossing',
    ),
    ContinueWatching(
      id: 'cw3',
      title: 'Pale Meridian',
      imageUrl:
          'https://images.unsplash.com/photo-1446776811953-b23d57bd21aa?w=400&q=80',
      progress: 0.15,
      type: 'Movie',
      subtitle: '1h 38min remaining',
    ),
  ];

  static const String featuredTitle = 'Riftborn';
  static const String featuredDescription =
      'In a fractured world where dimensions overlap, one girl\'s journey will determine the fate of everything — and everyone — between the rifts.';
  static const String featuredBackdrop =
      'https://images.unsplash.com/photo-1578632767115-351597cf2477?w=1200&q=80';
}
