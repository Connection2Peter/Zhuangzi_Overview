import 'config.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

void main() {
  runApp(const ZhuangziOverview());
}

class ZhuangziOverview extends StatelessWidget {
  const ZhuangziOverview({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (context, orientation, screenType) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: tabName,
          home: const MainPage(),
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
                    windowScale += factor;
                  });
                },
                icon: const Icon(Icons.zoom_in, color: Colors.black),
              ),
              IconButton(
                onPressed: () {
                  if (windowScale <= factor) return;

                  setState(() {
                    windowScale -= factor;
                  });
                },
                icon: Icon(Icons.zoom_out, color: windowScale <= factor ? Colors.grey : Colors.black),
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
