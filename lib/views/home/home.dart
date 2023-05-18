import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:login_ui_api_task/services/token_handler.dart';
import 'package:login_ui_api_task/ui/theme/container.dart';
import 'package:login_ui_api_task/ui/theme/text.dart';
import 'package:login_ui_api_task/utils/constants.dart';
import 'package:login_ui_api_task/utils/design_colors.dart';
import 'package:login_ui_api_task/views/login/login.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: 240,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: DesignColor.prepPruple,
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(40),
              ),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(14, 14, 14, 6),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          TokenHandler.resetJwt().then((value) {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginScreen(),
                              ),
                              (route) => false,
                            );
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: CircleAvatar(
                            radius: 20,
                            backgroundColor: Colors.white,
                            backgroundImage: const NetworkImage(Constants
                                .profileLink), // Replace with your image URL
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.white,
                                  width: 1,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            FontAwesomeIcons.bell,
                            color: Colors.white,
                          ))
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(14, 10, 14, 0),
                      child: Column(
                        children: [
                          const DesignText(
                            'Available balance',
                            fontSize: 12,
                            fontWeight: 500,
                            color: Colors.white,
                          ),
                          const SizedBox(height: 6),
                          const DesignText(
                            'AED 16,846.25',
                            fontSize: 24,
                            fontWeight: 600,
                            color: Colors.white,
                          ),
                          const SizedBox(height: 20),
                          DesignContainer(
                              child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              MaterialIconButton(
                                  onPressed: () {},
                                  text: 'Add Money',
                                  color:
                                      DesignColor.prepPruple.withOpacity(0.2),
                                  icon: const Icon(
                                    FontAwesomeIcons.plus,
                                    size: 18,
                                    color: DesignColor.prepPruple,
                                  )),
                              MaterialIconButton(
                                  onPressed: () {},
                                  text: 'Send Money',
                                  color: DesignColor.orange.withOpacity(0.2),
                                  icon: const Icon(
                                    FontAwesomeIcons.arrowsUpDown,
                                    size: 18,
                                    color: DesignColor.orange,
                                  )),
                              MaterialIconButton(
                                  onPressed: () {},
                                  text: 'Pay Money',
                                  color: DesignColor.grey.withOpacity(0.2),
                                  icon: const Icon(
                                    Icons.north_east,
                                    color: DesignColor.grey,
                                  )),
                            ],
                          )),
                          const SizedBox(height: 10),
                          IntrinsicHeight(
                            child: DesignContainer(
                                child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Material(
                                      borderRadius: BorderRadius.circular(60),
                                      color: DesignColor.prepPruple,
                                      clipBehavior: Clip.antiAlias,
                                      child: IconButton(
                                          alignment: Alignment.center,
                                          onPressed: () {},
                                          icon: const FaIcon(
                                            FontAwesomeIcons.magnifyingGlass,
                                            // size: 18,
                                            color: Colors.white,
                                          )),
                                    ),
                                    const SizedBox(height: 4),
                                    const DesignText(
                                      'Search',
                                      fontSize: 12,
                                      fontWeight: 600,
                                    )
                                  ],
                                ),
                                VerticalDivider(
                                  color:
                                      DesignColor.prepPruple.withOpacity(0.1),
                                  thickness: 2,
                                ),
                                Expanded(
                                  child: SizedBox(
                                    height: 80,
                                    child: ListView.builder(
                                      itemCount: 10,
                                      scrollDirection: Axis.horizontal,
                                      shrinkWrap: true,
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding:
                                              const EdgeInsets.only(right: 6),
                                          child: Column(
                                            children: [
                                              CircleAvatar(
                                                radius: 30,
                                                backgroundColor: Colors.white,
                                                backgroundImage:
                                                    const NetworkImage(Constants
                                                        .profileLink), // Replace with your image URL
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    border: Border.all(
                                                      color: Colors.white,
                                                      width: 1,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(height: 4),
                                              DesignText(
                                                'User ${index + 1}',
                                                fontSize: 12,
                                                fontWeight: 600,
                                              )
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                )
                              ],
                            )),
                          ),
                          const SizedBox(height: 10),
                          DesignContainer(
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: const [
                                    DesignText(
                                      'Transactions',
                                      fontSize: 16,
                                      fontWeight: 600,
                                    ),
                                    DesignText(
                                      'See all',
                                      fontSize: 16,
                                      fontWeight: 600,
                                      color: DesignColor.prepPruple,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: 60,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 12),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Material(
                                                borderRadius:
                                                    BorderRadius.circular(60),
                                                color: DesignColor.prepPruple
                                                    .withOpacity(0.15),
                                                clipBehavior: Clip.antiAlias,
                                                child: IconButton(
                                                    alignment: Alignment.center,
                                                    onPressed: () {},
                                                    icon: const FaIcon(
                                                      FontAwesomeIcons.house,
                                                      size: 18,
                                                      color: DesignColor
                                                          .prepPruple,
                                                    )),
                                              ),
                                              const SizedBox(width: 6),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  DesignText(
                                                    'Home ${index + 1}',
                                                    fontSize: 14,
                                                    fontWeight: 600,
                                                  ),
                                                  DesignText(
                                                    '25 Sept 2022',
                                                    fontSize: 12,
                                                    fontWeight: 600,
                                                    color: Colors.grey
                                                        .withOpacity(0.8),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: const [
                                              DesignText(
                                                'AED 450',
                                                fontSize: 14,
                                                fontWeight: 600,
                                              ),
                                              Icon(
                                                Icons.north_east,
                                                color: Colors.red,
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MaterialIconButton extends StatelessWidget {
  const MaterialIconButton({
    super.key,
    required this.icon,
    this.color,
    this.onPressed,
    required this.text,
  });
  final Widget icon;
  final Color? color;
  final Function()? onPressed;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Material(
          borderRadius: BorderRadius.circular(60),
          color: color,
          clipBehavior: Clip.antiAlias,
          child: SizedBox(
            width: 80,
            height: 40,
            child: IconButton(onPressed: onPressed, icon: icon),
          ),
        ),
        const SizedBox(height: 4),
        DesignText(
          text,
          fontSize: 14,
          fontWeight: 600,
        )
      ],
    );
  }
}
