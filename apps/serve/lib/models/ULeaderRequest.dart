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


/** This is an auto generated class representing the ULeaderRequest type in your schema. */
class ULeaderRequest extends amplify_core.Model {
  static const classType = const _ULeaderRequestModelType();
  final String id;
  final UUser? _owner;
  final UUser? _applicant;
  final UProject? _project;
  final String? _date;
  final String? _message;
  final String? _status;
  final amplify_core.TemporalDateTime? _createdAt;
  final amplify_core.TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;
  
  @Deprecated('[getId] is being deprecated in favor of custom primary key feature. Use getter [modelIdentifier] to get model identifier.')
  @override
  String getId() => id;
  
  ULeaderRequestModelIdentifier get modelIdentifier {
      return ULeaderRequestModelIdentifier(
        id: id
      );
  }
  
  UUser get owner {
    try {
      return _owner!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  UUser get applicant {
    try {
      return _applicant!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  UProject get project {
    try {
      return _project!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  String get date {
    try {
      return _date!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  String get message {
    try {
      return _message!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  String get status {
    try {
      return _status!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  amplify_core.TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  amplify_core.TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  const ULeaderRequest._internal({required this.id, required owner, required applicant, required project, required date, required message, required status, createdAt, updatedAt}): _owner = owner, _applicant = applicant, _project = project, _date = date, _message = message, _status = status, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory ULeaderRequest({String? id, required UUser owner, required UUser applicant, required UProject project, required String date, required String message, required String status}) {
    return ULeaderRequest._internal(
      id: id == null ? amplify_core.UUID.getUUID() : id,
      owner: owner,
      applicant: applicant,
      project: project,
      date: date,
      message: message,
      status: status);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ULeaderRequest &&
      id == other.id &&
      _owner == other._owner &&
      _applicant == other._applicant &&
      _project == other._project &&
      _date == other._date &&
      _message == other._message &&
      _status == other._status;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("ULeaderRequest {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("owner=" + (_owner != null ? _owner!.toString() : "null") + ", ");
    buffer.write("applicant=" + (_applicant != null ? _applicant!.toString() : "null") + ", ");
    buffer.write("project=" + (_project != null ? _project!.toString() : "null") + ", ");
    buffer.write("date=" + "$_date" + ", ");
    buffer.write("message=" + "$_message" + ", ");
    buffer.write("status=" + "$_status" + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  ULeaderRequest copyWith({UUser? owner, UUser? applicant, UProject? project, String? date, String? message, String? status}) {
    return ULeaderRequest._internal(
      id: id,
      owner: owner ?? this.owner,
      applicant: applicant ?? this.applicant,
      project: project ?? this.project,
      date: date ?? this.date,
      message: message ?? this.message,
      status: status ?? this.status);
  }
  
  ULeaderRequest copyWithModelFieldValues({
    ModelFieldValue<UUser>? owner,
    ModelFieldValue<UUser>? applicant,
    ModelFieldValue<UProject>? project,
    ModelFieldValue<String>? date,
    ModelFieldValue<String>? message,
    ModelFieldValue<String>? status
  }) {
    return ULeaderRequest._internal(
      id: id,
      owner: owner == null ? this.owner : owner.value,
      applicant: applicant == null ? this.applicant : applicant.value,
      project: project == null ? this.project : project.value,
      date: date == null ? this.date : date.value,
      message: message == null ? this.message : message.value,
      status: status == null ? this.status : status.value
    );
  }
  
  ULeaderRequest.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _owner = json['owner']?['serializedData'] != null
        ? UUser.fromJson(new Map<String, dynamic>.from(json['owner']['serializedData']))
        : null,
      _applicant = json['applicant']?['serializedData'] != null
        ? UUser.fromJson(new Map<String, dynamic>.from(json['applicant']['serializedData']))
        : null,
      _project = json['project']?['serializedData'] != null
        ? UProject.fromJson(new Map<String, dynamic>.from(json['project']['serializedData']))
        : null,
      _date = json['date'],
      _message = json['message'],
      _status = json['status'],
      _createdAt = json['createdAt'] != null ? amplify_core.TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? amplify_core.TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'owner': _owner?.toJson(), 'applicant': _applicant?.toJson(), 'project': _project?.toJson(), 'date': _date, 'message': _message, 'status': _status, 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };
  
  Map<String, Object?> toMap() => {
    'id': id,
    'owner': _owner,
    'applicant': _applicant,
    'project': _project,
    'date': _date,
    'message': _message,
    'status': _status,
    'createdAt': _createdAt,
    'updatedAt': _updatedAt
  };

  static final amplify_core.QueryModelIdentifier<ULeaderRequestModelIdentifier> MODEL_IDENTIFIER = amplify_core.QueryModelIdentifier<ULeaderRequestModelIdentifier>();
  static final ID = amplify_core.QueryField(fieldName: "id");
  static final OWNER = amplify_core.QueryField(
    fieldName: "owner",
    fieldType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.model, ofModelName: 'UUser'));
  static final APPLICANT = amplify_core.QueryField(
    fieldName: "applicant",
    fieldType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.model, ofModelName: 'UUser'));
  static final PROJECT = amplify_core.QueryField(
    fieldName: "project",
    fieldType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.model, ofModelName: 'UProject'));
  static final DATE = amplify_core.QueryField(fieldName: "date");
  static final MESSAGE = amplify_core.QueryField(fieldName: "message");
  static final STATUS = amplify_core.QueryField(fieldName: "status");
  static var schema = amplify_core.Model.defineSchema(define: (amplify_core.ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "ULeaderRequest";
    modelSchemaDefinition.pluralName = "ULeaderRequests";
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.id());
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.belongsTo(
      key: ULeaderRequest.OWNER,
      isRequired: true,
      targetNames: ['uUserLeaderRequestsSentId'],
      ofModelName: 'UUser'
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.belongsTo(
      key: ULeaderRequest.APPLICANT,
      isRequired: true,
      targetNames: ['uUserLeaderRequestsSentId'],
      ofModelName: 'UUser'
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.belongsTo(
      key: ULeaderRequest.PROJECT,
      isRequired: true,
      targetNames: ['uProjectLeaderRequestsId'],
      ofModelName: 'UProject'
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: ULeaderRequest.DATE,
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: ULeaderRequest.MESSAGE,
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: ULeaderRequest.STATUS,
      isRequired: true,
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
  });
}

class _ULeaderRequestModelType extends amplify_core.ModelType<ULeaderRequest> {
  const _ULeaderRequestModelType();
  
  @override
  ULeaderRequest fromJson(Map<String, dynamic> jsonData) {
    return ULeaderRequest.fromJson(jsonData);
  }
  
  @override
  String modelName() {
    return 'ULeaderRequest';
  }
}

/**
 * This is an auto generated class representing the model identifier
 * of [ULeaderRequest] in your schema.
 */
class ULeaderRequestModelIdentifier implements amplify_core.ModelIdentifier<ULeaderRequest> {
  final String id;

  /** Create an instance of ULeaderRequestModelIdentifier using [id] the primary key. */
  const ULeaderRequestModelIdentifier({
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
  String toString() => 'ULeaderRequestModelIdentifier(id: $id)';
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    
    return other is ULeaderRequestModelIdentifier &&
      id == other.id;
  }
  
  @override
  int get hashCode =>
    id.hashCode;
}