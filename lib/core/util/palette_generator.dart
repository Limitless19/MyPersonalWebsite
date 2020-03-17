import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';
 
Future<PaletteGenerator> generatePalette(String imagePath) async {
    PaletteGenerator _palette = await PaletteGenerator.fromImageProvider(
      AssetImage(imagePath),
      size: Size(40, 40),
      maximumColorCount: 20,
    );
    return _palette;
  }


//TODO SELECTCARD COLORS FROM IMAGE PROVIDED
  hdhf(){

   // PaletteGenerator.fromImageProvider(Image.network(src).image);
  }