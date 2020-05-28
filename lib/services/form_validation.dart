import 'package:aventech_assignment/screens/login_screen.dart';
import 'package:aventech_assignment/services/authentication.dart';

class FormValidation {
  BaseAuth _auth = new Auth();

  bool validateAndSave(formKey) {
    final form = formKey.currentState;
    if (form.validate()) {
      //if you don't save the form , it returns null for both email and password
      form.save();
      return true;
    } else {
      return false;
    }
  }

  Future<String> validateAndSubmit(
      String email, String password, formKey, FormType _formType) async {
    if (validateAndSave(formKey)) {
      if (_formType == FormType.login) {
        String userId = await _auth.signInWithEmailAndPassword(email, password);
        print("Signed in as : $userId");

        return userId;
      } else {
        String userId =
            await _auth.createUserWithEmailAndPassword(email, password);
        print("Registered in as : $userId");
        return userId;
      }
    }
  }
}
