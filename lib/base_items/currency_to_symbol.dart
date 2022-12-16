String name(String? currency) {
  switch (currency) {
    case 'GBP':
      return '£';
    case 'USD':
      return '\$';
    case null:
      return '';
    default:
      return '€';
  }
}
