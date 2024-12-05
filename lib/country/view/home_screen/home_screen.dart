import 'package:advance_flutter_exam_part_1/country/model/countrymodel.dart';
import 'package:advance_flutter_exam_part_1/country/provider/countryprovider.dart';
import 'package:advance_flutter_exam_part_1/country/view/details_page_screen/details_page.dart';
import 'package:advance_flutter_exam_part_1/country/view/saved_countries/saved_countries.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    CountryProvider countryProviderFalse =
        Provider.of<CountryProvider>(context, listen: false);

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blue.shade50,
        appBar: AppBar(
          backgroundColor: Colors.blue.shade800,
          elevation: 0,
          leading: const Icon(
            Icons.menu,
            color: Colors.white,
          ),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const SavedCountries(),
                  ),
                );
              },
              icon: const Icon(
                Icons.favorite,
                color: Colors.white,
              ),
            ),
          ],
          title: const Text(
            'Country Details',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        body: FutureBuilder<List<CountryModel>>(
          future: countryProviderFalse.fromList(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.blue,
                ),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text(
                  'Error: ${snapshot.error}',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              );
            } else if (snapshot.hasData) {
              List<CountryModel>? dataList = snapshot.data;
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      ...List.generate(
                        dataList!.length,
                        (index) => GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => DetailsPage(
                                  dataList: dataList,
                                  selectedIndex: index,
                                ),
                              ),
                            );
                          },
                          child: Card(
                            elevation: 5,
                            margin: const EdgeInsets.only(bottom: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Row(
                                children: [
                                  Container(
                                    height: 82,
                                    width: 76,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                          dataList[index].flags.png,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          dataList[index].name.common,
                                          style: const TextStyle(
                                            color: Colors.blue,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          dataList[index].region,
                                          style: TextStyle(
                                            color: Colors.grey.shade600,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return const Center(
                child: Text(
                  'No data available',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}