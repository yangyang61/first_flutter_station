import 'package:flutter/material.dart';

class CountPanel extends StatelessWidget {

    final int count;
    final VoidCallback onTapSwitchAudio;
    final VoidCallback onTapSwitchImage;

   CountPanel({super.key,required this.count,required this.onTapSwitchAudio,required this.onTapSwitchImage});

  // 按钮样式
  final ButtonStyle style = ElevatedButton.styleFrom(minimumSize: const Size(36, 36),padding: EdgeInsets.zero,backgroundColor: Colors.green,elevation: 0);


  @override
  Widget build(BuildContext context){
    return Stack(
      children: [
         Center(
          child: Text('功德数：$count',style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),),
        ),
        Positioned(
          right: 10,
          top:10,
          child: Wrap(
            spacing: 8,
            direction: Axis.vertical,
            children: [
              ElevatedButton(
                  style: style,
                  onPressed: onTapSwitchAudio,
                  child: const Icon(Icons.music_note_outlined)
              ),
              ElevatedButton(
                  style: style,
                  onPressed: onTapSwitchImage,
                  child: const Icon(Icons.image)
              ),
            ],
          ),
        ),
      ],
    );
  }
}