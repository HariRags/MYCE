import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:kriv/utilities/global.dart';
import 'package:kriv/utilities/responsive.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class QueryCard extends StatefulWidget {
  const QueryCard({
    Key? key, 
    required this.title, 
    required this.category, 
  }) : super(key: key);
  
  final String title;
  final String category;

  @override
  State<QueryCard> createState() => _QueryCardState();
}

class _QueryCardState extends State<QueryCard> {
  Future<List<dynamic>> fetchPastInquiries() async {
    final token = globals.accessToken;
  
    final response = await http.get(
      Uri.parse(dotenv.env['SERVER_URL']!+'api/past-inquiries/'),
      headers: {
        'Authorization': token,  
        'Content-Type': 'application/json',
      },
    );
    
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      print(data['project_management_service']);
      return data[widget.category] ?? [];
    } else {
      throw Exception('Failed to load past inquiries');
    }
  }

  Widget _buildInquiryDetails(Map<String, dynamic> inquiry) {
    Widget details;
    switch (widget.category) {
      case 'houses':
        details = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Type: ${inquiry['home_type'] ?? 'N/A'}',
              style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w500),
            ),
            Text('Location: ${inquiry['location'] ?? 'N/A'}'),
            Text('Address 1: ${inquiry['location_line_1'] ?? 'N/A'}'),
            Text('Address 2: ${inquiry['location_line_2'] ?? 'N/A'}'),
            Text('Plan Details: ${inquiry['plan_details'] ?? 'N/A'}'),
            Text('Digital Survey: ${inquiry['digital_survey'] ? 'Yes' : 'No'}'),
          ],
        );
        break;

      case 'inquiries':
        details = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Email: ${inquiry['email'] ?? 'N/A'}'),
            Text('Phone: ${inquiry['phone_number'] ?? 'N/A'}'),
            Text('Message: ${inquiry['message'] ?? 'N/A'}'),
            Text('Status: ${inquiry['status'] ?? 'N/A'}'),
          ],
        );
        break;

      case 'project_management_service':
        details = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Security: ${inquiry['security'] ?? 'N/A'}'),
            Text('House Keeping: ${inquiry['house_keeping'] ?? 'N/A'}'),
            Text('Property Tax: ${inquiry['property_tax'] ?? 'N/A'}'),
            Text('Electrical and Repairs: ${inquiry['electrical_and_repairs'] ?? 'N/A'}'),
          ],
        );
        break;

      case 'buying_property':
        details = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Property Type: ${inquiry['property_type'] ?? 'N/A'}'),
            Text('Address 1: ${inquiry['location_line_1'] ?? 'N/A'}'),
            Text('Address 2: ${inquiry['location_line_2'] ?? 'N/A'}'),
            Text('Land Size: ${inquiry['land_size']?.toString() ?? 'N/A'} sq ft'),
            Text('Budget: ₹${inquiry['budget']?.toString() ?? 'N/A'} Cr'),
          ],
        );
        break;

      case 'selling_property':
        details = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Property Type: ${inquiry['property_type'] ?? 'N/A'}'),
            Text('Address 1: ${inquiry['location_line_1'] ?? 'N/A'}'),
            Text('Address 2: ${inquiry['location_line_2'] ?? 'N/A'}'),
            Text('Land Size: ${inquiry['land_size']?.toString() ?? 'N/A'} sq ft'),
            Text('Owner Details: ${inquiry['owner_details'] ?? 'N/A'}'),
            Text('Expected Price: ₹${inquiry['expected_price']?.toString() ?? 'N/A'} Cr'),
          ],
        );
        break;

      case 'architecture_design':
        details = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Type: ${inquiry['requirement_type'] ?? 'N/A'}'),
            Text('Address 1: ${inquiry['location_line_1'] ?? 'N/A'}'),
            Text('Address 2: ${inquiry['location_line_2'] ?? 'N/A'}'),
            Text('Land Size: ${inquiry['land_size']?.toString() ?? 'N/A'} sq ft'),
            Text('Digital Survey: ${inquiry['digital_survey'] ? 'Yes' : 'No'}'),
            if (inquiry['requirements'] != null)
              Text('Requirements: ${inquiry['requirements']}'),
          ],
        );
        break;

      case 'swimming_pool':
        details = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Location Details: ${inquiry['location_details'] ?? 'N/A'}'),
            Text('Pool Size: ${inquiry['pool_size']?.toString() ?? 'N/A'} sq ft'),
            if (inquiry['size_availability'] != null)
              Text('Size Availability: ${inquiry['size_availability']}'),
            if (inquiry['equipment_list'] != null)
              Text('Equipment List: ${inquiry['equipment_list']}'),
          ],
        );
        break;

      case 'industrial_properties':
        details = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Type: ${inquiry['property_type'] ?? 'N/A'}'),
            Text('Location: ${inquiry['location'] ?? 'N/A'}'),
            Text('Address 1: ${inquiry['location_line_1'] ?? 'N/A'}'),
            Text('Address 2: ${inquiry['location_line_2'] ?? 'N/A'}'),
            Text('Plan Details: ${inquiry['plan_details'] ?? 'N/A'}'),
            Text('Digital Survey: ${inquiry['digital_survey'] ? 'Yes' : 'No'}'),
          ],
        );
        break;

      case 'commercial_properties':
        details = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Type: ${inquiry['cp_type'] ?? 'N/A'}'),
            Text('Location: ${inquiry['location'] ?? 'N/A'}'),
            Text('Address 1: ${inquiry['location_line_1'] ?? 'N/A'}'),
            Text('Address 2: ${inquiry['location_line_2'] ?? 'N/A'}'),
            Text('Plan Details: ${inquiry['plan_details'] ?? 'N/A'}'),
            Text('Digital Survey: ${inquiry['digital_survey'] ? 'Yes' : 'No'}'),
          ],
        );
        break;

      default:
        details = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('No specific details available'),
          ],
        );
    }
    
    
    
    return Card(
      margin: EdgeInsets.only(bottom: Responsive.height(1, context)),
      child: Padding(
        padding: EdgeInsets.all(Responsive.width(3, context)),
        child: details,
      ),
    );
  }

  void _showPastInquiriesDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Container(
            width: Responsive.width(90, context),
            height: Responsive.width(200, context),
            padding: EdgeInsets.all(Responsive.width(4, context)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.title,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: Responsive.height(1.5, context),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.close),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
                SizedBox(height: Responsive.height(2, context)),
                Flexible(
                  child: FutureBuilder<List<dynamic>>(
                    future: fetchPastInquiries(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Text(
                            'Error loading inquiries',
                            style: TextStyle(color: Colors.red),
                          ),
                        );
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return Center(
                          child: Text(
                            'No past inquiries found',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: Responsive.height(2, context),
                            ),
                          ),
                        );
                      }

                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          final inquiry = snapshot.data![index];
                          return _buildInquiryDetails(inquiry);
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _showPastInquiriesDialog,
      child: Card(
        margin: EdgeInsets.only(
          left: Responsive.width(4, context),
          right: Responsive.width(4, context),
          bottom: Responsive.height(2, context),
        ),
        elevation: 6,
        surfaceTintColor: Colors.white,
        color: Colors.white,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(
                bottom: Responsive.height(1, context),
              ),
              width: Responsive.width(80, context),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                      Responsive.width(8, context),
                      Responsive.height(2.5, context),
                      Responsive.width(5, context),
                      Responsive.width(4, context),
                    ),
                    child: Text(
                      widget.title,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: Responsive.height(2.4, context),
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                 
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios_rounded,
              size: Responsive.height(2.8, context),
              color: const Color.fromRGBO(107, 67, 151, 1),
            )
          ],
        ),
      ),
    );
  }
}