import 'package:flutter/cupertino.dart';

class MuyuAssetsImage extends StatelessWidget {
  final String image;
  final VoidCallback onTap;

   MuyuAssetsImage({super.key,required this.image ,required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Center(
      child:  GestureDetector(
        onTap: onTap,
        child: Image.asset(image, height:200),
      ),
    );
  }


}