import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../Model/Model.dart';

class HomeController extends GetxController {
  RxList<Result> movies = <Result>[].obs;
  RxBool isLoading = true.obs;
  RxBool isError = false.obs;

  // Metode untuk mengambil data dari API
  Future<void> fetchData() async {
    final String apiUrl =
        "https://api.themoviedb.org/3/movie/popular?api_key=3ae15fca7280afdfd3538229a2bcae80";

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final ListFilm data = ListFilm.fromJson(json.decode(response.body));

        movies.assignAll(data.results);
        isLoading.value = false;
      } else {
        isError.value = true;
        throw Exception('Failed to load data');
      }
    } catch (error) {
      isError.value = true;
      print('Error: $error');
    }
  }

  @override
  void onInit() {
    fetchData();
    super.onInit();
  }
}
