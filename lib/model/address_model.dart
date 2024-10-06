class AddressModel {
  final String id;
  final String address;
  final String city;
  final String? noteToRider;

  AddressModel(
      {required this.id,
      required this.address,
      required this.city,
      this.noteToRider});
}
