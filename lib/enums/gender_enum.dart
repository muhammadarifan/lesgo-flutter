enum GenderEnum {
  male,
  female;

  String get displayName {
    switch (this) {
      case GenderEnum.male:
        return 'Male';
      case GenderEnum.female:
        return 'Female';
    }
  }

  static GenderEnum fromString(String value) {
    switch (value.toLowerCase()) {
      case 'male':
        return GenderEnum.male;
      case 'female':
        return GenderEnum.female;
      default:
        return GenderEnum.male; // Default to male if unknown value
    }
  }
}
