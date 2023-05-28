import 'dart:io';
import 'package:http/http.dart' as http;

// Future<String> uploadProfileImageToS3(
//   File imageFile,
//   String userId, {
//   String region = 'us-east-1',
// }) async {
//   final key = 'ServeToBeFree/ProfilePictures/$userId/ProfilePicture';
//   final url = 'https://servetobefree-images.s3.amazonaws.com/$key'
//       .replaceAll('+', '%20');
//   final response = await http.put(
//     Uri.parse(url),
//     headers: {'Content-Type': 'image/jpeg'},
//     body: await imageFile.readAsBytes(),
//   );
//   if (response.statusCode != 200) {
//     throw Exception('Failed to upload image to S3');
//   }
// }

Future<String> uploadProfileImageToS3(
  File imageFile,
  String userId, {
  String region = 'us-east-1',
}) async {
  final key = 'ServeToBeFree/profilePictures/$userId/ProfilePicture';
  final url = 'https://servetobefree-images.s3.amazonaws.com/$key'
      .replaceAll('+', '%20');
  final response = await http.put(
    Uri.parse(url),
    headers: {'Content-Type': 'image/jpeg'},
    body: await imageFile.readAsBytes(),
  );
  if (response.statusCode != 200) {
    throw Exception('Failed to upload image to S3');
  }
  final s3Url = 'https://servetobefree-images.s3.amazonaws.com/$key';
  return s3Url;
}

Future<void> uploadProjectImageToS3(
  File imageFile,
  String bucketName,
  String projectId,
  String imageFileName, {
  String region = 'us-east-1',
}) async {
  final key = 'ServeToBeFree/ProjectPictures/$projectId/$imageFileName';
  final url =
      'https://$bucketName.s3.amazonaws.com/$key'.replaceAll('+', '%20');
  final response = await http.put(
    Uri.parse(url),
    headers: {'Content-Type': 'image/jpeg'},
    body: await imageFile.readAsBytes(),
  );
  if (response.statusCode != 200) {
    throw Exception('Failed to upload image to S3');
  }
}
