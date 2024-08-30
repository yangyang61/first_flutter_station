import 'dart:math';

import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_first_station/muyu/count_panel.dart';
import 'package:flutter_first_station/muyu/muyu_assets_image.dart';

import 'AnimationText.dart';
import 'options/ImageOptionItem.dart';

class MuyuPage extends StatefulWidget {
  const MuyuPage({super.key, required String title});


  @override
  State<MuyuPage> createState() => _MuyuPageState();
}

class _MuyuPageState extends State<MuyuPage>{

    AudioPool? pool;
    int _counter = 0;
    int _cruValue = 0 ;
    final Random random = Random();
    final List<ImageOption> imageOptions = const [
      ImageOption('基础版','assets/images/muyu.png',1,3),
      ImageOption('尊享版','assets/images/muyu2.png',3,6),
    ];
    int _activeImageIndex = 0;
    String get activeImage => imageOptions[_activeImageIndex].src;

    @override
     void initState() {
       super.initState();
       _initAudioPool();
     }

    int get knockValue {
      int min = imageOptions[_activeImageIndex].min;
      int max = imageOptions[_activeImageIndex].max;
      return min + random.nextInt(max+1 - min);
    }

   void _initAudioPool() async {
      pool = await FlameAudio.createPool('muyu_1.mp3', maxPlayers: 4);
   }

  void _toHistory() {

  }

  void _onTapSwitchAudio() {}

  void _onTapSwitchImage() {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return ImageOptionPanel(
          imageOptions: imageOptions,
          activeIndex: _activeImageIndex,
          onSelect: _onSelectImage,
        );
      },
    );
  }

  void _onTap() {
    pool?.start();
    setState(() {
      _cruValue = knockValue; // 使用激活木鱼的值
      _counter += _cruValue;
    });
  }

  void _onSelectImage(int value) {
    Navigator.of(context).pop();
    if(value == _activeImageIndex) return;
    setState(() {
      _activeImageIndex = value;
    });
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        titleTextStyle: const TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.bold),
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text('电子木鱼'),
        actions: [
          IconButton(onPressed: _toHistory, icon: const Icon(Icons.history))
        ],
      ),
      body: Column(
        children: [
          Expanded(child: CountPanel(count: _counter,onTapSwitchAudio: _onTapSwitchAudio,onTapSwitchImage: _onTapSwitchImage,),),
          Expanded(child:
          Stack(
            alignment: Alignment.topCenter,
            children: [
              MuyuAssetsImage(
                image: activeImage, // 使用激活图像
                onTap: _onTap,
              ),
              if(_cruValue!=0) AnimationText(text:'功德+$_cruValue')
            ],
          ))
        ],
      ),

    );
  }
}
