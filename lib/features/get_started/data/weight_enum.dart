enum Weight {
  kg,
  lb,
}

extension MyHeight on Weight {
  String get name {
    switch (this) {
      case Weight.kg:
        return 'Kg';
      case Weight.lb:
        return 'Lb';
      default:
        return '';
    }
  }
}
