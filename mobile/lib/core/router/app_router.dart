import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../auth/auth_session.dart';
import '../../features/admin/admin_dashboard_screen.dart';
import '../../features/admin/articles/admin_articles_screen.dart';
import '../../features/admin/contacts/admin_contacts_screen.dart';
import '../../features/admin/districts/admin_districts_screen.dart';
import '../../features/admin/media/admin_media_screen.dart';
import '../../features/admin/news/admin_news_screen.dart';
import '../../features/admin/statistics/admin_statistics_screen.dart';
import '../../features/articles/articles_screen.dart';
import '../../features/contacts/contacts_screen.dart';
import '../../features/home/home_screen.dart';
import '../../features/news/news_screen.dart';
import '../../features/settings/settings_screen.dart';
import '../../features/splash/splash_screen.dart';
import '../../features/statistics/statistics_screen.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final auth = ref.watch(authSessionProvider);
  final isLoggedIn = auth.maybeWhen(
    data: (session) => session.isLoggedIn,
    orElse: () => false,
  );

  return GoRouter(
    initialLocation: '/splash',
    redirect: (context, state) {
      final path = state.uri.path;
      if (path.startsWith('/admin') && !isLoggedIn) {
        return '/settings';
      }
      return null;
    },
    routes: [
      GoRoute(
        path: '/splash',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: '/settings',
        builder: (context, state) => const SettingsScreen(),
      ),
      GoRoute(
        path: '/articles',
        builder: (context, state) => const ArticlesScreen(),
        routes: [
          GoRoute(
            path: ':id',
            builder: (context, state) {
              final id = int.parse(state.pathParameters['id']!);
              return ArticleDetailScreen(id: id);
            },
          ),
        ],
      ),
      GoRoute(
        path: '/news',
        builder: (context, state) => const NewsScreen(),
        routes: [
          GoRoute(
            path: ':id',
            builder: (context, state) {
              final id = int.parse(state.pathParameters['id']!);
              return NewsDetailScreen(id: id);
            },
          ),
        ],
      ),
      GoRoute(
        path: '/statistics',
        builder: (context, state) => const StatisticsScreen(),
      ),
      GoRoute(
        path: '/contacts',
        builder: (context, state) => const ContactsScreen(),
      ),
      GoRoute(
        path: '/admin',
        builder: (context, state) => const AdminDashboardScreen(),
        routes: [
          GoRoute(
            path: 'articles',
            builder: (context, state) => const AdminArticlesScreen(),
            routes: [
              GoRoute(
                path: 'new',
                builder: (context, state) => const AdminArticleFormScreen(),
              ),
              GoRoute(
                path: ':id',
                builder: (context, state) {
                  final id = int.parse(state.pathParameters['id']!);
                  return AdminArticleFormScreen(id: id);
                },
              ),
            ],
          ),
          GoRoute(
            path: 'news',
            builder: (context, state) => const AdminNewsScreen(),
            routes: [
              GoRoute(
                path: 'new',
                builder: (context, state) => const AdminNewsFormScreen(),
              ),
              GoRoute(
                path: ':id',
                builder: (context, state) {
                  final id = int.parse(state.pathParameters['id']!);
                  return AdminNewsFormScreen(id: id);
                },
              ),
            ],
          ),
          GoRoute(
            path: 'districts',
            builder: (context, state) => const AdminDistrictsScreen(),
            routes: [
              GoRoute(
                path: 'new',
                builder: (context, state) => const AdminDistrictFormScreen(),
              ),
              GoRoute(
                path: ':id',
                builder: (context, state) {
                  final id = int.parse(state.pathParameters['id']!);
                  return AdminDistrictFormScreen(id: id);
                },
              ),
            ],
          ),
          GoRoute(
            path: 'statistics',
            builder: (context, state) => const AdminStatisticsScreen(),
            routes: [
              GoRoute(
                path: 'new',
                builder: (context, state) => const AdminStatisticFormScreen(),
              ),
              GoRoute(
                path: ':id',
                builder: (context, state) {
                  final id = int.parse(state.pathParameters['id']!);
                  return AdminStatisticFormScreen(id: id);
                },
              ),
            ],
          ),
          GoRoute(
            path: 'contacts',
            builder: (context, state) => const AdminContactsScreen(),
            routes: [
              GoRoute(
                path: 'new',
                builder: (context, state) => const AdminContactFormScreen(),
              ),
              GoRoute(
                path: ':id',
                builder: (context, state) {
                  final id = int.parse(state.pathParameters['id']!);
                  return AdminContactFormScreen(id: id);
                },
              ),
            ],
          ),
          GoRoute(
            path: 'media',
            builder: (context, state) => const AdminMediaScreen(),
          ),
        ],
      ),
    ],
  );
});
