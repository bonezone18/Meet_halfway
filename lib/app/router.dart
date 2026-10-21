import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:meet_halfway/features/meetup/presentation/home_screen.dart';
import 'package:meet_halfway/features/places/presentation/results_screen.dart';
import 'package:meet_halfway/features/places/presentation/venue_details_screen.dart';

abstract final class Routes {
  static const home = '/';
  static const results = '/results';
  static String venue(String id) => '/results/venue/$id';
}

final routerProvider = Provider<GoRouter>((ref) {
  final router = GoRouter(
    routes: [
      GoRoute(
        path: Routes.home,
        builder: (context, state) => const HomeScreen(),
        routes: [
          GoRoute(
            path: 'results',
            builder: (context, state) => const ResultsScreen(),
            routes: [
              GoRoute(
                path: 'venue/:id',
                builder: (context, state) =>
                    VenueDetailsScreen(venueId: state.pathParameters['id']!),
              ),
            ],
          ),
        ],
      ),
    ],
  );
  ref.onDispose(router.dispose);
  return router;
});
