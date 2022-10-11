import 'dart:ui';

class ReceiptsEX{
  String name;
  Color color;
  String imgName;
  List<ReceiptsEX>subRec;
  
  ReceiptsEX(
    { 
      required this.name,
      required this.color,
      required this.imgName,
      required this.subRec
    }
 
 );

}