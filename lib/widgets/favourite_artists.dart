import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:jel_music/controllers/artist_controller.dart';
import 'package:jel_music/models/album.dart';
import 'package:jel_music/models/artist.dart';
import 'package:jel_music/widgets/album_page.dart';
import 'package:jel_music/widgets/songs_page.dart';
import 'package:sizer/sizer.dart';

class FavouriteArtists extends StatefulWidget {
  const FavouriteArtists({super.key});

  @override
  State<FavouriteArtists> createState() => _FavouriteArtistsState();
}

class _FavouriteArtistsState extends State<FavouriteArtists> {
    @override
  void initState() {
    super.initState();
    controller.favourite = true;
    artistsFuture = controller.onInit(); 
  }
  ArtistController controller = ArtistController();
  late Future<List<Artists>> artistsFuture;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Artists>>(
      future: artistsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(
            child: Text('No artists available.'),
          );
        } else {
          // Data is available, build the list
          List<Artists> artistsList = snapshot.data!;
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                Container(
                  height: 200,
                  width: MediaQuery.of(context).size.width,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: artistsList.length,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return SizedBox(
                        child: InkWell(
                          onTap:() => {
                            Navigator.push(context,
                              MaterialPageRoute(builder: (context) => AlbumPage(artistId: artistsList[index].name!,)),
                            )}, 
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.sp),
                          ),
                          child: Container(
                              decoration: BoxDecoration(
                                color: (const Color(0xFF1C1B1B)),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10.sp),
                                ),
                              ),
                              child: Column(
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(5, 5, 5, 5),
                                    child: SizedBox(
                                      height:40.w,
                                      width: 42.w,
                                      child: ClipOval(
                                        child: CachedNetworkImage(
                                          fit: BoxFit.fill,
                                          imageUrl: artistsList[index].picture ?? "",
                                          memCacheHeight: 180,
                                          memCacheWidth: 180,
                                          placeholder: (context, url) => const CircularProgressIndicator(
                                            strokeWidth: 5,
                                            color: Color.fromARGB(255, 60, 60, 60),
                                          ),
                                          errorWidget: (context, url, error) => Container(
                                            color: const Color(0xFF71B77A),
                                            child: const Center(
                                              child: Text("404"),
                                            ),
                                          ),
                                        )
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        }
      }
    );
  }
}