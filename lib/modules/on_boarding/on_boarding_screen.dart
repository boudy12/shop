import 'package:flutter/material.dart';
import 'package:shop/modules/shop_app/login/login_screen.dart';
import 'package:shop/shared/components/components.dart';
import 'package:shop/shared/network/local/cache_helper.dart';
import 'package:shop/styles/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
class BoardingModel{
  final String title;
  final String image;
  final String body;

   BoardingModel({
     required this.title,
     required this.image,
     required this.body
  });
  
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var pageController = PageController();

  bool isLast = false;

  List<BoardingModel> boardingModel = [
    BoardingModel(
      title: 'Pay better',
      body: 'Speed safely through checkout and plant trees at no extra cost.',
      image: 'assets/Images/photo2.jpg',
    ),
    BoardingModel(
      title: 'Shop better',
      body: 'Discover new arrivals from your favorite stores first',
      image: 'assets/Images/shop.jpg',
    ),
    BoardingModel(
      title: 'Track better',
      body: 'Get real-time delivery updates from cart to home in one place',
      image: 'assets/Images/shop5.jpg',
    ),
    BoardingModel(
      title: 'Order Online',
      body: 'Make an order sitting on a sofa pay and choose online',
      image: 'assets/Images/photo1.jpg',
    ),
    BoardingModel(
      title: 'M-Commerce',
      body: 'Download our shopping application and buy using your smartphone or laptop',
      image: 'assets/Images/photo3.jpg',
    ),
  ];

  void submit(){
    CacheHelper.saveData(
        key: 'onBoarding',
        value: true
    ).then((value) {
      if(value){
        navigateAndFinishSS(context, ShopAppLoginScreen());
      }
    });
  }
  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: submit,
              child: Text(
                'SKIP',
                style: TextStyle(
                  fontSize: 18,
                  color: defaultColor
                ),
              )
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(22.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                itemBuilder: (context, index) => buildOnBoarding(boardingModel[index]),
                itemCount: boardingModel.length,
                onPageChanged: (int index){
                  if(index == boardingModel.length -1 )
                    {
                      setState(() {
                        isLast = true;
                      });
                    }
                  else{
                    setState(() {
                      isLast = false;
                    });
                  }
                },
                physics: BouncingScrollPhysics(),
                controller: pageController,

              ),
            ),
            SizedBox(
              height: 22,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SmoothPageIndicator(
                    controller: pageController,
                    count: boardingModel.length,
                    effect: ScrollingDotsEffect(
                      dotColor: Colors.blueGrey,
                      dotWidth: 12,
                      radius: 15,
                      activeDotScale: 2.5,
                      dotHeight: 12,
                      activeStrokeWidth: 2,
                      fixedCenter: true,
                      spacing: 15,
                      activeDotColor: defaultColor,
                    ),
                  ),
                  // Spacer(),
                  // FloatingActionButton(
                  //   onPressed: (){
                  //     if(isLast)
                  //       {
                  //         submit();
                  //       }
                  //     else{
                  //       pageController.nextPage(
                  //         duration: Duration(
                  //           milliseconds: 750,
                  //         ),
                  //         curve: Curves.easeInOutBack,
                  //       );
                  //     }
                  //
                  //   },
                  //   child: Icon(
                  //       Icons.arrow_forward_ios_outlined
                  //   ),
                  // ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildOnBoarding(BoardingModel model)=> Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
        flex: 2,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 7.0),
          child: Image(
            image: AssetImage(
              '${model.image}',
            ),
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
      ),
      SizedBox(
        height: 20,
      ),
      Expanded(
        flex: 1,
        child: Column(
          children: [
            Text(
              '${model.title}',
              style: TextStyle(
                  fontSize: 25,
                  color: defaultColor
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Center(
              child: Text(
                '${model.body}',
                style: TextStyle(
                    fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

class OnBoardingScreen extends StatefulWidget {

  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}
