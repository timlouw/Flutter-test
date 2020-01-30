
class FormValidationService {
  String validateValue(String value, String pattern, bool isRequired, String error, String requiredError) {
    RegExp regex = new RegExp(pattern);
    if (isRequired) {
      if (value.isEmpty) {
        return requiredError;
      } else {
        if (!regex.hasMatch(value)) {
          return error;
        } else {
          return null;
        }
      }
    } else {
      if (!regex.hasMatch(value)) {
        return error;
      } else {
        return null;
      }
    }
  }
}