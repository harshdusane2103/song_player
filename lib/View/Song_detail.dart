import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:song_player_ui/Provider/song.dart';
class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(Provider.of<songProvider>(context).result!.name),
      // ),
      body: Consumer<songProvider>(builder: (context, provider, child) =>Column(children: [
        Container(
          width: double.infinity,
          height:847,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.red.shade200, Colors.black], // Gradient colors
              begin: Alignment.topLeft, // Gradient start point
              end: Alignment.bottomRight, // Center of the radial gradient
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    IconButton(
                      onPressed: () async {
                        // await AudioService.player.pause();
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.arrow_back_ios_new,
                        color: Colors.white,
                      ),
                    ),
                    Container(
                      width: width*0.20,
                      child: Text(
                        Provider.of<songProvider>(context).result!.name,
                        style: TextStyle(color: Colors.white),overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.more_vert,
                          color: Colors.white,
                        ))
                  ],
                ),
                SizedBox(height: 50),
                Center(
                  child: Container(
                    height: 340,
                    width: 340,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.red,
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          image: NetworkImage(provider.result!.image[2].url),
                        )),
                  ),
                ),
                SizedBox(height: 60),
                Row(children: [
                  SizedBox(width: 20,),

                  Center(
                    child: Text(
              provider.result!.name,
                      style: TextStyle(
                          color: Colors.white,

                          fontWeight: FontWeight.bold),
                    ),
                  )
                ]),
                SizedBox(height: 3),
                Row(children: [
                  SizedBox(width: 20,),
                  Text(
                    provider.result!.artists.primary[0].name,
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),

                ]),


                StreamBuilder<Duration>(
                  stream: provider.getCurrentPosition(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      // Ensure snapshot data is available before accessing it
                      final currentPosition = snapshot.data ?? Duration.zero;
                      final totalDuration = provider.duration ?? Duration.zero;

                      return Column(
                        children: [
                          Slider(
                            value: currentPosition.inSeconds.toDouble(),
                            max: totalDuration.inSeconds.toDouble(),
                            min: 0.0,
                            activeColor: Colors.white,
                            inactiveColor: Colors.grey,
                            onChanged: (value) {
                              provider.seekToPosition(value); // Seek to the new position
                            },
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Display the current position in the 00:00 format
                              Text(
                                provider.formatDuration(currentPosition),
                                style: TextStyle(color: Colors.white),
                              ),
                              // Display the total duration in the 00:00 format
                              Text(
                                provider.formatDuration(totalDuration),
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ],
                      );
                    } else {
                      return CircularProgressIndicator(); // Show loading indicator while fetching data
                    }
                  },
                ),




                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.shuffle,
                          color: Colors.green,
                        )),
                    IconButton(
                      onPressed:provider.previousSong,
                      icon: Icon(
                        Icons.skip_previous,
                        size: 50,
                        color: Colors.white,
                      ),
                    ),
                    // Play/Pause button with animation
                    ValueListenableBuilder(
                      valueListenable: provider.isPlaying,
                      builder: (context, value, child) {
                        return IconButton(
                          onPressed: provider.playSong,
                          icon: AnimatedSwitcher(
                            duration: Duration(milliseconds: 300),
                            transitionBuilder: (child, animation) {
                              return ScaleTransition(
                                scale: animation,
                                child: child,
                              );
                            },
                            child: value
                                ? Icon(Icons.pause_circle_filled,
                                color: Colors.white,
                                size: 80,
                                key: ValueKey('pause'))
                                : Icon(Icons.play_circle_fill_outlined,
                                color: Colors.white,
                                size: 80,
                                key: ValueKey('play')),
                          ),
                        );
                      },
                    ),
                    IconButton(
                      onPressed:provider.nextSong,
                      icon: Icon(
                        Icons.skip_next,
                        color: Colors.white,
                        size: 50,
                      ),
                    ),
                    IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.timer,
                          color: Colors.white,
                        ))
                  ],
                ),
              ],
            ),
          ),
        ),
      ],) ,),
    );
  }
}
