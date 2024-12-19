enum SortingMethod { trending, rating, distance }

enum Price { low, medium, high }

extension PriceExtension on Price {
  String get displayName {
    switch (this) {
      case Price.low:
        return '\$';
      case Price.medium:
        return '\$\$';
      case Price.high:
        return '\$\$\$';
    }
  }
}

class SearchOptions {
  SortingMethod sortingMethod;
  Set<Price> price;
  double distance;

  SearchOptions(
      {required this.sortingMethod,
      required this.price,
      required this.distance});

  factory SearchOptions.defaultOptions() {
    return SearchOptions(
        sortingMethod: SortingMethod.trending,
        price: <Price>{Price.low, Price.medium, Price.high},
        distance: 10.0);
  }

  SearchOptions copyWith() {
    return SearchOptions(
        sortingMethod: sortingMethod, price: price, distance: distance);
  }
}
