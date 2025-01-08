import 'package:flutter/material.dart';

class SearchSection extends StatelessWidget {
  final TextEditingController locationController;
  final Function(String?) onLocationChanged;
  final VoidCallback onSearchPressed;
  final bool isLocationSaved;

  const SearchSection({
    super.key,
    required this.locationController,
    required this.onLocationChanged,
    required this.onSearchPressed,
    required this.isLocationSaved,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: locationController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                hintText: 'Enter City Name',
                hintStyle: const TextStyle(
                  color: Colors.grey,
                  fontSize: 18,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                ),
              ),
              onChanged: onLocationChanged,
            ),
          ),
          const SizedBox(width: 10),
          ElevatedButton(
            onPressed: onSearchPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepPurpleAccent,
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Text(
              isLocationSaved ? 'Update' : "Search",
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}