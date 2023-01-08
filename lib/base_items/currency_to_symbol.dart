String name(String? currency) {
  switch (currency) {
    case 'GBP':
      return '£';
    case 'USD':
    case '':
      return '\$';
    case null:
    default:
      return '€';
  }
}
