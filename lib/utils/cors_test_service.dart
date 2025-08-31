import 'dart:convert';
import 'package:http/http.dart' as http;

class Post {
  final int id;
  final int userId;
  final String title;
  final String body;

  Post({
    required this.id,
    required this.userId,
    required this.title,
    required this.body,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      userId: json['userId'],
      title: json['title'],
      body: json['body'],
    );
  }
}

class CorsTestService {
  static const String baseUrl = 'https://jsonplaceholder.typicode.com';

  // Test GET request
  Future<Post?> getPost(int postId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/posts/$postId'),
        headers: {'Content-Type': 'application/json'},
      );

      print('GET Response Status: ${response.statusCode}');
      print('GET Response Headers: ${response.headers}');

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        return Post.fromJson(json);
      } else {
        print('GET Request failed with status: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('GET Request error: $e');
      return null;
    }
  }

  // Test POST request
  Future<Post?> createPost(String title, String body, int userId) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/posts'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'title': title, 'body': body, 'userId': userId}),
      );

      print('POST Response Status: ${response.statusCode}');
      print('POST Response Headers: ${response.headers}');

      if (response.statusCode == 201) {
        final json = jsonDecode(response.body);
        return Post.fromJson(json);
      } else {
        print('POST Request failed with status: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('POST Request error: $e');
      return null;
    }
  }

  // Test multiple requests
  Future<List<Post>> getPosts({int limit = 5}) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/posts?_limit=$limit'),
        headers: {'Content-Type': 'application/json'},
      );

      print('GET Posts Response Status: ${response.statusCode}');

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = jsonDecode(response.body);
        return jsonList.map((json) => Post.fromJson(json)).toList();
      } else {
        print('GET Posts Request failed with status: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('GET Posts Request error: $e');
      return [];
    }
  }

  Future<void> testQuranApi() async {
    try {
      final response = await http.get(
        Uri.parse('http://localhost:8080/ayah/4:1/ar.alafasy'),
        headers: {'Content-Type': 'application/json'},
      );

      print('Quran API Response Status: ${response.statusCode}');
      print('Quran API Response Headers: ${response.headers}');

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        print('✅ Quran API Success');
        print('Response: ${json.toString().substring(0, 200)}...');
      } else {
        print('❌ Quran API Failed with status: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } on http.ClientException catch (e) {
      print('❌ Quran API ClientException (likely CORS): $e');
      print('Error type: ${e.runtimeType}');
      print('Error message: ${e.message}');
      print('URI: ${e.uri}');
    } catch (e) {
      print('❌ Quran API Other error: $e');
      print('Error type: ${e.runtimeType}');
      print('Error details: ${e.toString()}');
    }
  }

  // Comprehensive test method
  Future<void> runCorsTest() async {
    print('🧪 Starting CORS Test...\n');

    // Test 1: Simple GET
    print('📥 Test 1: GET single post');
    final post = await getPost(1);
    if (post != null) {
      print('✅ GET Success: ${post.title}');
    } else {
      print('❌ GET Failed');
    }
    print('');

    // Test 2: POST request
    print('📤 Test 2: POST new post');
    final newPost = await createPost(
      'Test Post from Flutter',
      'This is a test post to check CORS',
      1,
    );
    if (newPost != null) {
      print('✅ POST Success: Created post with ID ${newPost.id}');
    } else {
      print('❌ POST Failed');
    }
    print('');

    // Test 3: Multiple requests
    print('📥 Test 3: GET multiple posts');
    final posts = await getPosts(limit: 3);
    if (posts.isNotEmpty) {
      print('✅ GET Multiple Success: Retrieved ${posts.length} posts');
      for (final p in posts) {
        print('   - ${p.id}: ${p.title.substring(0, 30)}...');
      }
    } else {
      print('❌ GET Multiple Failed');
    }
    print('');

    print('🏁 CORS Test Complete');
  }
}
