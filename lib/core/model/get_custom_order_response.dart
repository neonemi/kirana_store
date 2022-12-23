import 'dart:convert';
/// status : 200
/// data : []
/// message : "status changed successfully"

GetCustomOrderResponse getCustomOrderResponseFromJson(String str) => GetCustomOrderResponse.fromJson(json.decode(str));
String getCustomOrderResponseToJson(GetCustomOrderResponse data) => json.encode(data.toJson());
class GetCustomOrderResponse {
  GetCustomOrderResponse({
      int? status, 
      List<dynamic>? data, 
      String? message,}){
    _status = status;
    _data = data;
    _message = message;
}

  GetCustomOrderResponse.fromJson(dynamic json) {
    _status = json['status'];
    _data = json['data'];
    // if (json['data'] != null) {
    //   _data = [];
    //   json['data'].forEach((v) {
    //     _data?.add(Dynamic.fromJson(v));
    //   });
    // }
    _message = json['message'];
  }
  int? _status;
  List<dynamic>? _data;
  String? _message;

  int? get status => _status;
  List<dynamic>? get data => _data;
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    map['message'] = _message;
    return map;
  }

}