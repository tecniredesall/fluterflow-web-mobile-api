// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/backend/schema/enums/enums.dart';
import '/actions/actions.dart' as action_blocks;
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import '/backend/api_requests/api_interceptor.dart';

class subContractsInterceptor extends FFApiInterceptor {
  @override
  Future<ApiCallOptions> onRequest({
    required ApiCallOptions options,
  }) async {
    // Perform any necessary calls or modifications to the [options] before
    // the API call is made.
    return options;
  }

  @override
  Future<ApiCallResponse> onResponse({
    required ApiCallResponse response,
    required Future<ApiCallResponse> Function() retryFn,
  }) async {
    // Perform any necessary calls or modifications to the [response] prior
    // to returning it.

    response.jsonBody['isIterable'] = false;

    List<dynamic> subContracts = [];

    if (response.jsonBody.containsKey('data')) {
      if (response.jsonBody['data'].isNotEmpty) {
        response.jsonBody['isIterable'] = true;

        List<String> listColors = [
          '#74dbe4',
          '#e98f51',
          '#8f46e9',
          '#27a51f',
          '#3e8dd0',
          '#6f28cb',
          '#e27396',
          '#2536a4',
          '#c6a15b',
          '#ffe2d1'
        ];

        int i = 0;

        for (var item in response.jsonBody['data']) {
          double priceNumber = 0.00;
          double basisNumber = 0.00;
          String currencyUnit = '-';

          double quantityNumber =
              item.containsKey('quantity') ? item['quantity'] : 0.00;

          double quantityNumberPie =
              quantityNumber > 0 ? (item['quantity'] / 1000) : 0.00;

          double totalNumber =
              item.containsKey('total_price') ? item['total_price'] : 0.00;

          String quantityUnits = getFormatNumber(quantityNumber);
          String quantityPieFormat = quantityNumberPie.toStringAsFixed(2);
          String totalPayment = getFormatNumber(totalNumber);
          String measurementUnit = item.containsKey('measurement_unit')
              ? item['measurement_unit']
              : '-';

          if (item.containsKey('price_schedule')) {
            if (item['price_schedule'].length > 0) {
              currencyUnit =
                  item['price_schedule'][0]['payment_currency'] == 'usd'
                      ? '\$'
                      : item['price_schedule'][0]['payment_currency'];

              priceNumber = item['price_schedule'][0]['price'];
              basisNumber = item['price_schedule'][0]['basis'];
            }
          }

          String contractPrice = getFormatNumber(priceNumber);
          String contractBasis = getFormatNumber(basisNumber);

          double deliveredNumber =
              item['status'] == 'settled' ? quantityNumber : 0;
          double percentageDelivered = deliveredNumber > 0 ? 1 : 0;

          String deliveredUnits = getFormatNumber(deliveredNumber);

          var itemSubContract = {
            'subContractId': item['_id'],
            'folio': item['folio'],
            'quantityUnits': '$quantityUnits $measurementUnit',
            'contractBasis': '$currencyUnit $contractBasis',
            'contractPrice': '$currencyUnit $contractPrice',
            'totalPayment': '$currencyUnit $totalPayment',
            'deliveredUnits': '$deliveredUnits $measurementUnit',
            'percentageDelivered': percentageDelivered,
            'quantityPie': double.parse(quantityPieFormat),
            'cardColor': i < listColors.length ? listColors[i] : '#000000',
            'subContractStatus': item['status'],
          };

          subContracts.add(itemSubContract);

          i++;
        }

        subContracts.sort((a, b) => b['folio'].compareTo(a['folio']));
      }
    }

    response.jsonBody['subContracts'] = subContracts;

    return response;
  }
}
