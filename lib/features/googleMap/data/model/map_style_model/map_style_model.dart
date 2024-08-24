class MapStyleModel {
  final int styleindex;
  final String stylephoto;
  final String stylename;
  final String stylejson;

  MapStyleModel(
      {required this.styleindex,
      required this.stylephoto,
      required this.stylename,
      required this.stylejson});
}

List<MapStyleModel> mapstylemodel = [
  MapStyleModel(
      styleindex: 0,
      stylephoto: 'assets/mapstylephoto/normal.JPG',
      stylename: 'Normal',
      stylejson: 'assets/mapstylejson/normal.json'),
  MapStyleModel(
      styleindex: 1,
      stylephoto: 'assets/mapstylephoto/silver.JPG',
      stylename: 'Silver',
      stylejson: 'assets/mapstylejson/silverStyle.json'),
  MapStyleModel(
      styleindex: 2,
      stylephoto: 'assets/mapstylephoto/night.JPG',
      stylename: 'Night',
      stylejson: 'assets/mapstylejson/night.json'),
  MapStyleModel(
      styleindex: 3,
      stylephoto: 'assets/mapstylephoto/retro.JPG',
      stylename: 'Retro',
      stylejson: 'assets/mapstylejson/retro.json'),
  MapStyleModel(
      styleindex: 4,
      stylephoto: 'assets/mapstylephoto/aubergine.JPG',
      stylename: 'Aubergine',
      stylejson: 'assets/mapstylejson/aubergine.json'),
  MapStyleModel(
      styleindex: 5,
      stylephoto: 'assets/mapstylephoto/red.JPG',
      stylename: 'Red',
      stylejson: 'assets/mapstylejson/red.json'),
  MapStyleModel(
      styleindex: 6,
      stylephoto: 'assets/mapstylephoto/dark.JPG',
      stylename: 'Dark',
      stylejson: 'assets/mapstylejson/dark.json'),
  MapStyleModel(
      styleindex: 7,
      stylephoto: 'assets/mapstylephoto/roads.JPG',
      stylename: 'Roads',
      stylejson: 'assets/mapstylejson/roads.json')
                   
];
