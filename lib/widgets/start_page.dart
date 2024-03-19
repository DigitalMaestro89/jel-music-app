import 'package:flutter/material.dart';
import 'package:jel_music/widgets/all_albums_page.dart';
import 'package:jel_music/widgets/artists_page.dart';
import 'package:jel_music/widgets/favourite_albums.dart';
import 'package:jel_music/widgets/favourite_artists.dart';
import 'package:jel_music/widgets/liked_songs.dart';
import 'package:jel_music/widgets/newcontrols.dart';
import 'package:jel_music/widgets/settings_page.dart';
import 'package:sizer/sizer.dart';

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(actions: [Padding(padding: const EdgeInsets.fromLTRB(0, 0, 15, 0), child: IconButton(icon: const Icon(Icons.settings), 
                  onPressed: () { Navigator.push(context, MaterialPageRoute(builder: (context) => const SettingsPage()),);}))],
                  backgroundColor: const Color(0xFF1C1B1B)),
        backgroundColor: const Color(0xFF1C1B1B),
        body: Padding(
          padding: EdgeInsets.only(
            top: 5.h,
            left: 0.sp,
            bottom: 10.sp,
            right: 0.sp,
          ),
          child: SingleChildScrollView(
            child: Column(
                children: [
                  Row(
                    children: [
                      SizedBox(
                        height:20.h,
                        width: 50.w,
                        child: Card(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              const ListTile(
                                leading: Icon(Icons.album),
                                title: Text('All Music'),
                                subtitle: Text('All your music'),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  const SizedBox(width: 8),
                                  TextButton(
                                    child: const Text('ARTISTS'),
                                    onPressed: () {Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => const ArtistPage()),
                                      );},
                                  ),
                                  const SizedBox(width: 8),
                                  TextButton(
                                    child: const Text('ALBUMS'),
                                    onPressed: () {Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => AllAlbumsPage(favourite: false)),
                                      );},
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height:20.h,
                        width: 50.w,
                        child: Card(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              const ListTile(
                                leading: Icon(Icons.album),
                                title: Text('Liked Songs'),
                                subtitle: Text('Your liked songs'),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  TextButton(
                                    child: const Text('VIEW'),
                                    onPressed: () {Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => const LikedSongs()),
                                      );},
                                  ),
                                  const SizedBox(width: 8),
                                  TextButton(
                                    child: const Text('LISTEN'),
                                    onPressed: () {Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => const ArtistPage( )),
                                      );},
                                  ),
                                  const SizedBox(width: 8),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),

                    ],
                  ),
                  const Text('Favourite Albums', style: TextStyle(color: Colors.grey,  fontSize: 20)),
                  const FavouriteAlbums(),
                  const Text('Favourite Artists', style: TextStyle(color: Colors.grey, fontSize: 20)),
                  const FavouriteArtists(),
                ],
                    ),
          )
      ),
      bottomSheet: const Controls()
          )
    );
  }
}