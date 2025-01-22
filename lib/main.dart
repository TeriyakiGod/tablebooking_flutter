import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tablebooking_flutter/providers/booking_provider.dart';
import 'package:tablebooking_flutter/providers/restaurant_provider.dart';
import 'router.dart';
import 'providers/auth_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final authProvider = AuthProvider();
  await authProvider.autoLogin();
  final restaurantProvider = RestaurantProvider();
  final bookingProvider = BookingProvider();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => authProvider),
        ChangeNotifierProvider(create: (_) => restaurantProvider),
        ChangeNotifierProvider(create: (_) => bookingProvider),
      ],
      child: const App(),
    ),
  );
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
            constraints: const BoxConstraints(maxWidth: 700),
            child: MaterialApp.router(
              theme: ThemeData(useMaterial3: true),
              darkTheme: ThemeData.dark(useMaterial3: true),
              themeMode: ThemeMode.dark,
              routerConfig: router,
            )));
  }
}
