import 'package:flutter/material.dart';
import 'package:link_text/link_text.dart';
import 'package:ml_zone/pages/document_scanner.dart';
import 'package:ml_zone/pages/image_to_text.dart';
import 'package:ml_zone/utils/custom_colors.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: primaryBGColor,
      drawer: Drawer(
        backgroundColor: Color(0xff13203b),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: primaryBGColor,
                image: DecorationImage(
                  image: AssetImage('assets/images/bg_home.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: null,
            ),
            Expanded(
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Scan Verse',
                      style: TextStyle(
                          color: primaryTextColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Your trusted scanner, easy &\n user-friendly!',
                      style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.normal,
                          ),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: secondaryTextColor),
                          borderRadius: BorderRadius.circular(16)),
                      child: ListTile(
                        leading: Icon(
                          Icons.person,
                          color: primaryTextColor,
                        ),
                        title: Text(
                          'Developer info',
                          style: TextStyle(color: textColor),
                        ),
                        trailing: Icon(
                          Icons.arrow_circle_right_outlined,
                          color: textColor,
                        ),
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  backgroundColor: Color(0xff264888),
                                  icon: CircleAvatar(
                                      child: Image.asset(
                                    'assets/images/profile.jpeg',
                                  )),
                                  title: Text(
                                    'Md. Sohanur Rahman Hridoy',
                                    style: TextStyle(
                                        color: textColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  content: Text(
                                    'Professional Flutter Developer!\nLearner || Programmer ||AI enthusiast',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(color: Colors.white70),
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text(
                                        'Close',
                                        style: TextStyle(
                                            color: primaryTextColor,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                );
                              });
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: secondaryTextColor),
                          borderRadius: BorderRadius.circular(16)),
                      child: ListTile(
                        leading: Icon(
                          Icons.facebook,
                          color: primaryTextColor,
                        ),
                        title: Text(
                          'Contact us',
                          style: TextStyle(color: textColor),
                        ),
                        trailing: Icon(
                          Icons.arrow_circle_right_outlined,
                          color: textColor,
                        ),
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  backgroundColor: Color(0xff264888),
                                  title: Text(
                                    'Contact list',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: textColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  content: LinkText(
                                    onLinkTap: (url) {
                                      launchUrl(url as Uri,
                                          mode: LaunchMode
                                              .externalNonBrowserApplication);
                                    },
                                    'Phone : +8801724611873\nFB: https://www.facebook.com/Clasher007\nGithub: https://github.com/SRHridoy\nLinkedIn: https://www.linkedin.com/in/md-sohanur-rahman-hridoy-2385ab257/',
                                    textAlign: TextAlign.center,
                                    textStyle: TextStyle(color: Colors.white70),
                                    linkStyle: TextStyle(
                                      color: Colors.white70,
                                    ),
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text(
                                        'Close',
                                        style: TextStyle(
                                            color: primaryTextColor,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                );
                              });
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Divider(
                    color: secondaryTextColor,
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.help_outline,
                      color: primaryTextColor,
                    ),
                    title: Text(
                      'Help & Support',
                      style: TextStyle(color: textColor),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      // Navigate to Help
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: primaryBGColor,
        centerTitle: true,
        title: Text(
          'Scan Verse',
          style: TextStyle(color: textColor, fontSize: 25),
        ),
        actions: [
          Icon(Icons.document_scanner_outlined),
          SizedBox(
            width: 10,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(
                height: 40,
              ),
              Container(
                width: size.width,
                decoration: BoxDecoration(
                    border: Border.all(color: secondaryTextColor),
                    borderRadius: BorderRadius.circular(20)),
                child: Image.asset(
                  'assets/images/bg_home.png',
                  height: 200,
                ),
              ),
              SizedBox(
                height: 25,
              ),
              SizedBox(
                child: Text(
                  'Your Ultimate Solution!',
                  style: TextStyle(
                      color: primaryTextColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                width: size.width,
                child: Text(
                  'You can extract texts from images and you can scan any document quickly and efficiently!',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white70),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Card(
                  elevation: 5,
                  child: ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ImageToText(),
                          ));
                    },
                    leading: Icon(
                      Icons.text_fields,
                      color: primaryTextColor,
                    ),
                    tileColor: secondaryBGColor,
                    trailing: Icon(
                      Icons.navigate_next_outlined,
                      color: textColor,
                      size: 30,
                    ),
                    title: Text(
                      'Text Recognition',
                      style: TextStyle(
                          color: textColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  )),
              SizedBox(
                height: 20,
              ),
              Card(
                elevation: 5,
                child: Container(
                  decoration: BoxDecoration(color: secondaryBGColor),
                  child: ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DocumentScannerScreen(),
                          ));
                    },
                    leading: Icon(
                      Icons.document_scanner_rounded,
                      color: primaryTextColor,
                    ),
                    trailing: Icon(
                      Icons.navigate_next_outlined,
                      color: textColor,
                      size: 30,
                    ),
                    title: Text(
                      'Document Scanner',
                      style: TextStyle(
                          color: textColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
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
