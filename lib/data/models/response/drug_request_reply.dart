import 'package:json_annotation/json_annotation.dart';
part 'drug_request_reply.g.dart';
@JsonSerializable()
class DrugRequestReply {

final String?  pharmacy_description;
final bool?  isAlternative;
final String?  pharmacy_phone;

  DrugRequestReply(this.pharmacy_description, this.isAlternative, this.pharmacy_phone);
factory DrugRequestReply.fromJson(Map<String, dynamic> json) => _$DrugRequestReplyFromJson(json);
  Map<String, dynamic> toJson() => _$DrugRequestReplyToJson(this);

}