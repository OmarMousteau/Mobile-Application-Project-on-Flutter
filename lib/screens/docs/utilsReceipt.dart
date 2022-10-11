
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:login_signin/screens/docs/receiptex.dart';

import '/screens/docs/receiptex.dart';

class UtilsReceipt {

  static List<ReceiptsEX> getMockedCategories() {
    return [
      ReceiptsEX(
        color: Colors.blueAccent,
        name : "Kayak 17/06",
        imgName: "TicketKayak",
        subRec: []
      ),

      ReceiptsEX(
        color: Colors.blueAccent,
        name : "Carrefour 02/02",
        imgName: "TicketCarrefour",
        subRec: []
      ),

      ReceiptsEX(
        color: Colors.blueAccent,
        name : "Pharmacie Alençon 03/10",
        imgName: "TicketPharmacie",
        subRec: []
      ),

      ReceiptsEX(
        color: Colors.blueAccent,
        name : "Restaurant 01/03",
        imgName: "TicketResto",
        subRec: []
      )
    ];
  }
}