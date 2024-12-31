import 'package:dialog_flowtter/dialog_flowtter.dart';

class DialogflowService {
  late DialogFlowtter dialogFlowtter;

  // Initialize DialogFlowtter from credentials
  Future<void> init() async {
    try {
      dialogFlowtter = await DialogFlowtter.fromFile(); // Load credentials
      print("DialogFlowtter initialized successfully.");
    } catch (e) {
      print("Error initializing DialogFlowtter: $e");
    }
  }

  // Function to send a query to Dialogflow and receive the response
  Future<String> getResponse(String query) async {
    try {
      DetectIntentResponse response = await dialogFlowtter.detectIntent(
        queryInput: QueryInput(text: TextInput(text: query)),
      );

      if (response.message == null || response.message!.text == null) {
        return "Sorry, I didn't get that.";
      }

      return response.message!.text!.text![0]; // Return response message
    } catch (e) {
      print("Error getting response from Dialogflow: $e");
      return "An error occurred. Please try again.";
    }
  }
}