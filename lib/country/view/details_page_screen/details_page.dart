import 'package:advance_flutter_exam_part_1/country/model/countrymodel.dart';
import 'package:advance_flutter_exam_part_1/country/provider/countryprovider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailsPage extends StatefulWidget {
  final List<CountryModel> dataList;
  final int selectedIndex;

  const DetailsPage({super.key, required this.dataList, required this.selectedIndex});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  late String title;

  @override
  void initState() {
    super.initState();
    title = widget.dataList[widget.selectedIndex].name.common;
  }

  @override
  Widget build(BuildContext context) {
    CountryProvider countryProviderFalse =
        Provider.of<CountryProvider>(context, listen: false);

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blue.shade50,
        appBar: AppBar(
          backgroundColor: Colors.blue.shade800,
          leading: const Icon(
            Icons.menu,
            color: Colors.white,
          ),
          centerTitle: true,
          title: Text(
            title,
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        body: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(15),
              width: double.infinity,
              height: 320,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade400,
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    widget.dataList[widget.selectedIndex].flags.png,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildDetailRow(
                        title: 'Official Name',
                        value: widget.dataList[widget.selectedIndex].name.official,
                        actionIcon: Icons.bookmark,
                        action: () {
                          countryProviderFalse.addToFavorites(
                            widget.selectedIndex,
                            widget.dataList,
                          );
                        },
                      ),
                      _buildDetailRow(
                        title: 'Common Name',
                        value: widget.dataList[widget.selectedIndex].name.common,
                      ),
                      _buildDetailRow(
                        title: 'Area',
                        value: '${widget.dataList[widget.selectedIndex].area} km²',
                      ),
                      _buildDetailRow(
                        title: 'Region',
                        value: widget.dataList[widget.selectedIndex].region,
                      ),
                      _buildDetailRow(
                        title: 'Population',
                        value: widget.dataList[widget.selectedIndex].population.toString(),
                      ),
                      _buildDetailRow(
                        title: 'SubRegion',
                        value: widget.dataList[widget.selectedIndex].subregion,
                      ),
                      _buildDetailRow(
                        title: 'Capital',
                        value: widget.dataList[widget.selectedIndex].capital.join(', '),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow({
    required String title,
    required String value,
    IconData? actionIcon,
    VoidCallback? action,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey.shade700,
                  ),
                ),
              ],
            ),
          ),
          if (actionIcon != null && action != null)
            IconButton(
              icon: Icon(actionIcon, color: Colors.blue),
              onPressed: action,
            ),
        ],
      ),
    );
  }
}