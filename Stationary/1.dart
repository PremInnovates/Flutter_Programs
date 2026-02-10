import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

Future<List<dynamic>> loadProducts() async {
  final String response = await rootBundle.loadString('assets/db.json');
  return json.decode(response);
}


void main() => runApp(const RolexyApp());

class RolexyApp extends StatelessWidget {
  const RolexyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rolex-Style Stationery',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF006039), // Rolex Green
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF006039),
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFA37E2C), // Gold
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            textStyle: const TextStyle(fontWeight: FontWeight.w700),
          ),
        ),
      ),
      home: const StationeryHome(),
    );
  }
}

/// Product model (type-safe)
class Product {
  final String name;
  final num price;
  final String image; // asset path ya network URL

  const Product({
    required this.name,
    required this.price,
    required this.image,
  });

  bool get isNetwork => image.startsWith('http');
}

class StationeryHome extends StatelessWidget {
  const StationeryHome({super.key});

  static const List<Product> products = [
    Product(
      name: 'ANGEL DOLL',
      price: 499,
      image: 'assets/images/angel_girl.png', // ✅ asset image
    ),
    Product(
      name: 'BIG CADBURY CELEBRATION',
      price: 159,
      image: 'assets/images/cadburyCelebration.png',
    ),
    Product(
      name: 'FEVICRYL COLOURS',
      price: 249,
      image: 'assets/images/fevicryl_Colours.png',
    ),
    Product(
      name: 'CAMEL ART KIT',
      price: 99,
      image: 'assets/images/CamelArtKit.png',
    ),
    Product(
      name: 'WHITE PEN',
      price: 79,
      image: 'assets/images/white_Pen.png',
    ),
    Product(
      name: 'FOLDABLE STUDY TABLE',
      price: 499,
      image: 'assets/images/foldable_table.png',
    ),
    Product(
      name: 'CAMEL FOUNTAIN PEN INK (RED)',
      price: 24,
      image: 'assets/images/camelfountaininkred.png',
    ),
    Product(
      name: 'CLOTH DRY ROPE',
      price: 79,
      image: 'assets/images/clothdryrope.png',
    ),
    Product(
      name: 'MANIQUEE (SET OF 4)',
      price: 449,
      image: 'assets/images/marquee.png',
    ),
    Product(
      name: 'DOMS PERMANENT MARKER (BLACK)',
      price: 199,
      image: 'assets/images/domswhiteboardmarker.png',
    ),
    Product(
      name: 'MAKE-UP BOX TOYS',
      price: 499,
      image: 'assets/images/makeuptoy.png',
    ),
    Product(
      name: 'CLASSMATE AVENGERS INVENTO COMPASS',
      price: 149,
      image: 'assets/images/classmateavengercompass.png',
    ),
    Product(
      name: 'CAMLIN PAINT MARKER BOLD-E',
      price: 549,
      image: 'assets/images/camlinpaintmarker.png',
    ),
    Product(
      name: 'ARTIFICIAL DECORATIVE FLOWER STRING BUNCH',
      price: 219,
      image: 'assets/images/flower.png',
    ),
    Product(
      name: 'CAMLIN PERMANENT MARKER BLACK',
      price: 99,
      image: 'assets/images/camlinmarker10.png',
    ),
    Product(
      name: 'DOMS AQUA COLOUR CAKES 12 SHADES',
      price: 64,
      image: 'assets/images/domsaquacolour12.png',
    ),
    Product(
      name: 'CAMLIN WHITEBOARD MARKER INK (RED)',
      price: 29,
      image: 'assets/images/camlinwhiteboardmarkerink(red).png',
    ),
    Product(
      name: 'CAMLIN PERMANENT INK (BLUE) 100ML',
      price: 209,
      image: 'assets/images/camlinpermanentmarkerinkblue.png',
    ),
    Product(
      name: 'NAVO VYAPAR',
      price: 219,
      image: 'assets/images/navovepar.png',
    ),
    Product(
      name: 'DOMS SMART KIT',
      price: 499,
      image: 'assets/images/domssmartkit.png',
    ),
    Product(
      name: 'CASIO CALCULATOR',
      price: 489,
      image: 'assets/images/casiocalculator.png',
    ),
    Product(
      name: 'CADBURY CELEBRATION',
      price: 49,
      image: 'assets/images/cadburyCelebration1.png',
    ),
    Product(
      name: 'TAPE DISPENSER',
      price: 69,
      image: 'assets/images/tapedispenser.png',
    ),
    Product(
      name: 'SHOOK PEN',
      price: 79,
      image: 'assets/images/shockpen.png',
    ),
    Product(
      name: 'UNICORN LUDO WITH SNAKES & LADDERS',
      price: 199,
      image: 'assets/images/unicornludo.png',
    ),
    Product(
      name: 'LOVING FAMILY HOUSE',
      price: 439,
      image: 'assets/images/lovingfamilyhouse.png',
    ),
    Product(
      name: 'DECORATIVE ARTIFICIAL WISTERIA FLOWER BUNCH (SET OF 12)',
      price: 329,
      image: 'assets/images/decorativeflower.png',
    ),
    Product(
      name: 'CAMLIN RUBBER STAMP INK',
      price: 34,
      image: 'assets/images/camlinrubberstampink.png',
    ),
    Product(
      name: 'SAINO SOFTEK',
      price: 80,
      image: 'assets/images/sainosoftek.png',
    ),
    Product(
      name: 'DOMS WHITEBOARD MARKER PEN (RED)',
      price: 249,
      image: 'assets/images/domswhitemarkerink(red).png',
    ),
    Product(
      name: 'FOLDABLE STUDY TABLE',
      price: 499,
      image: 'assets/images/foldableStudytable.png',
    ),
    Product(
      name: 'CAMLIN PERMANENT INK (RED)',
      price: 24,
      image: 'assets/images/camlinpermanenetinkred.png',
    ),
    Product(
      name: 'DOMS SUPERIO PENCILS',
      price: 125,
      image: 'assets/images/domssuperiopencil.png',
    ),
    Product(
      name: 'CAMLIN PERMANENT INK (BLUE)',
      price: 25,
      image: 'assets/images/camlinpermanentinkblure.png',
    ),
    Product(
      name: 'CAMLIN WHITEBOARD MARKER INK (BLACK)',
      price: 29,
      image: 'assets/images/camlinwhiteboardmarkerinkblack.png',
    ),
    Product(
      name: 'UNO AVENGERS CARD GAME',
      price: 99,
      image: 'assets/images/unoavenger.png',
    ),
    Product(
      name: 'SHOOK CHEWING GUM',
      price: 79,
      image: 'assets/images/shookchewinggum.png',
    ),
    Product(
      name: 'ROYAL LUDO & SNAKES AND LADDERS',
      price: 179,
      image: 'assets/images/royaludo.png',
    ),
    Product(
      name: 'FLAIR DIAMOND PENCIL',
      price: 99,
      image: 'assets/images/flairdiamondpencil.png',
    ),
    Product(
      name: 'BOX FILE',
      price: 109,
      image: 'assets/images/boxfile.png',
    ),
    Product(
      name: 'CAMLIN MARKER (RED)',
      price: 99,
      image: 'assets/images/camlinmarker(red).png',
    ),
    Product(
      name: 'PASSPORT FOLDER',
      price: 319,
      image: 'assets/images/passportfolder.png',
    ),
    Product(
      name: 'DOMS AQUA COLOUR CAKES 24 SHADES',
      price: 119,
      image: 'assets/images/domsaquacolourcake.png',
    ),
    Product(
      name: 'NAVO VYAPAR',
      price: 279,
      image: 'assets/images/newvyapar.png',
    ),
    Product(
      name: 'STUDY BOOK INTELLECTUAL LEARNING',
      price: 489,
      image: 'assets/images/studybook.png',
    ),
    Product(
      name: 'SAINO TRIO',
      price: 80,
      image: 'assets/images/sainotrio.png',
    ),
    Product(
      name: 'ORBIT CALCULATOR',
      price: 119,
      image: 'assets/images/orbitcalculator.png',
    ),
    Product(
      name: 'CAMLIN FOUNTAIN INK (BLACK)',
      price: 29,
      image: 'assets/images/camlinfountainink(black).png',
    ),
    Product(
      name: 'TAPE DISPENSER',
      price: 159,
      image: 'assets/images/bigtapedispenser.png',
    ),
    Product(
      name: 'CLASSMATE FOUR-LINE NOTE (SET OF 12)',
      price: 624,
      image: 'assets/images/classmatefourline.png',
    ),
    Product(
      name: 'UNO CARDS',
      price: 59,
      image: 'assets/images/uno.png',
    ),
    Product(
      name: 'REMOTE CONTROL CAR 360 DEGREE',
      price: 720,
      image: 'assets/images/remotecontrolcar360degree.png',
    ),
    Product(
      name: 'DECORATIVE HANGING ORNAMENT',
      price: 49,
      image: 'assets/images/decorativehangingornament.png',
    ),
    Product(
      name: 'WISDOM GAME',
      price: 149,
      image: 'assets/images/wisdomgame.png',
    ),
    Product(
      name: 'CADBURY CELEBRATION – (Assorted Gift Pack)',
      price: 109,
      image: 'assets/images/cadburycelebrationspark.png',
    ),
    Product(
      name: 'DECORATIVE ARTIFICIAL MAPLE LEAF BUNCH (SET OF 12)',
      price: 339,
      image: 'assets/images/decorativeartificialmapleleaf.png',
    ),
    Product(
      name: 'DOMS GEOMITI',
      price: 99,
      image: 'assets/images/domsgeomiti.png',
    ),
    Product(
      name: 'CAMEL BRUSH PEN 24 SHADES',
      price: 439,
      image: 'assets/images/camelbrushpen24shades.png',
    ),
    Product(
      name: 'CLOTH HANGER (SET OF 12)',
      price: 79,
      image: 'assets/images/clothhanger.png',
    ),
    Product(
      name: 'CAMLIN WHITE BOARD INK (BLACK) 100ML',
      price: 239,
      image: 'assets/images/camlinwhiteboardink(black)100ml.png',
    ),
    Product(
      name: 'UNO DRAGON BALL Z',
      price: 99,
      image: 'assets/images/unodragonballz.png',
    ),
    Product(
      name: 'CAMLIN PASTE (700ML)',
      price: 69,
      image: 'assets/images/camlinpaste700ml.png',
    ),
    Product(
      name: 'MB MODEL CAR',
      price: 319,
      image: 'assets/images/mbmodelcar.png',
    ),
    Product(
      name: 'DOMS GROOVE ERASER',
      price: 24,
      image: 'assets/images/domsgrooveeraser.png',
    ),
    Product(
      name: 'PEXON LCD PENCIL BOX',
      price: 219,
      image: 'assets/images/pexonlcdpencilbox.png',
    ),
    Product(
      name: 'CAMEL STUDENT POSTER COLOURS',
      price: 209,
      image: 'assets/images/camelstudentpotercolours.png',
    ),
    Product(
      name: 'UNO FROZEN-II GAME CARD',
      price: 99,
      image: 'assets/images/unofrozen-iigamecard.png',
    ),
    Product(
      name: 'SAINO MISTI',
      price: 80,
      image: 'assets/images/sainomisti.png',
    ),
    Product(
      name: 'ORBIT SMALL CALCULATOR',
      price: 79,
      image: 'assets/images/orbitsmallcalculator.png',
    ),
    Product(
      name: 'TUMBLE TOWER',
      price: 399,
      image: 'assets/images/tumbletower.png',
    ),
    Product(
      name: 'CAMLIN BOLD-E WHITE BOARD MARKER (BLACK)',
      price: 279,
      image: 'assets/images/camlinboldewhiteboardmarker(black).png',
    ),
    Product(
      name: 'TENNIS TRAINER',
      price: 299,
      image: 'assets/images/tennistrainer.png',
    ),
    Product(
      name: 'MIDI CHESS – THE BATTLE OF BRAINS',
      price: 299,
      image: 'assets/images/midichess.png',
    ),
    Product(
      name: 'FROZEN FEVER MONEY BANK',
      price: 199,
      image: 'assets/images/frozenfevermoneybank.png',
    ),
    Product(
      name: 'DOMS AMARIZ KNEADABLE ART ERASER',
      price: 54,
      image: 'assets/images/domsamarizarteraser.png',
    ),
    Product(
      name: 'DOMS KIT',
      price: 99,
      image: 'assets/images/domskit.png',
    ),
    Product(
      name: 'CLASSMATE VICTOR COMPASS',
      price: 89,
      image: 'assets/images/classmatevictorcompass.png',
    ),
    Product(
      name: 'ELEGENT LORD GANESHA LED SHOWPIECE',
      price: 299,
      image: 'assets/images/elegantloadganeshaled.png',
    ),
    Product(
      name: 'KIDS PIANO',
      price: 279,
      image: 'assets/images/kidspiano.png',
    ),
    Product(
      name: 'ARTIFICIAL FLOWER GARLAND',
      price: 149,
      image: 'assets/images/artificialflowergarland.png',
    ),
    Product(
      name: 'GOOD KNIGHT REFILL',
      price: 35,
      image: 'assets/images/goodknightrefill.png',
    ),
    Product(
      name: 'SANDISK 64GB PEN-DRIVE',
      price: 599,
      image: 'assets/images/sandisk64gbpendrive.png',
    ),
    Product(
      name: 'TRANSPARENT FILE',
      price: 29,
      image: 'assets/images/trasnparentfile.png',
    ),
    Product(
      name: 'CADBURY CELEBRATIONS PREMIUM SELECTIONS',
      price: 224,
      image: 'assets/images/cadburycelebrationpremium.png',
    ),
    Product(
      name: 'CLOTH DRY ROPE WITH PIN',
      price: 109,
      image: 'assets/images/clothdryropewithpin.png',
    ),
    Product(
      name: 'FOLDABLE STUDY TABLE',
      price: 499,
      image: 'assets/images/foldablestudytablecar.png',
    ),
    Product(
      name: 'ARTIFICIAL DECORATIVE FLOWER STRING BUNCH',
      price: 219,
      image: 'assets/images/artificialdecorativeflowers.png',
    ),
    Product(
      name: 'CAMLIN EXAM COMPASS',
      price: 149,
      image: 'assets/images/camlinexamcompass.png',
    ),
    Product(
      name: 'CAMLIN FOUNTAIN PEN INK (BLUE)',
      price: 29,
      image: 'assets/images/camlinfountainpenink(blue).png',
    ),
    Product(
      name: 'TABLE INDIAN FLAG',
      price: 79,
      image: 'assets/images/tableindianflag.png',
    ),
    Product(
      name: 'ARTIFICIAL LEAF GARLAND',
      price: 29,
      image: 'assets/images/artificialleafgarland.png',
    ),
    Product(
      name: 'PIN-O-CLIP',
      price: 49,
      image: 'assets/images/pinoclip.png',
    ),
    Product(
      name: 'SET-UP BOX REMOTE CONTROL',
      price: 79,
      image: 'assets/images/setupboxremotecontrol.png',
    ),
    Product(
      name: 'UNO CRIKET CARDS',
      price: 140,
      image: 'assets/images/unocriketcards.png',
    ),
    Product(
      name: 'NANO TAPE',
      price: 79,
      image: 'assets/images/nanotape.png',
    ),
    Product(
      name: 'FOLDABLE STUDY TABLE',
      price: 499,
      image: 'assets/images/foldablestudytablelion.png',
    ),
    Product(
      name: 'CAMLIN WHITEBOARD MARKER (GREEN)',
      price: 279,
      image: 'assets/images/camlinwhiteboardmarker(grenn).png',
    ),
    Product(
      name: '3D CHARGEABLE REMOTE CONTROL CAR',
      price: 599,
      image: 'assets/images/3dchargeablecar.png',
    ),
    Product(
      name: 'CAMLIN WHITE BOARD MARKER INK',
      price: 29,
      image: 'assets/images/camlinwhiteboardmarkerink.png',
    ),
    Product(
      name: 'GOLDEN FOIL DECORATIVE GARLAND',
      price: 39,
      image: 'assets/images/goldenfoildecorativegarland.png',
    ),
    Product(
      name: 'FILE SET (SET OF 6 PICS)',
      price: 119,
      image: 'assets/images/fileset.png',
    ),
    Product(
      name: 'CLTLZEN BLACK CALCULATOR',
      price: 99,
      image: 'assets/images/cltlzenblackcalculator.png',
    ),
    Product(
      name: 'PROFESSIONAL LEATHER DOCUMENT FILE FOLDER',
      price: 319,
      image: 'assets/images/professionalleatherdocumentfilefolder.png',
    ),
    Product(
      name: 'SEWING MACHINE LIGHT',
      price: 149,
      image: 'assets/images/sewingmachinelight.png',
    ),
    Product(
      name: 'DECORATIVE LORD GANESHA LIGHT SHOWPIECE',
      price: 179,
      image: 'assets/images/decorativelordganeshalight.png',
    ),
    Product(
      name: 'CAMEL ACRYLIC COLOURS',
      price: 249,
      image: 'assets/images/camelacryliccolours.png',
    ),
    Product(
      name: 'RADHEY KRISHNA LED LIGHT SHOWPIECE',
      price: 249,
      image: 'assets/images/radheykrishnaledlightshowpiece.png',
    ),
    Product(
      name: 'TRADITIONAL METALLIC FOIL DECORATIVE HANGING',
      price: 29,
      image: 'assets/images/traditionalmetallicfoildecorative.png',
    ),
    Product(
      name: 'CAMLIN SCHOLAR BASICS',
      price: 99,
      image: 'assets/images/camlinscholarbasics.png',
    ),
    Product(
      name: 'GTPL SET-UP BOX REMOTE',
      price: 79,
      image: 'assets/images/gtplsetupboxremote.png',
    ),
    Product(
      name: 'PLASTIC KIDS SAFETY CRAFT SCISSORS',
      price: 29,
      image: 'assets/images/plasticsafetyscissors.png',
    ),
    Product(
      name: 'CAMLIN PASTE (50ML)',
      price: 19,
      image: 'assets/images/camlinpaste50ml.png',
    ),
    Product(
      name: 'CITLIZEN CALCULATOR',
      price: 119,
      image: 'assets/images/citizencalculator.png',
    ),
    Product(
      name: 'CAMLIN PASTE (150ML)',
      price: 29,
      image: 'assets/images/camlinpaste150ml.png',
    ),
    Product(
      name: 'CACTUS TOY',
      price: 459,
      image: 'assets/images/cactustoy.png',
    )
  ];

  @override
  Widget build(BuildContext context) {
    const gold = Color(0xFFA37E2C);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'ANJALI GENERAL STORE',
          style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.1),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart_outlined),
            onPressed: () {},
          ),
        ],
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(14),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 14,
          mainAxisSpacing: 14,
          childAspectRatio: 0.62, // taller cards
        ),
        itemCount: products.length,
        itemBuilder: (context, i) =>
            StationeryCard(product: products[i], gold: gold),
      ),
    );
  }
}

class StationeryCard extends StatelessWidget {
  final Product product;
  final Color gold;

  const StationeryCard({
    super.key,
    required this.product,
    required this.gold,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: gold.withOpacity(0.55), width: 1.2),
        boxShadow: [
          BoxShadow(
            color: gold.withOpacity(0.18),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          // Image Area
          Expanded(
            flex: 7,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: product.isNetwork
                  ? Image.network(
                product.image,
                fit: BoxFit.contain,
                loadingBuilder: (context, child, progress) =>
                progress == null
                    ? child
                    : const Center(
                  child: CircularProgressIndicator(),
                ),
                errorBuilder: (context, error, stack) => const Center(
                  child: Icon(Icons.broken_image_outlined, size: 40),
                ),
              )
                  : Image.asset(
                product.image,
                fit: BoxFit.contain,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            product.name,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: const Color(0xFF006039),
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            '₹${product.price}',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: gold,
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('${product.name} added to cart')),
                );
              },
              child: const Text('Add to Cart'),
            ),
          ),
        ],
      ),
    );
  }
}
