import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  // Run the app by passing an instance of MyApp.
  runApp(const MyApp());
}

/// The main app widget.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // MaterialApp is the root widget of the app.
    return MaterialApp(
      title: 'Measurement Converter', // Title of the app.
      theme: ThemeData(
        primarySwatch: Colors.blue, // Default theme color.
      ),
      home: const MeasurementConverter(), // The home screen of the app.
    );
  }
}

/// The main screen widget for the measurement converter.
class MeasurementConverter extends StatefulWidget {
  const MeasurementConverter({super.key});

  @override
  State<MeasurementConverter> createState() => _MeasurementConverterState();
}

/// The state class for the MeasurementConverter widget.
/// Handles the logic and state management for the app.
class _MeasurementConverterState extends State<MeasurementConverter> {
  // Variables to store user input, converted value, and selected units.
  double inputValue = 0.0; // The value entered by the user.
  double convertedValue = 0.0; // The result after conversion.
  String fromUnit = 'Meters'; // The unit to convert from.
  String toUnit = 'Kilometers'; // The unit to convert to.
  bool isConvertButtonEnabled = false; // Whether the convert button is enabled.
  String errorMessage = ""; // Error message to display if input is invalid.

  // Lists of supported units for length and mass.
  List<String> lengthUnits = ['Meters', 'Kilometers', 'Miles', 'Feet'];
  List<String> massUnits = ['Grams', 'Kgs', 'Pounds'];

  /// Returns a list of valid "to" units based on the currently selected "from" unit.
  /// Ensures the user cannot convert from and to the same unit.
  List<String> getValidToUnits() {
    if (lengthUnits.contains(fromUnit)) {
      return lengthUnits.where((unit) => unit != fromUnit).toList();
    } else {
      return massUnits.where((unit) => unit != fromUnit).toList();
    }
  }

  /// Converts the input value from the "from" unit to the "to" unit.
  /// Updates the convertedValue based on the selected units.
  void convert() {
    setState(() {
      if (lengthUnits.contains(fromUnit)) {
        // Length unit conversions.
        if (fromUnit == 'Meters' && toUnit == 'Kilometers') {
          convertedValue = inputValue / 1000;
        } else if (fromUnit == 'Meters' && toUnit == 'Miles') {
          convertedValue = inputValue * 0.000621371;
        } else if (fromUnit == 'Meters' && toUnit == 'Feet') {
          convertedValue = inputValue * 3.28084;
        } else if (fromUnit == 'Kilometers' && toUnit == 'Meters') {
          convertedValue = inputValue * 1000;
        } else if (fromUnit == 'Kilometers' && toUnit == 'Miles') {
          convertedValue = inputValue * 0.621371;
        } else if (fromUnit == 'Kilometers' && toUnit == 'Feet') {
          convertedValue = inputValue * 3280.84;
        } else if (fromUnit == 'Miles' && toUnit == 'Meters') {
          convertedValue = inputValue * 1609.34;
        } else if (fromUnit == 'Miles' && toUnit == 'Kilometers') {
          convertedValue = inputValue * 1.60934;
        } else if (fromUnit == 'Miles' && toUnit == 'Feet') {
          convertedValue = inputValue * 5280;
        } else if (fromUnit == 'Feet' && toUnit == 'Meters') {
          convertedValue = inputValue * 0.3048;
        } else if (fromUnit == 'Feet' && toUnit == 'Kilometers') {
          convertedValue = inputValue * 0.0003048;
        } else if (fromUnit == 'Feet' && toUnit == 'Miles') {
          convertedValue = inputValue * 0.000189394;
        }
      } else {
        // Mass unit conversions.
        if (fromUnit == 'Grams' && toUnit == 'Kgs') {
          convertedValue = inputValue / 1000;
        } else if (fromUnit == 'Grams' && toUnit == 'Pounds') {
          convertedValue = inputValue * 0.00220462;
        } else if (fromUnit == 'Kgs' && toUnit == 'Grams') {
          convertedValue = inputValue * 1000;
        } else if (fromUnit == 'Kgs' && toUnit == 'Pounds') {
          convertedValue = inputValue * 2.20462;
        } else if (fromUnit == 'Pounds' && toUnit == 'Grams') {
          convertedValue = inputValue * 453.592;
        } else if (fromUnit == 'Pounds' && toUnit == 'Kgs') {
          convertedValue = inputValue / 2.20462;
        }
      }
    });
  }

  /// Handles changes to the input value.
  /// Validates the input and updates the state accordingly.
  void handleInputChange(String value) {
    final input = double.tryParse(value); // Try to parse the input as a double.
    if (input != null) {
      // If the input is valid, update the state.
      setState(() {
        inputValue = input;
        errorMessage = ""; // Clear any error message.
        isConvertButtonEnabled = true; // Enable the convert button.
        convertedValue = 0.0; // Reset the converted value.
      });
    } else {
      // If the input is invalid, show an error message.
      setState(() {
        inputValue = 0.0;
        errorMessage = "Please enter only numbers"; // Set the error message.
        isConvertButtonEnabled = false; // Disable the convert button.
        convertedValue = 0.0; // Reset the converted value.
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Set the system UI overlay style (status bar color and icon brightness).
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.lightBlue, // Light blue status bar.
        statusBarIconBrightness: Brightness.light, // White icons.
      ),
    );

    return Scaffold(
      // Remove the default app bar.
      appBar: null,
      body: Column(
        children: [
          // Custom app bar with light blue background.
          Container(
            width: double.infinity, // Span the entire width.
            padding: const EdgeInsets.only(
              top: 50, // Add padding to account for the status bar.
              bottom: 20,
            ),
            color: Colors.lightBlue, // Light blue background.
            child: const Center(
              child: Text(
                'Measurement Converter',
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white, // White text.
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          // Rest of the body content.
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Value input field with padding after it.
                  const Text(
                    'Value',
                    style: TextStyle(fontSize: 20, color: Colors.grey),
                  ),
                  const SizedBox(height: 15), // Space between Value label and input field.
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: TextField(
                      decoration: const InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                      ),
                      keyboardType: TextInputType.number, // Numeric keyboard.
                      style: const TextStyle(fontSize: 24),
                      onChanged: handleInputChange, // Handle input changes.
                    ),
                  ),
                  const SizedBox(height: 25), // Extra space between Value box and From label.

                  // "From" unit dropdown.
                  const Text(
                    'From',
                    style: TextStyle(fontSize: 20, color: Colors.grey),
                  ),
                  const SizedBox(height: 15), // Space between From label and dropdown.
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Container(
                      width: double.infinity,
                      child: DropdownButton<String>(
                        value: fromUnit,
                        onChanged: (String? newValue) {
                          setState(() {
                            fromUnit = newValue!; // Update the "from" unit.
                            toUnit = getValidToUnits()[0]; // Reset the "to" unit.
                            convertedValue = 0.0; // Reset the converted value.
                          });
                        },
                        isExpanded: true,
                        items: [...lengthUnits, ...massUnits]
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value, style: const TextStyle(fontSize: 18)),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 25), // Extra space between From and To.

                  // "To" unit dropdown.
                  const Text(
                    'To',
                    style: TextStyle(fontSize: 20, color: Colors.grey),
                  ),
                  const SizedBox(height: 15), // Space between To label and dropdown.
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Container(
                      width: double.infinity,
                      child: DropdownButton<String>(
                        value: toUnit,
                        onChanged: (String? newValue) {
                          setState(() {
                            toUnit = newValue!; // Update the "to" unit.
                            convertedValue = 0.0; // Reset the converted value.
                          });
                        },
                        isExpanded: true,
                        items: getValidToUnits().map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value, style: const TextStyle(fontSize: 18)),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 35), // Extra space between To and Convert Button.

                  // Convert button.
                  ElevatedButton(
                    onPressed: isConvertButtonEnabled ? convert : null, // Enable/disable button.
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[300], // Light gray background.
                      foregroundColor: Colors.blue, // Light blue text.
                    ),
                    child: const Text('Convert', style: TextStyle(fontSize: 20)),
                  ),
                  const SizedBox(height: 35), // Extra space between Convert Button and Result text.

                  // Display the conversion result or a placeholder message.
                  Text(
                    inputValue > 0
                        ? '$inputValue $fromUnit are ${convertedValue.toStringAsFixed(2)} $toUnit'
                        : 'Click convert',
                    style: const TextStyle(fontSize: 24),
                    textAlign: TextAlign.center,
                  ),
                  // Display an error message if the input is invalid.
                  if (errorMessage.isNotEmpty)
                    Text(
                      errorMessage,
                      style: const TextStyle(color: Colors.red, fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}