import 'package:advance_pdf_viewer_example/defaults/defaults.dart';
import 'package:advance_pdf_viewer_example/screens/player_screen.dart';
import 'package:advance_pdf_viewer_example/screens/video_screen.dart';
import 'package:flutter/material.dart';
import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:advance_pdf_viewer_example/routes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

var indexClicked = 0;

class MyApp extends StatefulWidget {
  static String routeName = "/home";

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final pages = [
    Center(
      child: Text('Heiliiger Geist'),
    ),
    Center(
      child: Text('Göttliches Licht'),
    ),
    Center(
      child: Text('Jesus'),
    ),
    Center(
      child: Text('Liebe'),
    ),
    Center(
      child: Text('Vertarauen'),
    ),
    Center(
      child: Text('Vergebung'),
    ),
  ];

  bool _isLoading = true;
  PDFDocument document;
  PDFPage page;

  @override
  void initState() {
    super.initState();
    loadDocument();
  }

  loadDocument() async {
    document = await PDFDocument.fromAsset('assets/sample.pdf');

    setState(() => _isLoading = false);
  }

//All Pdf-Allatra
  changePDF(value) async {
    setState(() => _isLoading = true);
    if (value == 1) {
      document = await PDFDocument.fromAsset('assets/sample2.pdf');
    } else if (value == 2) {
      document = await PDFDocument.fromURL(
        "https://allatraunites.com/storage/app/media/about-allatra-pdf/en/about-allatra-ipm.pdf",
        cacheManager: CacheManager(
          Config(
            "customCacheKey",
            stalePeriod: const Duration(days: 6),
            maxNrOfCacheObjects: 800,
          ),
        ),
      );
    } else {
      document = await PDFDocument.fromAsset('assets/sample.pdf');
    }
    setState(() => _isLoading = false);
  }

//All Pdh-Allatra End
  Function updateState(int index) {
    return () {
      setState(() {
        indexClicked = 4;
      });
      Navigator.pop(context);
    };
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.yellow.shade50,
        endDrawerEnableOpenDragGesture: true,
        drawer: Drawer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            //Drawer Header
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage('assets/images/drawer.png'),
                  ),
                ),
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Container(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      CircleAvatar(
                        radius: 45,
                        backgroundImage:
                            AssetImage('assets/images/ornament1.png'),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'AllatRa Reader',
                        style: GoogleFonts.sanchez(
                          fontSize: 15,
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'developed by Blendit4',
                        style: GoogleFonts.sanchez(
                          fontSize: 10,
                          color: Colors.amber[200],
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'V0.0.1b_DE',
                        style: GoogleFonts.sanchez(
                          fontSize: 8,
                          color: Colors.white38,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              //Button und Icons
              Expanded(
                child: ListView(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    children: [
                      SizedBox(height: 10),
                      Builder(builder: (context) {
                        return ListTile(
                          onTap: () {
                            setState(() {
                              indexClicked = 0;
                              changePDF(2);
                              Navigator.pop(context);
                            });
                          },
                          leading: Icon(
                            Defaults.drawerItemIcon[0], //Info Icon
                            size: 35,
                            color: indexClicked == 0
                                ? Defaults.drawerItemSelectedColor
                                : Defaults.drawerItemColor,
                          ),
                          title: Text('AllatRa Unity'),
                        );
                      }),
                      Builder(builder: (context) {
                        return ListTile(
                          onTap: () {
                            setState(() {
                              indexClicked = 1;
                              changePDF(1);
                              Navigator.pop(context);
                            });
                          },
                          leading: Icon(
                            Defaults.drawerItemIcon[1], //Stern Icon
                            size: 35,
                            color: indexClicked == 1
                                ? Defaults.drawerItemSelectedColor
                                : Defaults.drawerItemColor,
                          ),
                          title: Text('B&P von A.Novich'),
                        );
                      }),
                      Builder(builder: (context) {
                        return ListTile(
                          onTap: () {
                            setState(() {
                              indexClicked = 3;
                              changePDF(3);
                              Navigator.pop(context);
                            });
                          },
                          leading: Icon(
                            Defaults.drawerItemIcon[3], //Buch Icon
                            size: 35,
                            color: indexClicked == 3
                                ? Defaults.drawerItemSelectedColor
                                : Defaults.drawerItemColor,
                          ),
                          title: Text('Das Buch AllatRa (DE)'),
                        );
                      }),
                      SizedBox(
                        height: 50,
                      ),
                      Builder(builder: (context) {
                        return ListTile(
                          onTap: () {
                            setState(() {
                              Navigator.popAndPushNamed(
                                  context, PlayerScreen.routeName);
                            });
                          },
                          leading: Icon(
                            Defaults.drawerItemIcon[4], //Buch Icon
                            size: 35,
                            color: indexClicked == 1
                                ? Defaults.drawerItemSelectedColor
                                : Defaults.drawerItemColor,
                          ),
                          title: Text('Media Center'),
                        );
                      }),
                      const ListTile(),
                      const SizedBox(
                        height: 200,
                      ),
                      Center(
                        child: Text(
                          ' Hardcoded by',
                          style: GoogleFonts.sanchez(
                            fontWeight: FontWeight.w500,
                            fontStyle: FontStyle.italic,
                            fontSize: 20,
                            color: Defaults.drawerItemSelectedColor,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Center(
                        child: Text(
                          'Edgar Cuppari - © 2021',
                          style: GoogleFonts.sanchez(
                            fontWeight: FontWeight.w500,
                            fontStyle: FontStyle.italic,
                            fontSize: 12,
                            color: Defaults.drawerItemColor,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const ListTile(),
                    ]),
              )
            ],
          ),
        ),
        appBar: AppBar(
          title: const Text('AllatRA - PDF-Reader'),
          backgroundColor: Colors.indigo.shade400,
        ),
        body: Center(
          child: _isLoading
              ? Center(child: CircularProgressIndicator())
              : PDFViewer(
                  document: document,
                  zoomSteps: 1,
                  //uncomment below line to preload all pages
                  lazyLoad: false,
                  // uncomment below line to scroll vertically
                  scrollDirection: Axis.vertical,
                ),
        ),
      ),
      routes: routes,
    );
  }
}
