import 'package:tablebooking_flutter/account_view.dart';
import 'package:tablebooking_flutter/bookings/bookings_view.dart';
import 'package:tablebooking_flutter/navigation.dart';
import 'package:go_router/go_router.dart';
import 'package:tablebooking_flutter/restaurant/restaurant_view.dart';
import 'package:tablebooking_flutter/restaurant/book/book_view.dart';
import 'package:tablebooking_flutter/search/search.dart';
import 'package:flutter/material.dart';

final router = GoRouter(
  initialLocation: "/account",
  routes: [
    ShellRoute(
      builder: (BuildContext context, GoRouterState state, Widget child) {
        return Navigation(
          child: child,
        );
      },
      routes: <RouteBase>[
        GoRoute(
          path: '/search',
          builder: (context, state) => const Search(),
        ),
        GoRoute(
          path: '/bookings',
          builder: (context, state) => const BookingsView(),
        ),
        GoRoute(
            path: '/account', builder: (context, state) => const AccountView()),
      ],
    ),
    GoRoute(
      path: '/restaurant/:restaurantId',
      builder: (context, state) =>
          RestaurantView(restaurantId: state.pathParameters['restaurantId']),
    ),
    GoRoute(
      path: '/booking/:restaurantId',
      builder: (context, state) =>
          BookView(restaurantId: state.pathParameters['restaurantId']),
    )
  ],
);
