import 'package:step_counter/features/weight_and_bmi/models/body_zone_model.dart';
import 'package:step_counter/utils/constants.dart';

enum BodyMass {
  underweight,
  normal,
  overweight,
  obese,
  extremelyObese,
}

extension MyDuration on BodyMass {
  String get name {
    switch (this) {
      case BodyMass.underweight:
        return 'Under Weight';
      case BodyMass.normal:
        return 'Normal';
      case BodyMass.overweight:
        return 'Over Weight';
      case BodyMass.obese:
        return 'Obese';
      case BodyMass.extremelyObese:
        return 'Extremely Obese';
      default:
        return '';
    }
  }
}

extension DurationEnum on String {
  BodyMass get bodyMass {
    switch (this) {
      case 'Under Weight':
        return BodyMass.underweight;
      case 'Normal':
        return BodyMass.normal;
      case 'Over Weight':
        return BodyMass.overweight;
      case 'Obese':
        return BodyMass.obese;
      case 'Extremely Obese':
        return BodyMass.extremelyObese;
      default:
        return BodyMass.normal;
    }
  }
}

List<BodyZoneModel> get bodyZonesData => [
      BodyZoneModel(
        image: underWeight,
        selectedImage: selectUnderWeight,
        minBodyMass: 0.0,
        maxBodyMass: 18.5,
        bodyMass: BodyMass.underweight,
      ),
      BodyZoneModel(
        image: normal,
        selectedImage: selectNormal,
        minBodyMass: 18.5,
        maxBodyMass: 24.5,
        bodyMass: BodyMass.normal,
      ),
      BodyZoneModel(
        image: overWeight,
        selectedImage: selectOverWeight,
        minBodyMass: 24.5,
        maxBodyMass: 29.5,
        bodyMass: BodyMass.overweight,
      ),
      BodyZoneModel(
        image: obese,
        selectedImage: selectObese,
        minBodyMass: 29.5,
        maxBodyMass: 34.5,
        bodyMass: BodyMass.obese,
      ),
      BodyZoneModel(
        image: extremelyObese,
        selectedImage: selectExtremelyObese,
        minBodyMass: 34.5,
        maxBodyMass: 100,
        bodyMass: BodyMass.extremelyObese,
      ),
    ];
