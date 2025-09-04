import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_ad_ios_plugins/hep/ad_num_hep.dart';

StorageData<bool> musicSwitch=StorageData<bool>(key: "musicSwitch", defaultValue: true);

class AudioName{
  static const String click="click";
  static const String clickPaoPao="click_paopao";
  static const String fail="fail";
  static const String wheel="wheel";
  static const String win="win";
}

class Flora121MusicHep{
  static final Flora121MusicHep _hep = Flora121MusicHep();
  static Flora121MusicHep get instance => _hep;


  final AudioPlayer _bgm=AudioPlayer();
  final AudioPlayer _audio=AudioPlayer();

  init(){
    _audio.onPlayerStateChanged.listen((event) {
      if(musicSwitch.getData()){
        if(event==PlayerState.playing){
          _bgm.pause();
        }else if(event==PlayerState.completed){
          _bgm.resume();
        }
      }
    });
    playBgm();
  }

  playBgm(){
    if(musicSwitch.getData()){
      _bgm.setReleaseMode(ReleaseMode.loop);
      _bgm.play(AssetSource("bgm1.MP3"));
    }
  }

  pauseBgm(){
    if(_bgm.state==PlayerState.playing){
      _bgm.pause();
    }
  }

  onOrOffMusic(){
    if(musicSwitch.getData()){
      musicSwitch.saveData(false);
      _bgm.pause();
    }else{
      musicSwitch.saveData(true);
      playBgm();
    }
  }

  playOtherAudio(String audioName){
    if(musicSwitch.getData()){
      _audio.play(AssetSource("$audioName.MP3"));
    }
  }
}