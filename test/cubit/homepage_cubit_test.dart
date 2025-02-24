import 'package:bloc_test/bloc_test.dart';
import 'package:favmusic/cubits/homepage_cubit/homepage_cubit.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:favmusic/model/track.dart';
import 'package:favmusic/services/spotify_service.dart';

class MockSpotifyService extends Mock implements SpotifyService {}

void main() {
  late MockSpotifyService mockSpotifyService;

  final sampleTracks = [
    Track(
      name: 'Track 1',
      trackuri: 'uri1',
      imageUrl: 'image1.jpg',
      artistName: 'Artist 1',
    )
  ];

  setUpAll(() {
    registerFallbackValue(Track(
      name: 'dummy',
      trackuri: 'dummy',
      imageUrl: 'dummy',
      artistName: 'dummy',
    ));
  });

  setUp(() {
    mockSpotifyService = MockSpotifyService();
  });

  blocTest<HomepageCubit, HomepageState>(
    'emits HomepageIdle with data when initialized successfully',
    build: () {
      when(() => mockSpotifyService.getRecommendedTracks(isLimited: true))
          .thenAnswer((_) async => sampleTracks);
      when(() => mockSpotifyService.getUsersSavedEpisodes(isLimited: true))
          .thenAnswer((_) async => sampleTracks);
      when(() => mockSpotifyService.getUsersSavedTracks(isLimited: true))
          .thenAnswer((_) async => sampleTracks);
      return HomepageCubit(mockSpotifyService);
    },
    act: (cubit) => cubit.initializePage(),
    expect: () => [
      isA<HomepageIdle>()
        ..having((s) => s.recommendedTracks, 'recommendedTracks', sampleTracks)
        ..having(
            (s) => s.usersSavedEpisodes, 'usersSavedEpisodes', sampleTracks)
        ..having((s) => s.usersSavedTracks, 'usersSavedTracks', sampleTracks)
    ],
  );

  blocTest<HomepageCubit, HomepageState>(
    'emits error when getRecommendedTracks fails',
    build: () {
      when(() => mockSpotifyService.getRecommendedTracks(isLimited: true))
          .thenThrow(Exception('Failed'));
      when(() => mockSpotifyService.getUsersSavedEpisodes(isLimited: true))
          .thenAnswer((_) async => sampleTracks);
      when(() => mockSpotifyService.getUsersSavedTracks(isLimited: true))
          .thenAnswer((_) async => sampleTracks);
      return HomepageCubit(mockSpotifyService);
    },
    act: (cubit) => cubit.initializePage(),
    errors: () => [isA<Exception>()],
  );
}
