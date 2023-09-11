import 'package:web_app/service/base_entity.dart';

class ProductManagerModel extends BaseEntity {
  int? currentPage;
  int? step;
  int? totalPages;
  String? keyword;
  List<Product>? product;

  Product? item;

  ProductManagerModel(
      {this.currentPage,
      this.step,
      this.totalPages,
      this.keyword,
      this.product});

  ProductManagerModel.fromJson(Map<dynamic, dynamic> json) {
    super.mapping(json);
    currentPage = json['currentPage'];
    step = json['step'];
    totalPages = json['totalPages'];
    keyword = json['keyword'];
    if (json['data'] != null) {
      product = <Product>[];
      json['data'].forEach((v) {
        product!.add(Product.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJsonAddEditDelete() {
    /* name,
      manufacturer_id,
      category_id,
      gender,
      product_size,
      product_color, */
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = item?.id;
    data['name'] = item?.name;
    data['manufacturer_id'] = item?.manufacturerId;
    data['category_id'] = item?.categoryId;
    data['gender'] = item?.gender;
    data['product_size'] = item?.sizes?.map((e) => e.toJson()).toList();
    data['product_color'] = item?.colors?.map((e) => e.toJson()).toList();

    // if (product != null) {
    //   data['product'] = product!.map((v) => v.toJson()).toList();
    // }
    return data;
  }
}

class Product {
  int? id;
  String? name;
  int? manufacturerId;
  int? categoryId;
  String? gender;
  List<Colors>? colors;
  List<Sizes>? sizes;

  Product(
      {this.id,
      this.name,
      this.manufacturerId,
      this.categoryId,
      this.gender,
      this.colors,
      this.sizes});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    manufacturerId = json['manufacturer_id'];
    categoryId = json['category_id'];
    gender = json['gender'];
    if (json['colors'] != null) {
      colors = <Colors>[];
      json['colors'].forEach((v) {
        colors!.add(Colors.fromJson(v));
      });
    }
    if (json['sizes'] != null) {
      sizes = <Sizes>[];
      json['sizes'].forEach((v) {
        sizes!.add(Sizes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['manufacturer_id'] = manufacturerId;
    data['category_id'] = categoryId;
    data['gender'] = gender;
    if (colors != null) {
      data['colors'] = colors!.map((v) => v.toJson()).toList();
    }
    if (sizes != null) {
      data['sizes'] = sizes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Colors extends BaseEntity {
  int? productColorId;
  int? colorId;
  int? price;
  List<Images>? images;

  Colors({this.productColorId, this.colorId, this.price, this.images});

  Colors.fromJson(Map<String, dynamic> json) {
    productColorId = json['product_color_id'];
    colorId = json['color_id'];
    price = json['price'];
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(Images.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = productColorId;
    data['color_id'] = colorId;
    data['price'] = price;
    if (images != null) {
      data['images'] = images!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Images {
  String? url;

  Images({this.url});

  Images.fromJson(Map<String, dynamic> json) {
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['url'] = url;
    return data;
  }
}

class Sizes extends BaseEntity {
  int? productSizeId;
  int? sizeId;
  int? colorId;
  int? quantity;

  Sizes({this.productSizeId, this.sizeId, this.colorId, this.quantity});

  Sizes.fromJson(Map<String, dynamic> json) {
    productSizeId = json['product_size_id'];
    sizeId = json['size_id'];
    colorId = json['color_id'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['product_size_id'] = productSizeId;
    data['size_id'] = sizeId;
    data['color_id'] = colorId;
    data['quantity'] = quantity;
    return data;
  }
}
