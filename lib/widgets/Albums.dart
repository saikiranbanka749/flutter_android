class Albums {
  final String apartment_name;
  final String community_name;
  final String no_of_plots;
  final String no_of_floors;
  final String plot_per_floor;
  final String available_flats;
  final String filled_flats;

  Albums({
    required this.apartment_name,
    required this.community_name,
    required this.no_of_plots,
    required this.no_of_floors,
    required this.plot_per_floor,
    required this.available_flats,
    required this.filled_flats,
  });

  factory Albums.fromJson(Map<String, dynamic> json) {
    return Albums(
      community_name: json['community_name'] as String? ?? 'N/A',
      apartment_name: json['apartment_name'] as String? ?? 'N/A',
      no_of_plots: json['no_of_plots']?.toString() ?? '0',
      no_of_floors: json['no_of_floors']?.toString() ?? '0',
      plot_per_floor: json['plot_per_floor']?.toString() ?? '0',
      available_flats: json['available_flats']?.toString() ?? '0',
      filled_flats: json['filled_flats']?.toString() ?? '0',
    );
  }
}
