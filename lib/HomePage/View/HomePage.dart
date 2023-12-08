import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Controller/Home_Controller.dart';
import '../Model/Model.dart';

class HomePage extends StatelessWidget {
  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("My Favorite Film")),
      body: Center(
        child: Obx(
              () => controller.isLoading.value
              ? CircularProgressIndicator()
              : controller.isError.value
              ? buildErrorWidget()
              : buildFilmList(),
        ),
      ),
    );
  }

  Widget buildErrorWidget() {
    return Text('Failed to load data. Please try again later.');
  }

  Widget buildFilmList() {
    return GetBuilder<HomeController>(
      builder: (controller) {
        return ListView.builder(
          padding: const EdgeInsets.all(10),
          itemCount: controller.movies.length,
          itemBuilder: (BuildContext context, int index) {
            Result filmItem = controller.movies[index];
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Card(
                elevation: 4,
                child: ListTile(
                  contentPadding: EdgeInsets.all(10),
                  leading: Container(
                    width: 80,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      image: DecorationImage(
                        image: filmItem.posterPath != null
                            ? NetworkImage(filmItem.posterPath)
                            : AssetImage('assets/placeholder_image.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  title: Text(
                    filmItem.title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 5),
                      Text("Release Date: ${filmItem.releaseDate}"),
                      Text("Genre: ${filmItem.genreIds}"),
                      Text("Duration: ${filmItem.duration}"), // Fix duration
                      Text("Rating: ${filmItem.voteAverage.toString()}"),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
