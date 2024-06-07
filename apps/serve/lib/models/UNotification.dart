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

// ignore_for_file: public_member_api_docs, annotate_overrides, dead_code, dead_codepublic_member_api_docs, depend_on_referenced_packages, file_names, library_private_types_in_public_api, no_leading_underscores_for_library_prefixes, no_leading_underscores_for_local_identifiers, non_constant_identifier_names, null_check_on_nullable_type_parameter, override_on_non_overriding_member, prefer_adjacent_string_concatenation, prefer_const_constructors, prefer_if_null_operators, prefer_interpolation_to_compose_strings, slash_for_doc_comments, sort_child_properties_last, unnecessary_const, unnecessary_constructor_name, unnecessary_late, unnecessary_new, unnecessary_null_aware_assignments, unnecessary_nullable_for_final_variable_declarations, unnecessary_string_interpolations, use_build_context_synchronously

import 'ModelProvider.dart';
import 'package:amplify_core/amplify_core.dart' as amplify_core;


/** This is an auto generated class representing the UNotification type in your schema. */
class UNotification extends amplify_core.Model {
  static const classType = const _UNotificationModelType();
  final String id;
  final UUser? _receiver;
  final UUser? _sender;
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
  
  UNotificationModelIdentifier get modelIdentifier {
      return UNotificationModelIdentifier(
        id: id
      );
  }
  
  UUser get receiver {
    try {
      return _receiver!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  UUser get sender {
    try {
      return _sender!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  UProject? get project {
    return _project;
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
  
  const UNotification._internal({required this.id, required receiver, required sender, project, required date, required message, required status, createdAt, updatedAt}): _receiver = receiver, _sender = sender, _project = project, _date = date, _message = message, _status = status, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory UNotification({String? id, required UUser receiver, required UUser sender, UProject? project, required String date, required String message, required String status}) {
    return UNotification._internal(
      id: id == null ? amplify_core.UUID.getUUID() : id,
      receiver: receiver,
      sender: sender,
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
    return other is UNotification &&
      id == other.id &&
      _receiver == other._receiver &&
      _sender == other._sender &&
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
    
    buffer.write("UNotification {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("receiver=" + (_receiver != null ? _receiver!.toString() : "null") + ", ");
    buffer.write("sender=" + (_sender != null ? _sender!.toString() : "null") + ", ");
    buffer.write("project=" + (_project != null ? _project!.toString() : "null") + ", ");
    buffer.write("date=" + "$_date" + ", ");
    buffer.write("message=" + "$_message" + ", ");
    buffer.write("status=" + "$_status" + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  UNotification copyWith({UUser? receiver, UUser? sender, UProject? project, String? date, String? message, String? status}) {
    return UNotification._internal(
      id: id,
      receiver: receiver ?? this.receiver,
      sender: sender ?? this.sender,
      project: project ?? this.project,
      date: date ?? this.date,
      message: message ?? this.message,
      status: status ?? this.status);
  }
  
  UNotification copyWithModelFieldValues({
    ModelFieldValue<UUser>? receiver,
    ModelFieldValue<UUser>? sender,
    ModelFieldValue<UProject?>? project,
    ModelFieldValue<String>? date,
    ModelFieldValue<String>? message,
    ModelFieldValue<String>? status
  }) {
    return UNotification._internal(
      id: id,
      receiver: receiver == null ? this.receiver : receiver.value,
      sender: sender == null ? this.sender : sender.value,
      project: project == null ? this.project : project.value,
      date: date == null ? this.date : date.value,
      message: message == null ? this.message : message.value,
      status: status == null ? this.status : status.value
    );
  }
  
  UNotification.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _receiver = json['receiver'] != null
        ? json['receiver']['serializedData'] != null
          ? UUser.fromJson(new Map<String, dynamic>.from(json['receiver']['serializedData']))
          : UUser.fromJson(new Map<String, dynamic>.from(json['receiver']))
        : null,
      _sender = json['sender'] != null
        ? json['sender']['serializedData'] != null
          ? UUser.fromJson(new Map<String, dynamic>.from(json['sender']['serializedData']))
          : UUser.fromJson(new Map<String, dynamic>.from(json['sender']))
        : null,
      _project = json['project'] != null
        ? json['project']['serializedData'] != null
          ? UProject.fromJson(new Map<String, dynamic>.from(json['project']['serializedData']))
          : UProject.fromJson(new Map<String, dynamic>.from(json['project']))
        : null,
      _date = json['date'],
      _message = json['message'],
      _status = json['status'],
      _createdAt = json['createdAt'] != null ? amplify_core.TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? amplify_core.TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'receiver': _receiver?.toJson(), 'sender': _sender?.toJson(), 'project': _project?.toJson(), 'date': _date, 'message': _message, 'status': _status, 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };
  
  Map<String, Object?> toMap() => {
    'id': id,
    'receiver': _receiver,
    'sender': _sender,
    'project': _project,
    'date': _date,
    'message': _message,
    'status': _status,
    'createdAt': _createdAt,
    'updatedAt': _updatedAt
  };

  static final amplify_core.QueryModelIdentifier<UNotificationModelIdentifier> MODEL_IDENTIFIER = amplify_core.QueryModelIdentifier<UNotificationModelIdentifier>();
  static final ID = amplify_core.QueryField(fieldName: "id");
  static final RECEIVER = amplify_core.QueryField(
    fieldName: "receiver",
    fieldType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.model, ofModelName: 'UUser'));
  static final SENDER = amplify_core.QueryField(
    fieldName: "sender",
    fieldType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.model, ofModelName: 'UUser'));
  static final PROJECT = amplify_core.QueryField(
    fieldName: "project",
    fieldType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.model, ofModelName: 'UProject'));
  static final DATE = amplify_core.QueryField(fieldName: "date");
  static final MESSAGE = amplify_core.QueryField(fieldName: "message");
  static final STATUS = amplify_core.QueryField(fieldName: "status");
  static var schema = amplify_core.Model.defineSchema(define: (amplify_core.ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "UNotification";
    modelSchemaDefinition.pluralName = "UNotifications";
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.id());
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.belongsTo(
      key: UNotification.RECEIVER,
      isRequired: true,
      targetNames: ['uUserNotificationsSentId'],
      ofModelName: 'UUser'
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.belongsTo(
      key: UNotification.SENDER,
      isRequired: true,
      targetNames: ['uUserNotificationsSentId'],
      ofModelName: 'UUser'
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.belongsTo(
      key: UNotification.PROJECT,
      isRequired: false,
      targetNames: ['uProjectNotificationsId'],
      ofModelName: 'UProject'
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: UNotification.DATE,
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: UNotification.MESSAGE,
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: UNotification.STATUS,
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

class _UNotificationModelType extends amplify_core.ModelType<UNotification> {
  const _UNotificationModelType();
  
  @override
  UNotification fromJson(Map<String, dynamic> jsonData) {
    return UNotification.fromJson(jsonData);
  }
  
  @override
  String modelName() {
    return 'UNotification';
  }
}

/**
 * This is an auto generated class representing the model identifier
 * of [UNotification] in your schema.
 */
class UNotificationModelIdentifier implements amplify_core.ModelIdentifier<UNotification> {
  final String id;

  /** Create an instance of UNotificationModelIdentifier using [id] the primary key. */
  const UNotificationModelIdentifier({
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
  String toString() => 'UNotificationModelIdentifier(id: $id)';
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    
    return other is UNotificationModelIdentifier &&
      id == other.id;
  }
  
  @override
  int get hashCode =>
    id.hashCode;
}