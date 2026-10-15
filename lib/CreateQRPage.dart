
import 'package:flutter/material.dart';

class CreateQRPage extends StatefulWidget {
  const CreateQRPage({super.key});

  @override
  State<CreateQRPage> createState() => _CreateQRPageState();
}

class _CreateQRPageState extends State<CreateQRPage> {
  final Color purple = const Color(0xFF5946EF);
  final Color background = const Color(0xFFF7F7FC);

  String selectedType = 'URL';

  final List<Map<String, dynamic>> qrTypes = [
    {'title': 'Text', 'icon': Icons.notes_rounded},
    {'title': 'URL', 'icon': Icons.language_rounded},
    {'title': 'Wi-Fi', 'icon': Icons.wifi_rounded},
    {'title': 'Contact', 'icon': Icons.person_outline_rounded},
    {'title': 'Email', 'icon': Icons.mail_outline_rounded},
    {'title': 'Phone', 'icon': Icons.phone_outlined},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(22, 16, 22, 22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Material(
                    color: Colors.white,
                    shape: const CircleBorder(),
                    child: InkWell(
                      customBorder: const CircleBorder(),
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        width: 54,
                        height: 54,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: const Color(0xFFE9E9F1),
                          ),
                        ),
                        child: const Icon(
                          Icons.arrow_back_ios_new_rounded,
                          size: 19,
                          color: Color(0xFF19191D),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  const Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(top: 5),
                      child: Text(
                        'Generate\nQR',
                        style: TextStyle(
                          fontSize: 27,
                          height: 1.12,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF19191D),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 28),

              const Text(
                'Choose QR Type',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF19191D),
                ),
              ),

              const SizedBox(height: 7),

              const Text(
                'Pick a type to create your code',
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF898996),
                ),
              ),

              const SizedBox(height: 26),

              // QR Type Cards
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: qrTypes.length,
                gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 1.12,
                ),
                itemBuilder: (context, index) {
                  final item = qrTypes[index];
                  final String title = item['title'] as String;
                  final IconData icon = item['icon'] as IconData;
                  final bool isSelected = selectedType == title;

                  return InkWell(
                    borderRadius: BorderRadius.circular(26),
                    onTap: () {
                      setState(() {
                        selectedType = title;
                      });
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 180),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(26),
                        border: Border.all(
                          color: isSelected
                              ? purple
                              : const Color(0xFFE9E9F1),
                          width: isSelected ? 2 : 1.3,
                        ),
                        boxShadow: isSelected
                            ? [
                          BoxShadow(
                            color: purple.withOpacity(0.06),
                            blurRadius: 12,
                            offset: const Offset(0, 5),
                          ),
                        ]
                            : [],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Smaller icon box
                          Container(
                            width: 62,
                            height: 62,
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? purple
                                  : const Color(0xFFF0ECFF),
                              borderRadius: BorderRadius.circular(19),
                            ),
                            child: Icon(
                              icon,
                              size: 26,
                              color: isSelected
                                  ? Colors.white
                                  : purple,
                            ),
                          ),

                          const SizedBox(height: 11),

                          Text(
                            title,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w700,
                              color: isSelected
                                  ? purple
                                  : const Color(0xFF19191D),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
