    


import 'package:flutter/material.dart';

Map<String, Function()> blendModeMap={
    
    "Normal":() => BlendMode.clear,
    "Color Burn":() => BlendMode.colorBurn,
    "Color Dodge":() => BlendMode.colorDodge,
    "Saturation":() => BlendMode.saturation,
    "Hue":() => BlendMode.hue,
    "Soft light":() => BlendMode.softLight,
    "Overlay":() => BlendMode.overlay,
    "Multiply":() => BlendMode.multiply,
    "Luminosity":() => BlendMode.luminosity,
    "Plus":() => BlendMode.plus,
    "Exclusion":() => BlendMode.exclusion,
    "Hard Light":() => BlendMode.hardLight,
    "Lighten":() => BlendMode.lighten,
    "Screen":() => BlendMode.screen,
    "Modulate":() => BlendMode.modulate,
    "Difference":() => BlendMode.difference,
    "Darken":() => BlendMode.darken,
};