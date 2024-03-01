import 'package:sadulur/models/store_product.dart';

class UMKMStore {
  final String id;
  String? photoProfile;
  final String? umkmName;
  final String? description;
  final String? address;
  final String? city;
  final String? province;
  final String? phoneNumber;
  final String? facebook;
  final String? instagram;
  final String? tokopedia;
  final String? shopee;
  final String? bukalapak;
  String level;
  int totalAsset;
  int totalRevenue;
  int productionCapacity;
  int permanentWorkers;
  int nonPermanentWorkers;
  final List<String> tags;
  List<StoreProduct>? listProduct;
  DateTime? updatedAt;
  String? email;

  UMKMStore(
      {required this.id,
      this.umkmName,
      this.description,
      this.address,
      this.city,
      this.province,
      this.phoneNumber,
      this.facebook,
      this.instagram,
      this.tokopedia,
      this.shopee,
      this.bukalapak,
      required this.tags,
      this.level = "micro",
      this.photoProfile,
      this.listProduct,
      this.totalRevenue = 0,
      this.totalAsset = 0,
      this.productionCapacity = 0,
      this.permanentWorkers = 0,
      this.nonPermanentWorkers = 0,
      this.email,
      this.updatedAt});

  UMKMStore addProduct(StoreProduct product) {
    List<StoreProduct>? updatedListProduct;
    if (listProduct != null) {
      updatedListProduct = List.from(listProduct!);
    } else {
      updatedListProduct = [];
    }
    updatedListProduct.add(product);

    return UMKMStore(
      id: id,
      umkmName: umkmName,
      description: description,
      address: address,
      city: city,
      province: province,
      phoneNumber: phoneNumber,
      facebook: facebook,
      instagram: instagram,
      tokopedia: tokopedia,
      shopee: shopee,
      bukalapak: bukalapak,
      tags: List.from(tags),
      email: email,
      listProduct: updatedListProduct,
    );
  }

  void addListProduct(List<StoreProduct> products) {
    listProduct ??= [];
    listProduct!.addAll(products);
  }

  UMKMStore copyWith(
      {String? id,
      String? photoProfile,
      String? umkmName,
      String? description,
      String? address,
      String? city,
      String? province,
      String? phoneNumber,
      String? facebook,
      String? instagram,
      String? tokopedia,
      String? shopee,
      String? bukalapak,
      String? level,
      int? totalAsset,
      int? totalRevenue,
      int? productionCapacity,
      int? permanentWorkers,
      int? nonPermanentWorkers,
      List<String>? tags,
      String? email,
      List<StoreProduct>? listProduct,
      DateTime? updatedAt}) {
    return UMKMStore(
        id: id ?? this.id,
        photoProfile: photoProfile ?? this.photoProfile,
        umkmName: umkmName ?? this.umkmName,
        description: description ?? this.description,
        address: address ?? this.address,
        city: city ?? this.city,
        province: province ?? this.province,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        facebook: facebook ?? this.facebook,
        instagram: instagram ?? this.instagram,
        tokopedia: tokopedia ?? this.tokopedia,
        shopee: shopee ?? this.shopee,
        bukalapak: bukalapak ?? this.bukalapak,
        level: level ?? this.level,
        totalAsset: totalAsset ?? this.totalAsset,
        totalRevenue: totalRevenue ?? this.totalRevenue,
        productionCapacity: productionCapacity ?? this.productionCapacity,
        permanentWorkers: permanentWorkers ?? this.permanentWorkers,
        nonPermanentWorkers: nonPermanentWorkers ?? this.nonPermanentWorkers,
        tags: tags ?? this.tags,
        listProduct: listProduct ?? this.listProduct,
        email: email ?? this.email,
        updatedAt: updatedAt ?? this.updatedAt);
  }

  void changePhotoProfile(String? photo) {
    photoProfile ??= "";
    photoProfile = photo;
  }

  factory UMKMStore.empty() {
    return UMKMStore(
      id: '',
      tags: [],
    );
  }

  factory UMKMStore.fromMap(
      Map<String, dynamic> data, String id, String email) {
    return UMKMStore(
      id: id,
      umkmName: data["umkmName"],
      description: data["description"],
      address: data["address"],
      city: data["city"],
      province: data["province"],
      phoneNumber: data["phoneNumber"],
      facebook: data["facebookAcc"],
      instagram: data["instagramAcc"],
      tokopedia: data["tokopediaName"],
      bukalapak: data["bukalapakName"],
      shopee: data["shopeeName"],
      photoProfile: data["profilePicture"],
      totalRevenue: data["revenue"] ?? 0,
      totalAsset: data["asset"] ?? 0,
      level: data["level"] ?? "micro",
      productionCapacity: data["production"] ?? 0,
      permanentWorkers: data["permanentWorkers"] ?? 0,
      nonPermanentWorkers: data["nonPermanentWorkers"] ?? 0,
      email: email,
      tags: List<String>.from(data['tags'] ?? []),
    );
  }
}
