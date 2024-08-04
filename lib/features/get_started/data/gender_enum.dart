enum Gender {
  male,
  female,
  none,
}

extension MyGender on Gender {
  String get name {
    switch (this) {
      case Gender.male:
        return 'Male';
      case Gender.female:
        return 'Female';
      default:
        return '';
    }
  }
}

extension MyEnum on String {
  Gender get gender {
    switch (this) {
      case 'Male':
        return Gender.male;
      case 'Female':
        return Gender.female;
      default:
        return Gender.none;
    }
  }
}
