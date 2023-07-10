/*
* Copyright 2021 Amazon.com, Inc. or its affiliates. All Rights Reserved.
*
* Licensed under the Apache License, Version 2.0 (the "License").
* You may not use this file except in compliance with the License.
* A copy of the License is located at
*
*  http://aws.amazon.com/apache2.0
*
* or in the "license" file accompanying this file. This file is distributed
* on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either
* express or implied. See the License for the specific language governing
* permissions and limitations under the License.
*/

// NOTE: This file is generated and may not follow lint rules defined in your app
// Generated files can be excluded from analysis in analysis_options.yaml
// For more info, see: https://dart.dev/guides/language/analysis-options#excluding-code-from-analysis

// ignore_for_file: public_member_api_docs, annotate_overrides, dead_code, dead_codepublic_member_api_docs, depend_on_referenced_packages, file_names, library_private_types_in_public_api, no_leading_underscores_for_library_prefixes, no_leading_underscores_for_local_identifiers, non_constant_identifier_names, null_check_on_nullable_type_parameter, prefer_adjacent_string_concatenation, prefer_const_constructors, prefer_if_null_operators, prefer_interpolation_to_compose_strings, slash_for_doc_comments, sort_child_properties_last, unnecessary_const, unnecessary_constructor_name, unnecessary_late, unnecessary_new, unnecessary_null_aware_assignments, unnecessary_nullable_for_final_variable_declarations, unnecessary_string_interpolations, use_build_context_synchronously

import 'ModelProvider.dart';
import 'package:amplify_core/amplify_core.dart';
import 'package:flutter/foundation.dart';


/** This is an auto generated class representing the USponsor type in your schema. */
@immutable
class USponsor extends Model {
  static const classType = const _USponsorModelType();
  final String id;
  final double? _amount;
  final UUser? _user;
  final TemporalDateTime? _createdAt;
  final TemporalDateTime? _updatedAt;
  final String? _uProjectSponsorsId;

  @override
  getInstanceType() => classType;
  
  @Deprecated('[getId] is being deprecated in favor of custom primary key feature. Use getter [modelIdentifier] to get model identifier.')
  @override
  String getId() => id;
  
  USponsorModelIdentifier get modelIdentifier {
      return USponsorModelIdentifier(
        id: id
      );
  }
  
  double get amount {
    try {
      return _amount!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  UUser? get user {
    return _user;
  }
  
  TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  String? get uProjectSponsorsId {
    return _uProjectSponsorsId;
  }
  
  const USponsor._internal({required this.id, required amount, user, createdAt, updatedAt, uProjectSponsorsId}): _amount = amount, _user = user, _createdAt = createdAt, _updatedAt = updatedAt, _uProjectSponsorsId = uProjectSponsorsId;
  
  factory USponsor({String? id, required double amount, UUser? user, String? uProjectSponsorsId}) {
    return USponsor._internal(
      id: id == null ? UUID.getUUID() : id,
      amount: amount,
      user: user,
      uProjectSponsorsId: uProjectSponsorsId);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is USponsor &&
      id == other.id &&
      _amount == other._amount &&
      _user == other._user &&
      _uProjectSponsorsId == other._uProjectSponsorsId;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("USponsor {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("amount=" + (_amount != null ? _amount!.toString() : "null") + ", ");
    buffer.write("user=" + (_user != null ? _user!.toString() : "null") + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null") + ", ");
    buffer.write("uProjectSponsorsId=" + "$_uProjectSponsorsId");
    buffer.write("}");
    
    return buffer.toString();
  }
  
  USponsor copyWith({double? amount, UUser? user, String? uProjectSponsorsId}) {
    return USponsor._internal(
      id: id,
      amount: amount ?? this.amount,
      user: user ?? this.user,
      uProjectSponsorsId: uProjectSponsorsId ?? this.uProjectSponsorsId);
  }
  
  USponsor.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _amount = (json['amount'] as num?)?.toDouble(),
      _user = json['user']?['serializedData'] != null
        ? UUser.fromJson(new Map<String, dynamic>.from(json['user']['serializedData']))
        : null,
      _createdAt = json['createdAt'] != null ? TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? TemporalDateTime.fromString(json['updatedAt']) : null,
      _uProjectSponsorsId = json['uProjectSponsorsId'];
  
  Map<String, dynamic> toJson() => {
    'id': id, 'amount': _amount, 'user': _user?.toJson(), 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format(), 'uProjectSponsorsId': _uProjectSponsorsId
  };
  
  Map<String, Object?> toMap() => {
    'id': id, 'amount': _amount, 'user': _user, 'createdAt': _createdAt, 'updatedAt': _updatedAt, 'uProjectSponsorsId': _uProjectSponsorsId
  };

  static final QueryModelIdentifier<USponsorModelIdentifier> MODEL_IDENTIFIER = QueryModelIdentifier<USponsorModelIdentifier>();
  static final QueryField ID = QueryField(fieldName: "id");
  static final QueryField AMOUNT = QueryField(fieldName: "amount");
  static final QueryField USER = QueryField(
    fieldName: "user",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: 'UUser'));
  static final QueryField UPROJECTSPONSORSID = QueryField(fieldName: "uProjectSponsorsId");
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "USponsor";
    modelSchemaDefinition.pluralName = "USponsors";
    
    modelSchemaDefinition.addField(ModelFieldDefinition.id());
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: USponsor.AMOUNT,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.double)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.belongsTo(
      key: USponsor.USER,
      isRequired: false,
      targetNames: ['uUserSponsorsId'],
      ofModelName: 'UUser'
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.nonQueryField(
      fieldName: 'createdAt',
      isRequired: false,
      isReadOnly: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.nonQueryField(
      fieldName: 'updatedAt',
      isRequired: false,
      isReadOnly: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: USponsor.UPROJECTSPONSORSID,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
  });
}

class _USponsorModelType extends ModelType<USponsor> {
  const _USponsorModelType();
  
  @override
  USponsor fromJson(Map<String, dynamic> jsonData) {
    return USponsor.fromJson(jsonData);
  }
  
  @override
  String modelName() {
    return 'USponsor';
  }
}

/**
 * This is an auto generated class representing the model identifier
 * of [USponsor] in your schema.
 */
@immutable
class USponsorModelIdentifier implements ModelIdentifier<USponsor> {
  final String id;

  /** Create an instance of USponsorModelIdentifier using [id] the primary key. */
  const USponsorModelIdentifier({
    required this.id});
  
  @override
  Map<String, dynamic> serializeAsMap() => (<String, dynamic>{
    'id': id
  });
  
  @override
  List<Map<String, dynamic>> serializeAsList() => serializeAsMap()
    .entries
    .map((entry) => (<String, dynamic>{ entry.key: entry.value }))
    .toList();
  
  @override
  String serializeAsString() => serializeAsMap().values.join('#');
  
  @override
  String toString() => 'USponsorModelIdentifier(id: $id)';
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    
    return other is USponsorModelIdentifier &&
      id == other.id;
  }
  
  @override
  int get hashCode =>
    id.hashCode;
}