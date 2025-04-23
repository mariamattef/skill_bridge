import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hal_app/utilities/color_utilis.dart';

class RequestsScreen extends StatefulWidget {
  const RequestsScreen({super.key});

  @override
  State<RequestsScreen> createState() => _RequestsScreenState();
}

class _RequestsScreenState extends State<RequestsScreen> {
  final _formKey = GlobalKey<FormState>();
  String title = '';
  String description = '';

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.0.r),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Submit Skill Development Request',
              style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20.h),
            _buildTextField(
              label: 'Skill Name',
              onSaved: (val) => title = val ?? '',
            ),
            SizedBox(height: 16.h),
            _buildTextField(
              label: 'Request Details',
              onSaved: (val) => description = val ?? '',
              maxLines: 4,
            ),
            SizedBox(height: 20.h),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                  backgroundColor: ColorUtility.purble,
                  foregroundColor: Colors.white,
                ),
                icon: Icon(Icons.send),
                label: Text('Submit',style: TextStyle(fontSize: 16.sp),),
                onPressed: _handleSubmit,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleSubmit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Request Submitted'),
          content: Text('Your request for "$title" has been received.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  Widget _buildTextField({
    required String label,
    required Function(String?) onSaved,
    int maxLines = 1,
  }) {
    return TextFormField(
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
      ),
      validator: (val) =>
          val == null || val.trim().isEmpty ? 'Required field' : null,
      onSaved: onSaved,
    );
  }
}
