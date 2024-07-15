// api_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:msaudit/user_model.dart'; // Adjust as per your actual import path

class ApiService {
  static Future<void> updateTicketStatus(int ticketId, String status) async {
    try {
      final url = 'https://your-api-endpoint.com/updateTicketStatus'; // Replace with your actual API endpoint
      final response = await http.put(
        Uri.parse(url),
        body: jsonEncode({
          'ticket_id': ticketId,
          'status': status,
        }),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        print('Ticket status updated successfully');
      } else {
        print('Failed to update ticket status: ${response.statusCode}');
        throw Exception('Failed to update ticket status');
      }
    } catch (e) {
      print('Error updating ticket status: $e');
      throw Exception('Failed to update ticket status');
    }
  }
}
