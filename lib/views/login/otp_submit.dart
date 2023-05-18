import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:login_ui_api_task/services/api_services.dart';
import 'package:login_ui_api_task/ui/theme/container.dart';
import 'package:login_ui_api_task/ui/theme/text.dart';
import 'package:login_ui_api_task/ui/widgets/progress_circle.dart';
import 'package:login_ui_api_task/utils/assets_names.dart';
import 'package:login_ui_api_task/utils/design_colors.dart';
import 'package:login_ui_api_task/views/home/home.dart';
import 'package:login_ui_api_task/views/settings/account_form.dart';

class OTPScreen extends StatefulWidget {
  const OTPScreen({super.key, required this.phoneNumber});
  final String phoneNumber;
  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  List<TextEditingController> textEditingController = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];
  StreamController<int> timerStreamController = StreamController<int>();
  Timer? timer;
  final formKey = GlobalKey<FormState>();
  bool isloading = false;
  void startTimer() {
    int timeLeft = 60;
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (timeLeft == 0) {
        timer.cancel();
      } else {
        timeLeft--;
        timerStreamController.add(timeLeft);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    super.dispose();
    timer!.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: SizedBox(
          height: 48,
          width: double.infinity,
          child: FloatingActionButton.extended(
              backgroundColor: DesignColor.prepPruple,
              onPressed: () async {
                if (formKey.currentState!.validate()) {
                  setState(() => isloading = true);
                  await ApiAccess()
                      .otpVerify(
                          phone: widget.phoneNumber,
                          code: textEditingController
                              .map((e) => e.text)
                              .toList()
                              .join()
                              .toString())
                      .then((value) {
                    if (value != null && value['status']) {
                      if (value['profile_exists']) {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HomeScreen(),
                          ),
                          (route) => false,
                        );
                      } else {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AccountForm(),
                          ),
                          (route) => false,
                        );
                      }
                    } else {
                      setState(() => isloading = false);
                    }
                  });
                }
              },
              elevation: 1,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4)),
              label: isloading
                  ? const DesignProgress(size: 18, color: Colors.white)
                  : const DesignText(
                      "Verify",
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: 600,
                    )),
        ),
      ),
      body: StreamBuilder<int>(
          stream: timerStreamController.stream,
          builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
            return Form(
              key: formKey,
              child: Padding(
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
                      'Enter your OTP',
                      fontSize: 20,
                      fontWeight: 600,
                    ),
                    const SizedBox(height: 10),
                    DesignText(
                      'OTP has been sent to +91${widget.phoneNumber}',
                      fontSize: 14,
                      fontWeight: 400,
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(
                        6,
                        (index) => OtpInput(
                          textEditingController: textEditingController[index],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: snapshot.data == 0
                              ? () async {
                                  if (snapshot.data! < 1) {
                                    startTimer();
                                  }
                                }
                              : null,
                          child: const DesignText(
                            'Resend OTP',
                            fontSize: 14,
                            fontWeight: 400,
                          ),
                        ),
                        DesignText(
                          (snapshot.data ?? 0).toString(),
                          fontSize: 14,
                          fontWeight: 400,
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            );
          }),
    );
  }
}

class OtpInput extends StatefulWidget {
  const OtpInput({
    Key? key,
    required this.textEditingController,
  }) : super(key: key);

  final TextEditingController textEditingController;
  @override
  State<OtpInput> createState() => _OtpInputState();
}

class _OtpInputState extends State<OtpInput> {
  late bool _isEmpty;
  late FocusNode _focusNode;
  @override
  void initState() {
    super.initState();
    _isEmpty = widget.textEditingController.text.isEmpty;
    _focusNode = FocusNode();
    widget.textEditingController.addListener(_handleTextChanged);
  }

  void _handleTextChanged() {
    setState(() {
      _isEmpty = widget.textEditingController.text.isEmpty;
    });
  }

  void _handleBackspace(RawKeyEvent event) {
    if (_isEmpty && event.logicalKey == LogicalKeyboardKey.backspace) {
      _focusNode.requestFocus();
      FocusScope.of(context).previousFocus();
    }
  }

  @override
  void dispose() {
    widget.textEditingController.removeListener(_handleTextChanged);
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 40,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2),
        child: RawKeyboardListener(
          focusNode: _focusNode,
          onKey: _handleBackspace,
          child: TextFormField(
            controller: widget.textEditingController,
            onChanged: (value) {
              if (value.length == 1) {
                _focusNode.nextFocus();
                FocusScope.of(context).nextFocus();
              } else {
                _focusNode.nextFocus();
                FocusScope.of(context).previousFocus();
              }
            },
            onTapOutside: (event) {
              final currentFocus = FocusScope.of(context);
              if (currentFocus.focusedChild != null) {
                currentFocus.focusedChild!.unfocus();
              }
            },
            onFieldSubmitted: (_) {
              _focusNode.nextFocus();
              FocusScope.of(context).nextFocus();
            },
            onEditingComplete: () {
              _focusNode.nextFocus();
              FocusScope.of(context).nextFocus();
            },
            validator: (val) {
              if (val == null || val.isEmpty) {
                return "";
              }
              return null;
            },
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            textAlign: TextAlign.center,
            decoration: const InputDecoration(
              filled: true,
              errorStyle: TextStyle(height: 0, color: Colors.transparent),
              isDense: true,
              fillColor: Colors.transparent,
              // hintStyle: TextStyle(color: DesignColor.darkGrey),
              floatingLabelBehavior: FloatingLabelBehavior.auto,
              contentPadding: EdgeInsets.fromLTRB(12, 12, 12, 12),
              focusedBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: DesignColor.prepPruple, width: 1.5),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: DesignColor.prepPruple, width: 1.5),
              ),
              border: OutlineInputBorder(
                borderSide:
                    BorderSide(color: DesignColor.prepPruple, width: 1.5),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red, width: 1.0),
              ),
            ),
            keyboardType: TextInputType.number,
            inputFormatters: [
              LengthLimitingTextInputFormatter(1),
              FilteringTextInputFormatter.digitsOnly,
            ],
          ),
        ),
      ),
    );
  }
}
