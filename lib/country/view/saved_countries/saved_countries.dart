import 'package:advance_flutter_exam_part_1/country/provider/countryprovider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SavedCountries extends StatefulWidget {
  const SavedCountries({super.key});

  @override
  State<SavedCountries> createState() => _SavedCountriesState();
}

class _SavedCountriesState extends State<SavedCountries> {
  @override
  Widget build(BuildContext context) {
    CountryProvider countryProviderFalse =
        Provider.of<CountryProvider>(context, listen: false);
    CountryProvider countryProviderTrue =
        Provider.of<CountryProvider>(context, listen: true);

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blue.shade50,
        appBar: AppBar(
          elevation: 2,
          backgroundColor: Colors.blue.shade800,
          leading: const Icon(
            Icons.menu,
            color: Colors.white,
          ),
          centerTitle: true,
          title: const Text(
            'Saved Countries',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontFamily: 'Poppins',
            ),
          ),
        ),
        body: countryProviderTrue.favList.isEmpty
            ? Center(
                child: Text(
                  'No Saved Countries Yet',
                  style: TextStyle(
                    color: Colors.blue.shade800,
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Poppins',
                  ),
                ),
              )
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                child: ListView.builder(
                  itemCount: countryProviderTrue.favList.length,
                  itemBuilder: (BuildContext context, int index) {
                    final name = countryProviderTrue.favList[index]
                        .split('_')
                        .sublist(0, 1)
                        .join(' ');
                    final region = countryProviderTrue.favList[index]
                        .split('_')
                        .sublist(1, 2)
                        .join(' ');
                    final img = countryProviderTrue.favList[index]
                        .split('_')
                        .sublist(2, 3)
                        .join(' ');

                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      shadowColor: Colors.grey.shade300,
                      elevation: 4,
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            img,
                            height: 70,
                            width: 70,
                            fit: BoxFit.cover,
                          ),
                        ),
                        title: Text(
                          name,
                          style: const TextStyle(
                            color: Colors.blue,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Poppins',
                          ),
                        ),
                        subtitle: Text(
                          region,
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 15,
                            fontFamily: 'Poppins',
                          ),
                        ),
                        trailing: IconButton(
                          onPressed: () {
                            countryProviderFalse.removeFromLikePage(index);
                          },
                          icon: Icon(
                            Icons.delete,
                            color: Colors.red.shade600,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
      ),
    );
  }
}