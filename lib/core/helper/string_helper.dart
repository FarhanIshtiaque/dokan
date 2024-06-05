import 'dart:io';
import 'package:intl/intl.dart';
import 'package:path/path.dart' as path;
class StringHelper {





  static String hideEmail(String email) {
    if (email.isEmpty) {
      return email;
    }

    final List<String> parts = email.split('@');
    if (parts.length != 2) {
      return email;
    }

    final String username = parts[0];
    final String domain = parts[1];
    const int visibleCharacters = 1; // Number of characters to keep visible

    String maskedUsername = '';
    for (int i = 0; i < username.length; i++) {
      if (i < visibleCharacters || i >= username.length - visibleCharacters) {
        maskedUsername += username[i];
      } else {
        maskedUsername += '*';
      }
    }

    return '$maskedUsername@$domain';
  }

  static String unMask(String val) {
  return val.replaceAll(RegExp(r'\D'), '');
  }



 static  Future<String> renameImageName(File image, String newName) async {
    // Get the directory of the original file
   final directory = path.dirname(image.path);

   // Extract the extension of the original file
   final extension = path.extension(image.path);

   // Create the new file path with the desired name and original extension
   final newImagePath = path.join(directory, '$newName$extension');

   // Rename the file
   final renamedFile = await image.rename(newImagePath);

   // Return the new file name
   return path.basename(renamedFile.path);

  }


   static String formatDateWithSuffix(DateTime date) {
    final day = date.day;
    final suffix = getDaySuffix(day);
    final formattedDate = DateFormat('MMMM d').format(date);
    final year = DateFormat('y').format(date);

    return '$formattedDate$suffix, $year';
  }

  static  String getDaySuffix(int day) {
    if (day >= 11 && day <= 13) {
      return 'th';
    }
    switch (day % 10) {
      case 1:
        return 'st';
      case 2:
        return 'nd';
      case 3:
        return 'rd';
      default:
        return 'th';
    }
  }

 static String maskPhoneNumber(String? phoneNumber) {
   if (phoneNumber == null || phoneNumber.isEmpty) {
     return 'unavailable';
   }

   // Extract the last 10 digits
   String lastTenDigits = phoneNumber.length > 10
       ? phoneNumber.substring(phoneNumber.length - 10)
       : phoneNumber;

   // Extract the extra digits if the number is longer than 10 digits
   String extraDigits = phoneNumber.length > 10
       ? phoneNumber.substring(0, phoneNumber.length - 10)
       : '';

   // Format the last 10 digits
   String formattedNumber = '(${lastTenDigits.substring(0, 3)}) ${lastTenDigits.substring(3, 6)}-${lastTenDigits.substring(6)}';

   // Prepend the extra digits if any
   if (extraDigits.isNotEmpty) {
     formattedNumber = '$extraDigits $formattedNumber';
   }

   return formattedNumber;
 }


}