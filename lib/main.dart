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
  double translateX = 0;
  double translateY = 0;
  double windowScale = 1;
  List<PopImage> popImages = [
    PopImage('莊子心性 - 人本無情', 'reference/1-1.jpg', 500, 110, 190, 70),
    PopImage('莊子心性 - 借貸', 'reference/2-2.jpg', 500, 185, 190, 175),
    PopImage('莊子心性 - 不為官', 'reference/2-3.jpg', 500, 365, 190, 120),
    PopImage('莊子心性 - 莊周夢蝶', 'reference/2-4.png', 700, 110, 190, 115),
    PopImage('莊子心性 - 生死四時', 'reference/2-5.jpeg', 700, 230, 190, 90),
    PopImage('莊子心性 - 天地為棺', 'reference/2-6.jpg', 700, 323, 190, 105),
    PopImage('逍遙遊子 - 鯤與鵬', 'reference/2-1.jpeg', 950, 120, 245, 115),
    PopImage('逍遙遊子 - 列子1.2', 'reference/1-2.jpeg', 950, 240, 245, 85),
    PopImage('逍遙遊子 - 山人', 'reference/1-3.jpg', 950, 330, 245, 140),
    PopImage('逍遙遊子 - 山人', 'reference/1-3.jpg', 1200, 120, 230, 45),
    PopImage('逍遙遊子 - 列子1.4', 'reference/1-4.jpeg', 1200, 170, 230, 150),
    PopImage('邯鄲學步', 'reference/7-1.png', 1920, 150, 430, 90),
    PopImage('井底之蛙', 'reference/8-3.jpeg', 1920, 1030, 430, 70),
  ];

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double imageWidth = 2378;
    double imageHeight = 1554;
    double imageRatio = imageWidth / imageHeight;
    double needWidth = screenSize.height * imageRatio;
    double needHeight = screenSize.width / imageRatio;
    double scaledWidth = needWidth > screenSize.width ? screenSize.width : needWidth;
    double scaledHeight = needHeight < screenSize.height ? needHeight : screenSize.height;
    double anchorX = (screenSize.width - scaledWidth) / 2;
    double anchorY = (screenSize.height - scaledHeight) / 2;
    double imageScaleWidth = scaledWidth / imageWidth;
    double imageScaleHeight = scaledHeight / imageHeight;
    return Scaffold(
        body: GestureDetector(
          onPanUpdate: (details) {
            setState(() {
              translateX += details.delta.dx;
              translateY += details.delta.dy;
            });
          },
          child: Transform.scale(
            scale: windowScale,
            child: Transform.translate(
              offset: Offset(translateX, translateY),
              child: Container(
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("background/background.png"),
                    fit: BoxFit.contain,
                  ),
                ),
                child: Stack(
                  children: popImages.map((e) {
                    return Positioned(
                      left: e.x * imageScaleWidth + anchorX,
                      top: e.y * imageScaleHeight + anchorY,
                      width: e.width * imageScaleWidth,
                      height: e.height * imageScaleHeight,
                      child: GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return popUpImage(e.imageName, e.path2Image);
                            },
                          );
                        },
                        child: Container(color: Colors.purpleAccent.withOpacity(0.3)),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
        ),
        floatingActionButton: Container(
          height: 100,
          width: 50,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.purple.withOpacity(0.3),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {

                  setState(() {
                    windowScale += 0.3;
                  });
                },
                icon: const Icon(Icons.zoom_in, color: Colors.black),
              ),
              IconButton(
                onPressed: () {
                  if (windowScale <= 0.3) return;

                  setState(() {
                    windowScale -= 0.3;
                  });
                },
                icon: Icon(Icons.zoom_out, color: windowScale <= 0.3 ? Colors.grey : Colors.black),
              ),
            ],
          ),
        ));
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
              width: 60.w,
              height: 60.h,
            ),
          );
        },
      ),
    );
  }
}
