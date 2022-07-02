class LottoMapping {
  String id;
  final String lottoId;
  final String name;
  final String url;
  final int method;
  final String? params;
  final String? formatParams;
  final String? formatDate;
  final String? drawtime;
  final String? node;
  final String? xslt;

  LottoMapping({required this.lottoId, required this.name, required this.url, required this.method, this.id = '', this.params, this.formatParams, this.formatDate, this.drawtime, this.node, this.xslt, });

  Map<String,dynamic> toJson(){
    return {
      'id' : id,
      'lotto_id' : lottoId,
      'name' : name,    
      'url' : url,    
      'method' : method,    
      'params' : params, 
      'format_params' : formatParams, 
      'format_date' : formatDate,  
      'drawtime' : drawtime,  
      'node' : node,  
      'xslt' : xslt,
    };
  }

  factory LottoMapping.fromJson(Map<String,dynamic> json){     
    return LottoMapping(
      id: json ['id'],
      lottoId: json['lotto_id'], 
      name: json['name'],      
      url: json["url"] ?? '', 
      method: json["method"] ?? 0, 
      params: json["params"] ?? '', 
      formatParams: json["format_params"] ?? '', 
      formatDate: json["format_date"] ?? '',
      drawtime: json["drawtime"] ?? '',
      node: json["node"] ?? '', 
      xslt: json["xslt"] ?? '', 
    );
  }
  
}


class Methods
{  
   // ignore: constant_identifier_names
   static const int GET = 0;
   // ignore: constant_identifier_names
   static const int POST = 1;
   // ignore: constant_identifier_names
   static const int PUT = 2;
   // ignore: constant_identifier_names
   static const int PATCH = 3;
   // ignore: constant_identifier_names
   static const int DELETE = 4;
}