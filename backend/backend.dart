import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
const String baseUrl = 'http://localhost:5000';
class UserSession {
  static const String _userIdKey = 'userId';
  
  static Future<void> saveUserId(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userIdKey, userId);
    print('✅ User ID saved: $userId');
  }
  
  static Future<String?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userIdKey);
  }
  
  static Future<void> clearUserId() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userIdKey);
    print('🗑️ User ID cleared');
  }
}
Future<Map<String, dynamic>> sendComplaint({
  required bool isAnonymous,
  String? name,
  required String category,
  required String description,
  required String complaintDate,
  required String complaintTime,
  required String location,
}) async {
  final urlforcomplaints= Uri.parse('http://localhost:5000/complaint');
  final userId = await UserSession.getUserId();
  
  if (userId == null) {
    return {'success': false, 'error': 'User not signed in'};
  }
  final body = jsonEncode({
    'userId':userId,
    'is_anonymous': isAnonymous,
    'name': isAnonymous ? null : name,
    'category': category,
    'description': description,
    'complaint_date': complaintDate,
    'complaint_time': complaintTime,
    'location': location,
  });

  try {
    final response = await http.post(
      urlforcomplaints,
      headers: {'Content-Type': 'application/json'},
      body: body,
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      print('Complaint saved: ${data['complaint_id']}');
      return {'success': true, 'complaintId': data['complaint_id']};
    } else {
      final error = jsonDecode(response.body);
      print('Failed: ${error['error']}');
      return {'success': false, 'error': error['error']};
    }
  } catch (e) {
    print('Error sending complaint: $e');
    return {'success': false, 'error': e.toString()};
  }
}


Future<String?> fetchLatestComplaintId() async {
  final userId = await UserSession.getUserId();
  
  if (userId == null) {
    print('Error: User not signed in');
    return null;
  }
  final url = Uri.parse(
    '$baseUrl/complaint/latest/$userId',
  );

  try {
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      return data['complaint_id'];
    } else {
      print("Failed to fetch complaint ID");
      return null;
    }
  } catch (e) {
    print("Error fetching complaint ID: $e");
    return null;
  }
}


class BackendState {
  static String? complaintId;
}

Future<bool> sendresponse({
  required List<int> questionIds,
  required List<dynamic> answers,
  List<String>? freeTextAnswers,
}) async {
  final url = Uri.parse('$baseUrl/responses');
  final userId = await UserSession.getUserId();
  
  if (userId == null) {
    print('Error: User not singed in sendresponse endpoint ');
    return false;
  }

  final body = jsonEncode({
    'userId': userId,
    'questionIds': questionIds,
    'answers': answers,
    if (freeTextAnswers != null) 'freeTextAnswers': freeTextAnswers,
  });

  try {
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: body,
    );

    if (response.statusCode == 200) {
      print('Responses saved: ${response.body}');
      return true;
    } else {
      print('Failed to save responses: ${response.body}');
      return false;
    }
  } catch (error) {
    print('Error sending responses: $error');
    return false;
  }
}



//gettingresponsefromusersignup
Future<Map<String, dynamic>> signupOrganisationUser({
  required String fullName,
  required String email,
  required String password,
  required String organisationId,
}) async {
  final url = Uri.parse('$baseUrl/api/org-user/signup');

  final body = jsonEncode({
    'fullName': fullName,
    'email': email,
    'password': password,
    'organisationId': organisationId,
  });

  try {
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: body,
    );

    print('📥 Status: ${response.statusCode}');
    print('📥 Body: ${response.body}');

    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = jsonDecode(response.body);
      
      final userId = data['userId']; 
      
      if (userId != null) {
        await UserSession.saveUserId(userId.toString());
        print('✅ UserId saved: $userId');
      } else {
        print('❌ No userId in response!');
      }
      
      return {
        'success': true,
        'userId': userId,
        'email': data['email'],
        'message': data['message']
      };
    } else {
      final error = jsonDecode(response.body);
      return {'success': false, 'error': error['error'] ?? 'Unknown error'};
    }
  } catch (e) {
    print('❌ Exception: $e');
    return {'success': false, 'error': e.toString()};
  }
}