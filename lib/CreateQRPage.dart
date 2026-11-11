
import 'package:flutter/material.dart';
import 'QRInputPage.dart';

class CreateQRPage extends StatefulWidget {
  const CreateQRPage({super.key});

  @override
  State<CreateQRPage> createState() => _CreateQRPageState();
}

class _CreateQRPageState extends State<CreateQRPage> {
  final Color blue = const Color(0xFF2864E8);

  String selectedType = 'URL';

  Widget typeCard(String title, IconData icon) {
    bool isSelected = selectedType == title;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedType = title;
        });

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => QRInputPage(type: title),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? blue : Colors.grey.shade300,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 36,
              color: isSelected ? blue : Colors.grey,
            ),
            const SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: isSelected ? blue : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7FC),
      appBar: AppBar(
        title: const Text('Generate QR'),
        backgroundColor: const Color(0xFFF7F7FC),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Choose QR Type',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              'Pick a type to create your code',
              style: TextStyle(
                fontSize: 15,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: [
                  typeCard('Text', Icons.notes_rounded),
                  typeCard('URL', Icons.language_rounded),
                  typeCard('Wi-Fi', Icons.wifi_rounded),
                  typeCard('Contact', Icons.person_outline_rounded),
                  typeCard('Email', Icons.mail_outline_rounded),
                  typeCard('Phone', Icons.phone_outlined),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
