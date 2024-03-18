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
import 'package:amplify_core/amplify_core.dart' as amplify_core;


/** This is an auto generated class representing the UEventCheckIn type in your schema. */
class UEventCheckIn extends amplify_core.Model {
  static const classType = const _UEventCheckInModelType();
  final String id;
  final UEvent? _event;
  final UUser? _user;
  final String? _datetime;
  final String? _details;
  final amplify_core.TemporalDateTime? _createdAt;
  final amplify_core.TemporalDateTime? _updatedAt;
  final String? _uEventCheckInEventId;
  final String? _uEventCheckInUserId;

  @override
  getInstanceType() => classType;
  
  @Deprecated('[getId] is being deprecated in favor of custom primary key feature. Use getter [modelIdentifier] to get model identifier.')
  @override
  String getId() => id;
  
  UEventCheckInModelIdentifier get modelIdentifier {
      return UEventCheckInModelIdentifier(
        id: id
      );
  }
  
  UEvent get event {
    try {
      return _event!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  UUser get user {
    try {
      return _user!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  String get datetime {
    try {
      return _datetime!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  String? get details {
    return _details;
  }
  
  amplify_core.TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  amplify_core.TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  String get uEventCheckInEventId {
    try {
      return _uEventCheckInEventId!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  String get uEventCheckInUserId {
    try {
      return _uEventCheckInUserId!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  const UEventCheckIn._internal({required this.id, required event, required user, required datetime, details, createdAt, updatedAt, required uEventCheckInEventId, required uEventCheckInUserId}): _event = event, _user = user, _datetime = datetime, _details = details, _createdAt = createdAt, _updatedAt = updatedAt, _uEventCheckInEventId = uEventCheckInEventId, _uEventCheckInUserId = uEventCheckInUserId;
  
  factory UEventCheckIn({String? id, required UEvent event, required UUser user, required String datetime, String? details, required String uEventCheckInEventId, required String uEventCheckInUserId}) {
    return UEventCheckIn._internal(
      id: id == null ? amplify_core.UUID.getUUID() : id,
      event: event,
      user: user,
      datetime: datetime,
      details: details,
      uEventCheckInEventId: uEventCheckInEventId,
      uEventCheckInUserId: uEventCheckInUserId);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UEventCheckIn &&
      id == other.id &&
      _event == other._event &&
      _user == other._user &&
      _datetime == other._datetime &&
      _details == other._details &&
      _uEventCheckInEventId == other._uEventCheckInEventId &&
      _uEventCheckInUserId == other._uEventCheckInUserId;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("UEventCheckIn {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("datetime=" + "$_datetime" + ", ");
    buffer.write("details=" + "$_details" + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null") + ", ");
    buffer.write("uEventCheckInEventId=" + "$_uEventCheckInEventId" + ", ");
    buffer.write("uEventCheckInUserId=" + "$_uEventCheckInUserId");
    buffer.write("}");
    
    return buffer.toString();
  }
  
  UEventCheckIn copyWith({UEvent? event, UUser? user, String? datetime, String? details, String? uEventCheckInEventId, String? uEventCheckInUserId}) {
    return UEventCheckIn._internal(
      id: id,
      event: event ?? this.event,
      user: user ?? this.user,
      datetime: datetime ?? this.datetime,
      details: details ?? this.details,
      uEventCheckInEventId: uEventCheckInEventId ?? this.uEventCheckInEventId,
      uEventCheckInUserId: uEventCheckInUserId ?? this.uEventCheckInUserId);
  }
  
  UEventCheckIn copyWithModelFieldValues({
    ModelFieldValue<UEvent>? event,
    ModelFieldValue<UUser>? user,
    ModelFieldValue<String>? datetime,
    ModelFieldValue<String?>? details,
    ModelFieldValue<String>? uEventCheckInEventId,
    ModelFieldValue<String>? uEventCheckInUserId
  }) {
    return UEventCheckIn._internal(
      id: id,
      event: event == null ? this.event : event.value,
      user: user == null ? this.user : user.value,
      datetime: datetime == null ? this.datetime : datetime.value,
      details: details == null ? this.details : details.value,
      uEventCheckInEventId: uEventCheckInEventId == null ? this.uEventCheckInEventId : uEventCheckInEventId.value,
      uEventCheckInUserId: uEventCheckInUserId == null ? this.uEventCheckInUserId : uEventCheckInUserId.value
    );
  }
  
  UEventCheckIn.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _event = json['event']?['serializedData'] != null
        ? UEvent.fromJson(new Map<String, dynamic>.from(json['event']['serializedData']))
        : null,
      _user = json['user']?['serializedData'] != null
        ? UUser.fromJson(new Map<String, dynamic>.from(json['user']['serializedData']))
        : null,
      _datetime = json['datetime'],
      _details = json['details'],
      _createdAt = json['createdAt'] != null ? amplify_core.TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? amplify_core.TemporalDateTime.fromString(json['updatedAt']) : null,
      _uEventCheckInEventId = json['uEventCheckInEventId'],
      _uEventCheckInUserId = json['uEventCheckInUserId'];
  
  Map<String, dynamic> toJson() => {
    'id': id, 'event': _event?.toJson(), 'user': _user?.toJson(), 'datetime': _datetime, 'details': _details, 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format(), 'uEventCheckInEventId': _uEventCheckInEventId, 'uEventCheckInUserId': _uEventCheckInUserId
  };
  
  Map<String, Object?> toMap() => {
    'id': id,
    'event': _event,
    'user': _user,
    'datetime': _datetime,
    'details': _details,
    'createdAt': _createdAt,
    'updatedAt': _updatedAt,
    'uEventCheckInEventId': _uEventCheckInEventId,
    'uEventCheckInUserId': _uEventCheckInUserId
  };

  static final amplify_core.QueryModelIdentifier<UEventCheckInModelIdentifier> MODEL_IDENTIFIER = amplify_core.QueryModelIdentifier<UEventCheckInModelIdentifier>();
  static final ID = amplify_core.QueryField(fieldName: "id");
  static final EVENT = amplify_core.QueryField(
    fieldName: "event",
    fieldType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.model, ofModelName: 'UEvent'));
  static final USER = amplify_core.QueryField(
    fieldName: "user",
    fieldType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.model, ofModelName: 'UUser'));
  static final DATETIME = amplify_core.QueryField(fieldName: "datetime");
  static final DETAILS = amplify_core.QueryField(fieldName: "details");
  static final UEVENTCHECKINEVENTID = amplify_core.QueryField(fieldName: "uEventCheckInEventId");
  static final UEVENTCHECKINUSERID = amplify_core.QueryField(fieldName: "uEventCheckInUserId");
  static var schema = amplify_core.Model.defineSchema(define: (amplify_core.ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "UEventCheckIn";
    modelSchemaDefinition.pluralName = "UEventCheckIns";
    
    modelSchemaDefinition.authRules = [
      amplify_core.AuthRule(
        authStrategy: amplify_core.AuthStrategy.PUBLIC,
        operations: const [
          amplify_core.ModelOperation.CREATE,
          amplify_core.ModelOperation.UPDATE,
          amplify_core.ModelOperation.DELETE,
          amplify_core.ModelOperation.READ
        ])
    ];
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.id());
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.hasOne(
      key: UEventCheckIn.EVENT,
      isRequired: true,
      ofModelName: 'UEvent',
      associatedKey: UEvent.ID
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.hasOne(
      key: UEventCheckIn.USER,
      isRequired: true,
      ofModelName: 'UUser',
      associatedKey: UUser.ID
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: UEventCheckIn.DATETIME,
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: UEventCheckIn.DETAILS,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.nonQueryField(
      fieldName: 'createdAt',
      isRequired: false,
      isReadOnly: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.dateTime)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.nonQueryField(
      fieldName: 'updatedAt',
      isRequired: false,
      isReadOnly: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.dateTime)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: UEventCheckIn.UEVENTCHECKINEVENTID,
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: UEventCheckIn.UEVENTCHECKINUSERID,
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
  });
}

class _UEventCheckInModelType extends amplify_core.ModelType<UEventCheckIn> {
  const _UEventCheckInModelType();
  
  @override
  UEventCheckIn fromJson(Map<String, dynamic> jsonData) {
    return UEventCheckIn.fromJson(jsonData);
  }
  
  @override
  String modelName() {
    return 'UEventCheckIn';
  }
}

/**
 * This is an auto generated class representing the model identifier
 * of [UEventCheckIn] in your schema.
 */
class UEventCheckInModelIdentifier implements amplify_core.ModelIdentifier<UEventCheckIn> {
  final String id;

  /** Create an instance of UEventCheckInModelIdentifier using [id] the primary key. */
  const UEventCheckInModelIdentifier({
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
  String toString() => 'UEventCheckInModelIdentifier(id: $id)';
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    
    return other is UEventCheckInModelIdentifier &&
      id == other.id;
  }
  
  @override
  int get hashCode =>
    id.hashCode;
}