import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:jel_music/controllers/all_albums_controller.dart';
import 'package:jel_music/models/album.dart';
import 'package:jel_music/widgets/songs_page.dart';
import 'package:sizer/sizer.dart';

class FavouriteAlbums extends StatefulWidget {
  const FavouriteAlbums({super.key});

  @override
  State<FavouriteAlbums> createState() => _FavouriteAlbumsState();


}

class _FavouriteAlbumsState extends State<FavouriteAlbums> {
    @override
  void initState() {
    super.initState();
    controller.favouriteVal = true;
    albumsFuture = controller.onInit(); 
  }
  AllAlbumsController controller = AllAlbumsController();
  late Future<List<Album>> albumsFuture;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Album>>(
      future: albumsFuture,
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
          List<Album> albumsList = snapshot.data!;
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                Container(
                  height: 180,
                  width: MediaQuery.of(context).size.width,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: albumsList.length,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return SizedBox(
                        child: InkWell(
                          onTap:() => {
                            Navigator.push(context,
                              MaterialPageRoute(builder: (context) => SongsPage(albumId: albumsList[index].title!, artistId: albumsList[index].artist!,)),
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
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(4.w),
                                        child: CachedNetworkImage(
                                          fit: BoxFit.fill,
                                          imageUrl: albumsList[index].picture ?? "",
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