
import 'package:flutter/material.dart';

class QRInputPage extends StatefulWidget {
final String type;

const QRInputPage({
super.key,
required this.type,
});

@override
State<QRInputPage> createState() => _QRInputPageState();
}

class _QRInputPageState extends State<QRInputPage> {
final Color blue = const Color(0xFF2864E8);

final TextEditingController textController = TextEditingController();
final TextEditingController urlController = TextEditingController();
final TextEditingController wifiNameController = TextEditingController();
final TextEditingController wifiPasswordController = TextEditingController();
final TextEditingController nameController = TextEditingController();
final TextEditingController phoneController = TextEditingController();
final TextEditingController emailController = TextEditingController();
final TextEditingController subjectController = TextEditingController();
final TextEditingController messageController = TextEditingController();

String security = 'WPA';

@override
void dispose() {
textController.dispose();
urlController.dispose();
wifiNameController.dispose();
wifiPasswordController.dispose();
nameController.dispose();
phoneController.dispose();
emailController.dispose();
subjectController.dispose();
messageController.dispose();
super.dispose();
}

Widget inputField(
String label,
TextEditingController controller, {
String? hint,
int lines = 1,
TextInputType keyboardType = TextInputType.text,
}) {
return Padding(
padding: const EdgeInsets.only(bottom: 16),
child: TextField(
controller: controller,
maxLines: lines,
keyboardType: keyboardType,
decoration: InputDecoration(
labelText: label,
hintText: hint,
filled: true,
fillColor: Colors.white,
border: OutlineInputBorder(
borderRadius: BorderRadius.circular(14),
),
enabledBorder: OutlineInputBorder(
borderRadius: BorderRadius.circular(14),
borderSide: BorderSide(color: Colors.grey.shade300),
),
focusedBorder: OutlineInputBorder(
borderRadius: BorderRadius.circular(14),
borderSide: BorderSide(color: blue, width: 2),
),
),
),
);
}

List<Widget> getFields() {
switch (widget.type) {
case 'Text':
return [
inputField(
'Enter Text',
textController,
hint: 'Write something...',
lines: 4,
),
];

case 'URL':
return [
inputField(
'Website URL',
urlController,
hint: 'https://example.com',
keyboardType: TextInputType.url,
),
];

case 'Wi-Fi':
return [
inputField('Wi-Fi Name (SSID)', wifiNameController),
inputField('Wi-Fi Password', wifiPasswordController),
DropdownButtonFormField<String>(
value: security,
decoration: const InputDecoration(
labelText: 'Security Type',
border: OutlineInputBorder(),
),
items: const [
DropdownMenuItem(value: 'WPA', child: Text('WPA/WPA2')),
DropdownMenuItem(value: 'WEP', child: Text('WEP')),
DropdownMenuItem(value: 'nopass', child: Text('No Password')),
],
onChanged: (value) {
if (value != null) {
setState(() => security = value);
}
},
),
];

case 'Contact':
return [
inputField('Full Name', nameController),
inputField(
'Phone Number',
phoneController,
keyboardType: TextInputType.phone,
),
inputField(
'Email Address',
emailController,
keyboardType: TextInputType.emailAddress,
),
];

case 'Email':
return [
inputField(
'Email Address',
emailController,
keyboardType: TextInputType.emailAddress,
),
inputField('Subject', subjectController),
inputField('Message', messageController, lines: 3),
];

case 'Phone':
return [
inputField(
'Phone Number',
phoneController,
hint: 'Enter phone number',
keyboardType: TextInputType.phone,
),
];

default:
return [];
}
}

String getQRData() {
switch (widget.type) {
case 'Text':
return textController.text.trim();

case 'URL':
return urlController.text.trim();

case 'Wi-Fi':
return 'WIFI:T:$security;S:${wifiNameController.text.trim()};'
'P:${security == 'nopass' ? '' : wifiPasswordController.text};;';

case 'Contact':
return 'Name: ${nameController.text.trim()}\n'
'Phone: ${phoneController.text.trim()}\n'
'Email: ${emailController.text.trim()}';

case 'Email':
return 'mailto:${emailController.text.trim()}'
'?subject=${Uri.encodeComponent(subjectController.text.trim())}'
'&body=${Uri.encodeComponent(messageController.text.trim())}';

case 'Phone':
return 'tel:${phoneController.text.trim()}';

default:
return '';
}
}

void createQR() {
final data = getQRData();

if (data.trim().isEmpty) {
ScaffoldMessenger.of(context).showSnackBar(
const SnackBar(content: Text('Please enter the required details')),
);
return;
}

Navigator.push(
context,
MaterialPageRoute(
builder: (context) => QRPreviewPage(
type: widget.type,
data: data,
),
),
);
}

@override
Widget build(BuildContext context) {
return Scaffold(
backgroundColor: const Color(0xFFF7F7FC),
appBar: AppBar(
title: Text('Create ${widget.type} QR'),
backgroundColor: const Color(0xFFF7F7FC),
),
body: SingleChildScrollView(
padding: const EdgeInsets.all(20),
child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
Text(
'${widget.type} Details',
style: const TextStyle(
fontSize: 24,
fontWeight: FontWeight.bold,
),
),
const SizedBox(height: 8),
const Text(
'Enter the information for your QR code.',
style: TextStyle(fontSize: 15, color: Colors.grey),
),
const SizedBox(height: 25),
...getFields(),
const SizedBox(height: 12),
SizedBox(
width: double.infinity,
height: 54,
child: ElevatedButton(
onPressed: createQR,
style: ElevatedButton.styleFrom(
backgroundColor: blue,
foregroundColor: Colors.white,
shape: RoundedRectangleBorder(
borderRadius: BorderRadius.circular(14),
),
),
child: const Text(
'Generate QR Code',
style: TextStyle(
fontSize: 17,
fontWeight: FontWeight.bold,
),
),
),
),
],
),
),
);
}
}

class QRPreviewPage extends StatelessWidget {
final String type;
final String data;

const QRPreviewPage({
super.key,
required this.type,
required this.data,
});

@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(title: const Text('QR Details')),
body: Padding(
padding: const EdgeInsets.all(20),
child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
Text(
'$type Information',
style: const TextStyle(
fontSize: 22,
fontWeight: FontWeight.bold,
),
),
const SizedBox(height: 16),
SelectableText(data),
const SizedBox(height: 16),
const Text(
'Your details are ready. QR image generation '
'will require a QR-code package.',
),
],
),
),
);
}
}
