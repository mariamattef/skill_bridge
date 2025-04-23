import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


Future<void> sendWelcomeEmail(String email) async {
  const serviceId = 'service_is5xre9';    
  const templateId = 'template_2v7o81u';    
  const userId = 'KV4w2zYI5E7qSVyNO';        

  final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');

  final response = await http.post(
    url,
    headers: {
      'origin': 'http://localhost',
      'Content-Type': 'application/json',
    },
    body: json.encode({
      'service_id': serviceId,
      'template_id': templateId,
      'user_id': userId,
      'template_params': {
        'email': email,
        'user_name': email.split('@')[0],
        'message': 'Welcome to SkillBridge! 🎉 We’re happy to have you.',
      }
    }),
  );

  if (response.statusCode == 200) {
    debugPrint('✅ Welcome email sent successfully!');
  } else {
    debugPrint('❌ Failed to send welcome email: ${response.body}');
  }
}
