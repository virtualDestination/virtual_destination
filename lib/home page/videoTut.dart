import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';


class ytVidPlayer extends StatefulWidget {
  @override
  _ytVidPlayerState createState() => _ytVidPlayerState();
}

class _ytVidPlayerState extends State<ytVidPlayer> {
  YoutubePlayerController youtubePlayerController;
  @override
  void initState() {
    // TODO: implement initState
    youtubePlayerController = new YoutubePlayerController(
      initialVideoId: "Nv_q2cCs9LM",
      params: YoutubePlayerParams(
        showControls: true,
        showFullscreenButton: true,
        enableCaption: true,
        color: "Purple",

      )
    );
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      // width: size.width*0.2,
      // height: size.height*0.2,
      decoration: BoxDecoration(
      ),
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(top:size.height*0.25,bottom: size.height*0.25,),
      child: YoutubePlayerIFrame(
        aspectRatio: 16/9,
        controller: youtubePlayerController,
      ),
    );
  }
}