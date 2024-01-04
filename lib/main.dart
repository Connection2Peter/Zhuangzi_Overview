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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: GestureDetector(
          onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return popUpImage('莊子心性', 'assets/莊子心性-人本無情.jpg');
              },
            );
          },
          child: FittedBox(
            fit: BoxFit.fitWidth,
            child: Image.asset(
              'assets/華光三部曲_final_page-0005.jpg',
              width: 100.w,
              height: 100.h,
            ),
          ),
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
