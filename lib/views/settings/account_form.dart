import 'package:flutter/material.dart';
import 'package:login_ui_api_task/services/api_services.dart';
import 'package:login_ui_api_task/services/token_handler.dart';
import 'package:login_ui_api_task/ui/custom/custom_text_form.dart';
import 'package:login_ui_api_task/ui/theme/buttons.dart';
import 'package:login_ui_api_task/ui/theme/text.dart';
import 'package:login_ui_api_task/ui/widgets/progress_circle.dart';
import 'package:login_ui_api_task/utils/design_colors.dart';
import 'package:login_ui_api_task/views/home/home.dart';

class AccountForm extends StatefulWidget {
  const AccountForm({super.key});

  @override
  State<AccountForm> createState() => _AccountFormState();
}

class _AccountFormState extends State<AccountForm> {
  final name = TextEditingController();
  final email = TextEditingController();
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
              const DesignText(
                'Get Started!',
                fontSize: 20,
                fontWeight: 600,
              ),
              const SizedBox(height: 10),
              const DesignText(
                'Looks like you are new here. Tell us a bit about yourself.',
                fontSize: 14,
                fontWeight: 500,
              ),
              const SizedBox(height: 20),
              DesignFormField(controller: name, hintText: 'Name'),
              const SizedBox(height: 20),
              DesignFormField(controller: email, hintText: 'Email'),
              const SizedBox(height: 20),
              SizedBox(
                height: 48,
                width: double.infinity,
                child: DesignButtons(
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      setState(() => isloading = true);
                      await ApiAccess()
                          .profilesubmit(
                              email: email.text.trim(), name: name.text.trim())
                          .then((value) {
                        if (value) {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const HomeScreen(),
                            ),
                            (route) => false,
                          );
                        } else {
                          setState(() => isloading = false);
                        }
                      });
                    }
                  },
                  textLabel: 'Submit',
                  isTappedNotifier: ValueNotifier(false),
                  colorText: Colors.white,
                  fontSize: 14,
                  fontWeight: 600,
                  color: DesignColor.prepPruple,
                  child: isloading
                      ? const DesignProgress(size: 18, color: Colors.white)
                      : const DesignText(
                          "Submit",
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
