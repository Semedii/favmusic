import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
   CustomAppBar({
    required this.DisplayName,
    super.key});
  final String DisplayName;
  @override
  Size get preferredSize => const Size(300, 150);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color.fromARGB(255, 63, 62, 62),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(20),
        ),
      ),
      elevation: 0,
      flexibleSpace: Center(
          child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: CircleAvatar(
              radius: 40,
              backgroundImage: Image.asset("assets/images/lp_image.jpeg").image,
            ),
          ),
          const SizedBox(width: 16),
          Column(mainAxisAlignment: MainAxisAlignment.center, children:  [
            Text(
              _getGreeting(),
              style: TextStyle(color: Colors.white, fontSize: 28),
            ),
            SizedBox(
              height: 12,
            ),
            Text(
              "$DisplayName",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ]),
        ],
      )),
    );
  }
  String _getGreeting(){
    print(DateTime.now().hour);
    if(DateTime.now().hour>=1 && DateTime.now().hour<12){
      return "Good Morning";
    }
    if(DateTime.now().hour>=12 && DateTime.now().hour<18){
      return "Good Afternoon";
    }
    if(DateTime.now().hour>=18 && DateTime.now().hour<22){
      return "Good Evening";
    }
    if(DateTime.now().hour>=22){
      return "Good Night";
    }
    return "Hello";
  }

}
