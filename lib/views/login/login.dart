import 'package:flutter/material.dart';
import 'package:login_ui_api_task/services/api_services.dart';
import 'package:login_ui_api_task/ui/theme/buttons.dart';
import 'package:login_ui_api_task/ui/theme/container.dart';
import 'package:login_ui_api_task/ui/theme/text.dart';
import 'package:login_ui_api_task/ui/widgets/progress_circle.dart';
import 'package:login_ui_api_task/utils/assets_names.dart';
import 'package:login_ui_api_task/utils/design_colors.dart';
import 'package:login_ui_api_task/views/login/otp_submit.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final phoneNo = TextEditingController();
  bool isloading = false;
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.fromLTRB(16, 60, 16, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30),
              DesignContainer(
                clipBehavior: Clip.antiAlias,
                borderRadius: BorderRadius.circular(60),
                allPadding: 0,
                child: Image.asset(
                  AssetsName.imgFlutter,
                  height: 60,
                  width: 60,
                ),
              ),
              const SizedBox(height: 20),
              const DesignText(
                'Get Started!',
                fontSize: 20,
                fontWeight: 600,
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: phoneNo,
                validator: (val) {
                  if (val == null || val.isEmpty) {
                    return "Field Can't be empty";
                  } else if (val.length < 10) {
                    return "Mobile number must be 10 in digit";
                  }
                  return null;
                },
                onTapOutside: (event) {
                  final currentFocus = FocusScope.of(context);
                  if (currentFocus.focusedChild != null) {
                    currentFocus.focusedChild!.unfocus();
                  }
                },
                decoration: const InputDecoration(
                  hintText: 'Enter Your Mobile no',
                  filled: true,
                  isDense: true,
                  fillColor: Colors.transparent,
                  prefixIcon: Padding(
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 8),
                    child: Text('+91'),
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  contentPadding: EdgeInsets.all(16),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: DesignColor.prepPruple, width: 1),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: DesignColor.prepPruple, width: 1),
                  ),
                  border: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: DesignColor.prepPruple, width: 1),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red, width: 1),
                  ),
                ),
                textCapitalization: TextCapitalization.sentences,
                keyboardType: TextInputType.number,
                maxLength: 10,
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 48,
                width: double.infinity,
                child: DesignButtons(
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      setState(() => isloading = true);
                      await ApiAccess()
                          .attemptLogIn(phone: phoneNo.text)
                          .then((value) {
                        if (value) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    OTPScreen(phoneNumber: phoneNo.text),
                              ));
                        } else {
                          setState(() => isloading = false);
                        }
                      });
                    }
                  },
                  textLabel: 'Continue',
                  isTappedNotifier: ValueNotifier(false),
                  colorText: Colors.white,
                  fontSize: 14,
                  fontWeight: 600,
                  color: DesignColor.prepPruple,
                  child: isloading
                      ? const DesignProgress(size: 18, color: Colors.white)
                      : const DesignText(
                          "Continue",
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: 600,
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
