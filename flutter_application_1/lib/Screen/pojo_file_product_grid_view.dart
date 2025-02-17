class ProductListModel {
  String? status;
  List<Data>? data;

  ProductListModel({this.status, this.data});

  ProductListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  get productList => null;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? sId;
  String? createdDate;
  String? img;
  String? productCode;
  String? productName;
  String? qty;
  String? totalPrice;
  String? unitPrice;

  Data(
      {this.sId,
      this.createdDate,
      this.img,
      this.productCode,
      this.productName,
      this.qty,
      this.totalPrice,
      this.unitPrice});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    createdDate = json['CreatedDate'];
    img = json['Img'];
    productCode = json['ProductCode'];
    productName = json['ProductName'];
    qty = json['Qty'];
    totalPrice = json['TotalPrice'];
    unitPrice = json['UnitPrice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['CreatedDate'] = this.createdDate;
    data['Img'] = this.img;
    data['ProductCode'] = this.productCode;
    data['ProductName'] = this.productName;
    data['Qty'] = this.qty;
    data['TotalPrice'] = this.totalPrice;
    data['UnitPrice'] = this.unitPrice;
    return data;
  }
}
