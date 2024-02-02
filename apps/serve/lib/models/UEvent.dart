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
import 'package:collection/collection.dart';


/** This is an auto generated class representing the UEvent type in your schema. */
class UEvent extends amplify_core.Model {
  static const classType = const _UEventModelType();
  final String id;
  final String? _name;
  final String? _details;
  final String? _date;
  final String? _time;
  final List<UUser>? _membersAttending;
  final List<UUser>? _membersNotAttending;
  final UProject? _project;
  final String? _eventPicture;
  final amplify_core.TemporalDateTime? _createdAt;
  final amplify_core.TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;
  
  @Deprecated('[getId] is being deprecated in favor of custom primary key feature. Use getter [modelIdentifier] to get model identifier.')
  @override
  String getId() => id;
  
  UEventModelIdentifier get modelIdentifier {
      return UEventModelIdentifier(
        id: id
      );
  }
  
  String get name {
    try {
      return _name!;
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
  
  String? get date {
    return _date;
  }
  
  String? get time {
    return _time;
  }
  
  List<UUser>? get membersAttending {
    return _membersAttending;
  }
  
  List<UUser>? get membersNotAttending {
    return _membersNotAttending;
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
  
  String? get eventPicture {
    return _eventPicture;
  }
  
  amplify_core.TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  amplify_core.TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  const UEvent._internal({required this.id, required name, details, date, time, membersAttending, membersNotAttending, required project, eventPicture, createdAt, updatedAt}): _name = name, _details = details, _date = date, _time = time, _membersAttending = membersAttending, _membersNotAttending = membersNotAttending, _project = project, _eventPicture = eventPicture, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory UEvent({String? id, required String name, String? details, String? date, String? time, List<UUser>? membersAttending, List<UUser>? membersNotAttending, required UProject project, String? eventPicture}) {
    return UEvent._internal(
      id: id == null ? amplify_core.UUID.getUUID() : id,
      name: name,
      details: details,
      date: date,
      time: time,
      membersAttending: membersAttending != null ? List<UUser>.unmodifiable(membersAttending) : membersAttending,
      membersNotAttending: membersNotAttending != null ? List<UUser>.unmodifiable(membersNotAttending) : membersNotAttending,
      project: project,
      eventPicture: eventPicture);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UEvent &&
      id == other.id &&
      _name == other._name &&
      _details == other._details &&
      _date == other._date &&
      _time == other._time &&
      DeepCollectionEquality().equals(_membersAttending, other._membersAttending) &&
      DeepCollectionEquality().equals(_membersNotAttending, other._membersNotAttending) &&
      _project == other._project &&
      _eventPicture == other._eventPicture;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("UEvent {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("name=" + "$_name" + ", ");
    buffer.write("details=" + "$_details" + ", ");
    buffer.write("date=" + "$_date" + ", ");
    buffer.write("time=" + "$_time" + ", ");
    buffer.write("project=" + (_project != null ? _project!.toString() : "null") + ", ");
    buffer.write("eventPicture=" + "$_eventPicture" + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  UEvent copyWith({String? name, String? details, String? date, String? time, List<UUser>? membersAttending, List<UUser>? membersNotAttending, UProject? project, String? eventPicture}) {
    return UEvent._internal(
      id: id,
      name: name ?? this.name,
      details: details ?? this.details,
      date: date ?? this.date,
      time: time ?? this.time,
      membersAttending: membersAttending ?? this.membersAttending,
      membersNotAttending: membersNotAttending ?? this.membersNotAttending,
      project: project ?? this.project,
      eventPicture: eventPicture ?? this.eventPicture);
  }
  
  UEvent copyWithModelFieldValues({
    ModelFieldValue<String>? name,
    ModelFieldValue<String?>? details,
    ModelFieldValue<String?>? date,
    ModelFieldValue<String?>? time,
    ModelFieldValue<List<UUser>?>? membersAttending,
    ModelFieldValue<List<UUser>?>? membersNotAttending,
    ModelFieldValue<UProject>? project,
    ModelFieldValue<String?>? eventPicture
  }) {
    return UEvent._internal(
      id: id,
      name: name == null ? this.name : name.value,
      details: details == null ? this.details : details.value,
      date: date == null ? this.date : date.value,
      time: time == null ? this.time : time.value,
      membersAttending: membersAttending == null ? this.membersAttending : membersAttending.value,
      membersNotAttending: membersNotAttending == null ? this.membersNotAttending : membersNotAttending.value,
      project: project == null ? this.project : project.value,
      eventPicture: eventPicture == null ? this.eventPicture : eventPicture.value
    );
  }
  
  UEvent.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _name = json['name'],
      _details = json['details'],
      _date = json['date'],
      _time = json['time'],
      _membersAttending = json['membersAttending'] is List
        ? (json['membersAttending'] as List)
          .where((e) => e?['serializedData'] != null)
          .map((e) => UUser.fromJson(new Map<String, dynamic>.from(e['serializedData'])))
          .toList()
        : null,
      _membersNotAttending = json['membersNotAttending'] is List
        ? (json['membersNotAttending'] as List)
          .where((e) => e?['serializedData'] != null)
          .map((e) => UUser.fromJson(new Map<String, dynamic>.from(e['serializedData'])))
          .toList()
        : null,
      _project = json['project']?['serializedData'] != null
        ? UProject.fromJson(new Map<String, dynamic>.from(json['project']['serializedData']))
        : null,
      _eventPicture = json['eventPicture'],
      _createdAt = json['createdAt'] != null ? amplify_core.TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? amplify_core.TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'name': _name, 'details': _details, 'date': _date, 'time': _time, 'membersAttending': _membersAttending?.map((UUser? e) => e?.toJson()).toList(), 'membersNotAttending': _membersNotAttending?.map((UUser? e) => e?.toJson()).toList(), 'project': _project?.toJson(), 'eventPicture': _eventPicture, 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };
  
  Map<String, Object?> toMap() => {
    'id': id,
    'name': _name,
    'details': _details,
    'date': _date,
    'time': _time,
    'membersAttending': _membersAttending,
    'membersNotAttending': _membersNotAttending,
    'project': _project,
    'eventPicture': _eventPicture,
    'createdAt': _createdAt,
    'updatedAt': _updatedAt
  };

  static final amplify_core.QueryModelIdentifier<UEventModelIdentifier> MODEL_IDENTIFIER = amplify_core.QueryModelIdentifier<UEventModelIdentifier>();
  static final ID = amplify_core.QueryField(fieldName: "id");
  static final NAME = amplify_core.QueryField(fieldName: "name");
  static final DETAILS = amplify_core.QueryField(fieldName: "details");
  static final DATE = amplify_core.QueryField(fieldName: "date");
  static final TIME = amplify_core.QueryField(fieldName: "time");
  static final MEMBERSATTENDING = amplify_core.QueryField(
    fieldName: "membersAttending",
    fieldType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.model, ofModelName: 'UUser'));
  static final MEMBERSNOTATTENDING = amplify_core.QueryField(
    fieldName: "membersNotAttending",
    fieldType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.model, ofModelName: 'UUser'));
  static final PROJECT = amplify_core.QueryField(
    fieldName: "project",
    fieldType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.model, ofModelName: 'UProject'));
  static final EVENTPICTURE = amplify_core.QueryField(fieldName: "eventPicture");
  static var schema = amplify_core.Model.defineSchema(define: (amplify_core.ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "UEvent";
    modelSchemaDefinition.pluralName = "UEvents";
    
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
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: UEvent.NAME,
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: UEvent.DETAILS,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: UEvent.DATE,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: UEvent.TIME,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.hasMany(
      key: UEvent.MEMBERSATTENDING,
      isRequired: false,
      ofModelName: 'UUser',
      associatedKey: UUser.UEVENTMEMBERSATTENDINGID
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.hasMany(
      key: UEvent.MEMBERSNOTATTENDING,
      isRequired: false,
      ofModelName: 'UUser',
      associatedKey: UUser.UEVENTMEMBERSNOTATTENDINGID
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.belongsTo(
      key: UEvent.PROJECT,
      isRequired: true,
      targetNames: ['uProjectEventsId'],
      ofModelName: 'UProject'
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: UEvent.EVENTPICTURE,
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
  });
}

class _UEventModelType extends amplify_core.ModelType<UEvent> {
  const _UEventModelType();
  
  @override
  UEvent fromJson(Map<String, dynamic> jsonData) {
    return UEvent.fromJson(jsonData);
  }
  
  @override
  String modelName() {
    return 'UEvent';
  }
}

/**
 * This is an auto generated class representing the model identifier
 * of [UEvent] in your schema.
 */
class UEventModelIdentifier implements amplify_core.ModelIdentifier<UEvent> {
  final String id;

  /** Create an instance of UEventModelIdentifier using [id] the primary key. */
  const UEventModelIdentifier({
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
  String toString() => 'UEventModelIdentifier(id: $id)';
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    
    return other is UEventModelIdentifier &&
      id == other.id;
  }
  
  @override
  int get hashCode =>
    id.hashCode;
}