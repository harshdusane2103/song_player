//
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:song_player_ui/Modal/modal.dart';
import 'package:song_player_ui/Services/api.dart';

class songProvider extends ChangeNotifier {
  SongModel? songModel;
  Result? result;
  AudioPlayer player = AudioPlayer();
  Duration? duration;
  ValueNotifier<bool> isPlaying = ValueNotifier(false);
  ValueNotifier<Duration> currentPosition = ValueNotifier(Duration.zero);
  int currentIndex = 0; // Keep track of current song index

  List<Map<String, dynamic>> _recentlyPlayed = [];


  @override
  void dispose() {
    // Dispose ValueNotifiers when not needed
    isPlaying.dispose();
    currentPosition.dispose();
    super.dispose();
  }

  // Fetch songs from the API
  Future<void> getSongs({String query = ""}) async {
    ApiServices apiServices = ApiServices();
    Map<String, dynamic> json = await apiServices.fetchdata(query: query);
    songModel = SongModel.fromJson(json);
    notifyListeners();
  }
  Future<void> searchSongs(String query) async {
    await getSongs(query: query);
  }
  // Select a song
  void selectSong(Result selectedSong) {
    result = selectedSong;
    notifyListeners();
  }

  // Set the song by URL
  Future<void> setSong(String url) async {
    duration = await player.setUrl(url);
    notifyListeners();
  }

  // Play/Pause toggle
  void playButtonSong() {
    isPlaying.value = !isPlaying.value;
  }

  // Play or pause the song
  Future<void> playSong() async {
    if (isPlaying.value) {
      isPlaying.value = false;
      await player.pause();
    } else {
      isPlaying.value = true;
      await player.play();
    }
    notifyListeners();
  }

  // Move to the next song
  Future<void> nextSong() async {
    if (songModel != null && currentIndex < (songModel!.data.results.length - 1)) {
      currentIndex++; // Increment index to next song
      result = songModel!.data.results[currentIndex]; // Update current result
      await setSong(result!.downloadUrl[1].url); // Set and play the new song
      await playSong(); // Start playing the new song
      notifyListeners();
    }
  }

  // Move to the previous song
  Future<void> previousSong() async {
    if (songModel != null && currentIndex > 0)
    {
      currentIndex--; // Decrement index to previous song
      result = songModel!.data.results[currentIndex]; // Update current result
      await setSong(result!.downloadUrl[1].url); // Set and play the previous song
      await playSong(); // Start playing the previous song
      notifyListeners();
    }
  }
  Stream<Duration> getCurrentPosition()
  {
    return player.positionStream;

  }

  void seekToPosition(double seconds) {
    player.seek(Duration(seconds: seconds.toInt()));
    notifyListeners();


  }

  // Format the duration (e.g., 02:30)
  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));

    return "$minutes:$seconds";

  }

  void addToRecentlyPlayed(Map<String, dynamic> song) {
    // Check if the song is already in the list
    _recentlyPlayed.removeWhere((item) => item['id'] == song['id']);

    // Add the song to the beginning of the list
    _recentlyPlayed.insert(0, song);

    // Limit the list to the most recent 10 songs
    if (_recentlyPlayed.length > 10) {
      _recentlyPlayed = _recentlyPlayed.sublist(0, 10);
    }
  }

  // Method to get the recently played songs
  List<Map<String, dynamic>> getRecentlyPlayed() {
    return _recentlyPlayed;
  }


  // Method to add a song to the recently played list


  // Initialize songProvider
  songProvider() {
    getSongs();
  }
}
