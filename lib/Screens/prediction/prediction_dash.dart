import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:noob_wallet/Screens/details/details.dart';
import 'package:noob_wallet/Screens/home/components/body.dart';
import 'package:noob_wallet/Screens/prediction/Prediction_results.dart';

class Prediction extends StatelessWidget {
  final List<String> imageList = [
    "https://images.pexels.com/photos/6765371/pexels-photo-6765371.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
   "https://images.pexels.com/photos/730552/pexels-photo-730552.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
    "https://images.pexels.com/photos/7293821/pexels-photo-7293821.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500"
  ];
  
  Prediction({Key? key}) : super(key: key);
  int currentIndex = 0;
  String textIndex ='' ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        
        child: Column(
          
          children: [
            const SizedBox(
            width: 200.0,
            height: 70.0,
          ),
            const Text("TRADE WITH NOOB TEAM ", 
             style: TextStyle(
                fontSize: 24,
                color:Color(0xFF003C71) ,
                fontWeight: FontWeight.bold),
            ),
              const SizedBox(
            width: 150.0,
            height: 120.0,
          ),
            CarouselSlider(
              options: CarouselOptions(
                onPageChanged:(index, reason) {
                  currentIndex = index;
                  //print(currentIndex);
                  setState((){});
                  },
                enlargeCenterPage: true,
                scrollDirection: Axis.horizontal ,
                enableInfiniteScroll: false,
                autoPlay: true,
              ),
              items: imageList.map((e) => 
                  ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Stack(
                          fit: StackFit.expand,
                          children: <Widget>[
                            Image.network(
                              e,
                              width: 900,
                              height: 350,
                              fit: BoxFit.cover,
                            )
                          ],
                        ),
                      ))
                  .toList(),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                  style: ElevatedButton.styleFrom(
                  primary: Colors.red, // background
                  onPrimary: Colors.white, // foreground
                  ),
                  onPressed: () {
                    showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return  Column(
                        children: [
                          Wrap(
                            children: [
                               ListTile(
                                leading: Icon(Icons.share),
                                title: Text('Share'),
                              ),
                              ListTile(
                                leading: Icon(Icons.copy),
                                title: Text('Copy Link'),
                              ),
                              ListTile(
                                leading: Icon(Icons.edit),
                                title: Text('Edit'),
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                  );
                },
                  /*onPressed: () {
                      switch (currentIndex) {
                        case 0:
                        textIndex ='btc' ;
                        
                          //Navigator.push(context, MaterialPageRoute(builder: (context) => Predict_result(text: textIndex,)),);
                          break;
                        case 1:
                        textIndex ='eth' ;
                           Navigator.push(context, MaterialPageRoute(builder: (context) => const BodyHome()),);
                        break;
                        case 2:
                        textIndex ='lite' ;
                         Navigator.push(context, MaterialPageRoute(builder: (context) => const BodyHome()),);
                        break;
                        default:
                         Navigator.push(context, MaterialPageRoute(builder: (context) => const BodyHome()),);
                      }
                    }*/
                  child: Text('Predict here'),
                  )
                ],
            ),)
          ],
        ),
      ),
    );
  }
}

void setState(Null Function() param0) {
}
