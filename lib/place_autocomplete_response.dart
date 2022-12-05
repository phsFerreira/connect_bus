// import 'dart:convert';
// import 'autocomplete_predictions.dart';

// // The Autocomplete response contains place predictions and status
// class PlacesAutocompleteResponse{
//   final String? status;
//   final List<AutocompletePrediction>? predictions;

//   PlacesAutocompleteResponse({this.status, this.predictions});

//    factory PlacesAutocompleteResponse.fromJson(Map<String, dynamic> json) {
//     return PlacesAutocompleteResponse (
//       status: json['status'] as String?,                                  I
//       predictions: json['predictions'] != null
//           ? json['predictions']
//            .map<AutocompletePrediction>(
//                    (json) => AutocompletePrediction.fromJson(json))
//                .toList()
//            : null,
//     );
//    }

//    static PlacesAutocompleteResponse parseAutocompleteResult(
//     String responseBody) {
//    final parsed = json.decode(responseBody).cast<String, dynamic>();

//    return PlacesAutocompleteResponse.fromJson(parsed);
//     }
// }