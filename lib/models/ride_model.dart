class RideModel {
  final String driverId;
  final String driverName;
  final String driverProfileImage;

  final String origin;
  final String destination;
  final DateTime departureTime;
  final int totalSeats;
  int availableSeats = 0;
  final double pricePerSeat;
  final String carModel;
  final String carPlateNumber;

  RideModel({
    required this.driverId,
    required this.driverName,
    required this.driverProfileImage,
    required this.origin,
    required this.destination,
    required this.departureTime,
    required this.totalSeats,
    required this.pricePerSeat,
    required this.carModel,
    required this.carPlateNumber,
  });
}
