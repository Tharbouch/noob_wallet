import 'package:flutter/material.dart';
class ScreenSetting extends StatelessWidget {
  const ScreenSetting({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween ,
        children: [
          Padding(padding: EdgeInsets.all(10)) , 
          ListView(
        children:const [
          Card(
            child: ListTile(
              title:Text("Edit currency coin ") ,
              trailing: ImageIcon(
               AssetImage("assets/icons/bitcoin.png"),
                    color: Color(0xFF3A5A98),
               ),
            )
            ),
            Card(
            child: ListTile(
              title: Text("List Item 2"),
              trailing : ImageIcon(
                AssetImage("images/icon_more.png"),
                color: Color(0xFF3A5A98),
              ),
            ),
            ),
            Card(
            child: ListTile(
              title: Text("List Item 3"),
            )
          ),
        ],
      )
        ],
      ),
    );
  }
}