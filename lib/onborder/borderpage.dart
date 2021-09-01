import 'package:flutter/material.dart';
import 'package:newshop/Network/shearedpref/shared.dart';
import 'package:newshop/screens/login.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ScreensCustom {
  final String urlImage;
  final String titleBoarding;
  final String bodyBoarding;

  ScreensCustom(
      {@required this.urlImage,
      @required this.titleBoarding,
      @required this.bodyBoarding});
}

class OnBoardingScreen extends StatefulWidget {
  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var onBoardingControl = PageController();

  bool isLast = false;

  List<ScreensCustom> listScreen = [
    ScreensCustom(
        urlImage: 'assets/images/shopscreen1.jpg',
        titleBoarding: 'OnBoardingScreen1',
        bodyBoarding: 'OnBoardingSc1'),
    ScreensCustom(
        urlImage: 'assets/images/shopscreen3.jpg',
        titleBoarding: 'OnBoardingScreen2',
        bodyBoarding: 'OnBoardingSc2'),
    ScreensCustom(
        urlImage: 'assets/images/shopscreen2.jpg',
        titleBoarding: 'OnBoardingScreen3',
        bodyBoarding: 'OnBoardingSc3'),
  ];

  void submitSaveData() {
    CacheHelper.saveData(key: 'onBoarding', value: true).then((value) {
      if (value) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => LoginScreen()),
            (route) => false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(onPressed: submitSaveData, child: Text('SKIP')),
        ],
      ),
      body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  physics: BouncingScrollPhysics(),
                  controller: onBoardingControl,
                  onPageChanged: (int index) {
                    if (index == listScreen.length - 1) {
                      setState(() {
                        isLast = true;
                      });
                      print('last Screen');
                    } else {
                      setState(() {
                        isLast = false;
                      });
                      print('not last Screen');
                    }
                  },
                  itemBuilder: (context, index) =>
                      onBoardingScreenCustom(listScreen[index]),
                  itemCount: listScreen.length,
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Row(
                children: [
                  SmoothPageIndicator(
                    controller: onBoardingControl,
                    count: listScreen.length,
                    effect: ExpandingDotsEffect(
                        activeDotColor: Colors.deepOrange,
                        dotColor: Colors.grey,
                        dotHeight: 10,
                        dotWidth: 10,
                        expansionFactor: 7,
                        spacing: 5.0),
                  ),
                  Spacer(),
                  FloatingActionButton(
                    onPressed: () {
                      if (isLast) {
                        submitSaveData();
                      } else {
                        onBoardingControl.nextPage(
                            duration: Duration(milliseconds: 750),
                            curve: Curves.fastLinearToSlowEaseIn);
                      }
                    },
                    child: Icon(Icons.arrow_forward_ios),
                  )
                ],
              )
            ],
          )),
    );
  }
}

Widget onBoardingScreenCustom(ScreensCustom model) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Image(
            image: AssetImage('${model.urlImage}'),
          ),
        ),
        SizedBox(
          height: 30.0,
        ),
        Text(
          '${model.titleBoarding}',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 15.0,
        ),
        Text(
          '${model.bodyBoarding}',
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey),
        ),
        SizedBox(
          height: 15.0,
        ),
      ],
    );
