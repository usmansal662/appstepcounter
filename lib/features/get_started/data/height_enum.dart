enum Height {
  cm,
  ft,
}

extension MyHeight on Height {
  String get name {
    switch (this) {
      case Height.cm:
        return 'Cm';
      case Height.ft:
        return 'Ft';
      default:
        return '';
    }
  }
}
