import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:song_player_ui/Modal/modal.dart';
import 'package:song_player_ui/Provider/song.dart';
import 'package:song_player_ui/View/utils/golbal.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {



    songProvider homeProviderfalse = Provider.of<songProvider>(context, listen: false);
    songProvider Providertrue = Provider.of<songProvider>(context, listen: true);

    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.black,
      drawer: Drawer(
        backgroundColor: Colors.black,
        width: 350,
        child: CustomScrollView(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: false,
        ),
      ),
      body: Stack(children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child:
              Column(
                children: [
                  const SizedBox(height: 25),
                  // App Bar
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.pinkAccent,
                          radius: 20,
                          child: const Center(
                            child: Text('H', style: TextStyle(color: Colors.white)),
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.notifications, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  // Search Bar
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      onSubmitted: (query) {
                        homeProviderfalse.searchSongs(query);
                      },
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: 'Search a new song?',
                        hintStyle: const TextStyle(color: Colors.white),
                        prefixIcon: const Icon(Icons.search, color: Colors.white),
                        suffixIcon: const Icon(Icons.mic, color: Colors.white),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.white, width: 2),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  // Banner
                  Container(
                    height: 200,
                    width: 400,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/image/banner.webp'),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  // Padding(
                  //   padding: const EdgeInsets.only(left: 8,right: 4),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //     children: [
                  //
                  //       Text('Recents',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize:18),),
                  //       TextButton(onPressed: () {
                  //
                  //       }, child: Text('Show all'))
                  //     ],
                  //   ),
                  // ),
                  // Text(Providertrue.getRecentlyPlayed();),

                  // Expanded(
                  //   child: ListView.builder(
                  //     itemCount: recentlyPlayedSongs.length,
                  //     itemBuilder: (context, index) {
                  //       final song = recentlyPlayedSongs[index];
                  //       return ListTile(
                  //         title: Text(song['title'] ?? "Unknown Title"),
                  //         subtitle: Text(song['artist'] ?? "Unknown Artist"),
                  //         onTap: () => playSong(song), // Play song on tap
                  //       );
                  //     },
                  //   ),
                  // ),
                  // Artists Section
                  Row(
                    children: const [
                      SizedBox(width: 8),
                      Text(
                        'Artists',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ],
                  ),
                  SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(imageList.length, (index) {
                        return GestureDetector(
                          onTap: () {
                            String data = imageList[index]['name'];
                            homeProviderfalse.searchSongs(data);
                          },
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: CircleAvatar(
                                  radius: 50,
                                  backgroundImage: AssetImage(imageList[index]['image']),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Text(imageList[index]['name'], style: const TextStyle(color: Colors.white)),
                              ),
                            ],
                          ),
                        );
                      }),
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Recommended Section
                  Row(
                    children: const [
                      Text(
                        'Recommended for trending today',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(newList.length, (index) {
                        return GestureDetector(
                          onTap: () {
                            String data = newList[index]['name'];
                            homeProviderfalse.searchSongs(data);
                          },
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Container(
                                  height: 200,
                                  width: 200,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                      image: AssetImage(newList[index]['image']),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text(newList[index]['name'], style: const TextStyle(color: Colors.white)),
                              ),
                            ],
                          ),
                        );
                      }),
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Songs List
                  Provider.of<songProvider>(context).songModel == null
                      ? const Center(child: CircularProgressIndicator())
                      : Consumer<songProvider>(
                    builder: (context, provider, child) => ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: provider.songModel!.data.results.length,
                      itemBuilder: (context, index) {
                        Result result = provider.songModel!.data.results[index];
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () {
                              provider.selectSong(result);
                              provider.setSong(result.downloadUrl[1].url);
                              Navigator.of(context).pushNamed('/song');
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.blue.withOpacity(0.4),
                                    Colors.transparent,
                                  ],
                                ),
                              ),
                              child: ListTile(
                                leading: Container(
                                  height: 100,
                                  width: 100,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                      image: NetworkImage(result.image[2].url),
                                    ),
                                  ),
                                ),
                                title: Text(result.name, style: const TextStyle(color: Colors.white)),
                                trailing: const Icon(Icons.more_vert, color: Colors.white),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Bottom Music Player
          Positioned(
            bottom: 18,
            left: 0,
            right: 0,
            child: Consumer<songProvider>(
              builder: (context, provider, child) => provider.result?.downloadUrl == null
                  ? const SizedBox.shrink()
                  : Container(
                height: 100,
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.blue.withOpacity(1), Colors.transparent],
                  ),
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                ),
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed('/song');
                  },
                  child: ListTile(
                    leading: Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: NetworkImage(provider.result!.image[2].url),
                        ),
                      ),
                    ),
                    title: Text(provider.result!.name, style: const TextStyle(color: Colors.white)),
                    subtitle: Text(provider.result!.artists.primary[0].name, style: const TextStyle(color: Colors.white)),
                    trailing: ValueListenableBuilder(
                      valueListenable: provider.isPlaying,
                      builder: (context, value, child) {
                        return IconButton(
                          onPressed: provider.playSong,
                          icon: AnimatedSwitcher(
                            duration: const Duration(milliseconds: 300),
                            child: value
                                ? const Icon(Icons.pause_circle_filled, color: Colors.white, size: 40, key: ValueKey('pause'))
                                : const Icon(Icons.play_circle_fill_outlined, color: Colors.white, size: 40, key: ValueKey('play')),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
color: Colors.transparent,
child:   Row(
mainAxisAlignment: MainAxisAlignment.spaceAround,
children: [
IconButton(onPressed: () {}, icon: Icon(Icons.home_filled, color: Colors.white)),

IconButton(onPressed: () {}, icon: Icon(Icons.search_rounded, color: Colors.white)),
// IconButton(onPressed: () {}, icon: Icon(Icons.swap_horiz, color: Colors.white)),
IconButton(onPressed: () {}, icon: Icon(Icons.library_add_check, color: Colors.white)),
],
),),
    );
  }
}

