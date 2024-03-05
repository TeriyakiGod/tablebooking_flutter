import 'package:flutter/material.dart';
import 'package:tablebooking_flutter/navigation.dart';
import 'package:go_router/go_router.dart';
import 'package:tablebooking_flutter/restaurant_view.dart';

void main() {
  runApp(const App());
}

final _router = GoRouter(
  initialLocation: "/",
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const Navigation(),
    ),
    GoRoute(
      path: '/restaurant/:restaurantId',
      builder: (context, state) =>
          RestaurantView(restaurantId: state.pathParameters['restaurantId']),
    ),
  ],
);

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData(useMaterial3: true),
      darkTheme: ThemeData.dark(useMaterial3: true),
      themeMode: ThemeMode.dark,
      routerConfig: _router,
    );
  }
}
