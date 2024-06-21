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

Future<List<ContractsStruct>> parseListContracts(
    List<dynamic> responseApi, String type) async {
  List<ContractsStruct> response = [];

  int index = 0;
  if (type == "purchase") {
    index = 1;
  }

  for (var item in responseApi) {
    ContractsStruct obj = new ContractsStruct();
    obj.folio = item['folio'];
    obj.date = item['created_at'];
    obj.quantity = item['quantity'];
    obj.type = item['type'];

    var prices = item['price_schedule'];
    if (prices is List && prices.isNotEmpty) {
      var firstPrice = prices[0];
      obj.price = firstPrice['price'];
      obj.basis = firstPrice['basis'];
      obj.priceType = firstPrice['pricing_type'];
    }

    var commodity = item['commodity'];
    obj.commodityName = commodity['name'];
    obj.commodityId = commodity['commodity_id'];

    var participants = item['participants'];
    if (participants is List && participants.isNotEmpty) {
      if (participants.length > index) {
        var firstParticipant = participants[index];
        obj.customer = firstParticipant['name'];
      }
    }
    obj.id = item['_id'];
    obj.measurementUnit = item['measurement_unit'];
    obj.shippingStartDate = item['shipping_start_date'];
    obj.shippingEndDate = item['shipping_end_date'];

    response.add(obj);
  }

  return response;
  // Add your function code here!
}
