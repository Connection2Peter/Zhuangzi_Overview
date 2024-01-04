import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class PopImage {
  String imageName;
  String path2Image;
  double x, y, width, height;

  PopImage(
    this.imageName,
    this.path2Image,
    this.x,
    this.y,
    this.width,
    this.height,
  );
}

void main() {
  runApp(const ZhuangziOverview());
}

class ZhuangziOverview extends StatelessWidget {
  const ZhuangziOverview({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (context, orientation, screenType) {
        return const MaterialApp(
          debugShowCheckedModeBanner: false,
          title: '莊子通覽圖',
          home: MainPage(),
        );
      },
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<PopImage> popImages = [
    PopImage('莊子心性', 'assets/莊子心性-人本無情.jpg', 35, 105, 100, 100),
  ];

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double imageRatio = 2482 / 1757;
    double needWidth = screenSize.height * imageRatio;
    double needHeight = screenSize.width / imageRatio;
    double scaledWidth = needWidth > screenSize.width ? screenSize.width : needWidth;
    double scaledHeight = needHeight < screenSize.height ? needHeight : screenSize.height;
    double anchorX = (screenSize.width - scaledWidth) / 2;
    double anchorY = (screenSize.height - scaledHeight) / 2;
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/華光三部曲_final_page-0005.jpg"),
            fit: BoxFit.contain,
          ),
        ),
        child: Stack(
          children: popImages.map((e) {
            return Positioned(
              left: e.x + anchorX,
              top: e.y + anchorY,
              width: e.width,
              height: e.height,
              child: GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return popUpImage(e.imageName, e.path2Image);
                    },
                  );
                },
                child: Container(
                  color: Colors.purpleAccent,
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  AlertDialog popUpImage(String imageName, path2Image) {
    return AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(imageName),
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.close),
          ),
        ],
      ),
      content: StatefulBuilder(
        builder: (BuildContext context, StateSetter setAtomState) {
          return FittedBox(
            fit: BoxFit.fitWidth,
            child: Image.asset(
              path2Image,
              width: 80.w,
              height: 80.h,
            ),
          );
        },
      ),
    );
  }
}
