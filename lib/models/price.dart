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
      default:
        return 'Unknown';
    }
  }
}
