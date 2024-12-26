import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kriv/utilities/responsive.dart';
import 'package:kriv/widgets/myce_backbutton.dart';
import 'package:kriv/widgets/plaincard.dart';
import 'package:kriv/widgets/querycard.dart';

class QueriesHome extends StatefulWidget {
  const QueriesHome({Key? key}) : super(key: key);

  @override
  State<QueriesHome> createState() => _QueriesHomeState();
}

class _QueriesHomeState extends State<QueriesHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            MYCEBackButton(),
            Container(
              alignment: Alignment.topLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(
                      left: Responsive.width(3.5, context),
                      right: Responsive.width(3.5, context),
                    ),
                    child: Text(
                      'Past Queries',
                      style: TextStyle(
                          fontFamily: 'Fraunces',
                          fontWeight: FontWeight.w600,
                          fontSize: Responsive.height(2.5, context)),
                    ),
                  ),
                  SizedBox(
                    height: Responsive.height(1, context),
                  ),
                  Container(
                    height: Responsive.height(83, context),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () {},
                            child: const QueryCard(
                              title: 'Execution (House)',
                              category: "houses",
                            ),
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: const QueryCard(
                              title: 'Execution (Industrial)',
                              category: "industrial_properties",
                            ),
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: const QueryCard(
                              title: 'Execution (Commercial)',
                              category: "commercial_properties",
                            ),
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: const QueryCard(
                                title: 'Execution Phase',
                                category: "inquiries"),
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: const QueryCard(
                              title: 'Project Management Services',
                              category: "project_management_service",
                            ),
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: const QueryCard(
                              title: 'Architecture Design',
                              category: "architecture_design",
                            ),
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: const QueryCard(
                              title: 'Real Estate (Buy)',
                              category: "buying_property",
                            ),
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: const QueryCard(
                              title: 'Real Estate (Sell)',
                              category: "selling_property",
                            ),
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: const QueryCard(
                              title: 'Swimming Pool',
                              category: "swimming_pool",
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
