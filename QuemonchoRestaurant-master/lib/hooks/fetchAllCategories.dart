import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:foodly_restaurant/models/categories.dart';
import 'package:foodly_restaurant/models/environment.dart';
import 'package:foodly_restaurant/models/hook_models/hook_result.dart';

import 'package:http/http.dart' as http;

// Custom Hook
FetchHook useFetchAllCategories() {
  final categoryItems = useState<List<Categories>?>(null);
  final isLoading = useState(false);
  final error = useState<Exception?>(null);

  // Fetch Data Function
  Future<void> fetchData() async {
    isLoading.value = true;
    try {
      final response =
          await http.get(Uri.parse('${Environment.appBaseUrl}/api/category/random'));

      if (response.statusCode == 200) {
        print(response.body);
        categoryItems.value = categoryFromJson(response.body);
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      error.value = e as Exception?;
    } finally {
      isLoading.value = false;
    }
  }

  // Side Effect
  /// This hook fetches all categories.
  /// It uses the `useEffect` hook to trigger the `fetchData` function when the component mounts.
  /// The `fetchData` function is responsible for fetching the data.
  /// The hook returns `null` to indicate that there is no cleanup needed when the component unmounts.
  useEffect(() {
    fetchData();
    return null;
  }, const []);

  // Refetch Function
  void refetch() {
    isLoading.value = true;
    fetchData();
  }

  // Return values
  return FetchHook(
    data: categoryItems.value,
    isLoading: isLoading.value,
    error: error.value,
    refetch: refetch,
  );
}
