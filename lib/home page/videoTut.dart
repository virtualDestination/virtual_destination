import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';


class ytVidPlayer extends StatefulWidget {
  @override
  _ytVidPlayerState createState() => _ytVidPlayerState();
}

class _ytVidPlayerState extends State<ytVidPlayer> {
  YoutubePlayerController youtubePlayerController;
  String selectedVideo = "Y39vpkrVhGM";
  List<String> urls= ["Y39vpkrVhGM","MntIaBP0Iqg"];
  void _launchURL(String url) async =>
      await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    youtubePlayerController = new YoutubePlayerController(
        initialVideoId: selectedVideo,
        params: YoutubePlayerParams(
          showControls: true,
          showFullscreenButton: true,
          enableCaption: true,
          color: "Purple",
          playlist: ["Y39vpkrVhGM", "MntIaBP0Iqg", "D0aps6wzyX8", "jHjwBNRLHIM", "y-iVLkCgu_o", "wMlnNf0TPsw", "2jukh50bZWE", "hHYtvvyrP6U", "P-uCPPEX0FU", "Wrz5CyPUtEI", "GiTpOaxKolg", "lHiIXpUK_f0", "lHiIXpUK_f0", "hDDnavzg_Uw", "B3YnhgUM-5c", "V-yCC5CcLhM", "V-yCC5CcLhM", "a9QVqlS6BVk", "AuY82ecAaAo"]
        )
    );
    Size size = MediaQuery.of(context).size;
    return Container(
      alignment: Alignment.center,
      width: size.width*1,
      height: size.height*1,
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