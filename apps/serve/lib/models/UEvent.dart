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
  final String? _streetAddress;
  final String? _state;
  final String? _city;
  final String? _zipCode;
  final String? _details;
  final String? _date;
  final String? _time;
  final List<String>? _membersAttending;
  final List<String>? _membersNotAttending;
  final UUser? _owner;
  final UUser? _leader;
  final UProject? _project;
  final String? _eventPicture;
  final String? _checkInCode;
  final amplify_core.TemporalDateTime? _createdAt;
  final amplify_core.TemporalDateTime? _updatedAt;
  final String? _uEventOwnerId;
  final String? _uEventLeaderId;

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
  
  String? get streetAddress {
    return _streetAddress;
  }
  
  String? get state {
    return _state;
  }
  
  String? get city {
    return _city;
  }
  
  String? get zipCode {
    return _zipCode;
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
  
  List<String>? get membersAttending {
    return _membersAttending;
  }
  
  List<String>? get membersNotAttending {
    return _membersNotAttending;
  }
  
  UUser? get owner {
    return _owner;
  }
  
  UUser? get leader {
    return _leader;
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
  
  String? get checkInCode {
    return _checkInCode;
  }
  
  amplify_core.TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  amplify_core.TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  String? get uEventOwnerId {
    return _uEventOwnerId;
  }
  
  String? get uEventLeaderId {
    return _uEventLeaderId;
  }
  
  const UEvent._internal({required this.id, required name, streetAddress, state, city, zipCode, details, date, time, membersAttending, membersNotAttending, owner, leader, required project, eventPicture, checkInCode, createdAt, updatedAt, uEventOwnerId, uEventLeaderId}): _name = name, _streetAddress = streetAddress, _state = state, _city = city, _zipCode = zipCode, _details = details, _date = date, _time = time, _membersAttending = membersAttending, _membersNotAttending = membersNotAttending, _owner = owner, _leader = leader, _project = project, _eventPicture = eventPicture, _checkInCode = checkInCode, _createdAt = createdAt, _updatedAt = updatedAt, _uEventOwnerId = uEventOwnerId, _uEventLeaderId = uEventLeaderId;
  
  factory UEvent({String? id, required String name, String? streetAddress, String? state, String? city, String? zipCode, String? details, String? date, String? time, List<String>? membersAttending, List<String>? membersNotAttending, UUser? owner, UUser? leader, required UProject project, String? eventPicture, String? checkInCode, String? uEventOwnerId, String? uEventLeaderId}) {
    return UEvent._internal(
      id: id == null ? amplify_core.UUID.getUUID() : id,
      name: name,
      streetAddress: streetAddress,
      state: state,
      city: city,
      zipCode: zipCode,
      details: details,
      date: date,
      time: time,
      membersAttending: membersAttending != null ? List<String>.unmodifiable(membersAttending) : membersAttending,
      membersNotAttending: membersNotAttending != null ? List<String>.unmodifiable(membersNotAttending) : membersNotAttending,
      owner: owner,
      leader: leader,
      project: project,
      eventPicture: eventPicture,
      checkInCode: checkInCode,
      uEventOwnerId: uEventOwnerId,
      uEventLeaderId: uEventLeaderId);
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
      _streetAddress == other._streetAddress &&
      _state == other._state &&
      _city == other._city &&
      _zipCode == other._zipCode &&
      _details == other._details &&
      _date == other._date &&
      _time == other._time &&
      DeepCollectionEquality().equals(_membersAttending, other._membersAttending) &&
      DeepCollectionEquality().equals(_membersNotAttending, other._membersNotAttending) &&
      _owner == other._owner &&
      _leader == other._leader &&
      _project == other._project &&
      _eventPicture == other._eventPicture &&
      _checkInCode == other._checkInCode &&
      _uEventOwnerId == other._uEventOwnerId &&
      _uEventLeaderId == other._uEventLeaderId;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("UEvent {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("name=" + "$_name" + ", ");
    buffer.write("streetAddress=" + "$_streetAddress" + ", ");
    buffer.write("state=" + "$_state" + ", ");
    buffer.write("city=" + "$_city" + ", ");
    buffer.write("zipCode=" + "$_zipCode" + ", ");
    buffer.write("details=" + "$_details" + ", ");
    buffer.write("date=" + "$_date" + ", ");
    buffer.write("time=" + "$_time" + ", ");
    buffer.write("membersAttending=" + (_membersAttending != null ? _membersAttending!.toString() : "null") + ", ");
    buffer.write("membersNotAttending=" + (_membersNotAttending != null ? _membersNotAttending!.toString() : "null") + ", ");
    buffer.write("project=" + (_project != null ? _project!.toString() : "null") + ", ");
    buffer.write("eventPicture=" + "$_eventPicture" + ", ");
    buffer.write("checkInCode=" + "$_checkInCode" + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null") + ", ");
    buffer.write("uEventOwnerId=" + "$_uEventOwnerId" + ", ");
    buffer.write("uEventLeaderId=" + "$_uEventLeaderId");
    buffer.write("}");
    
    return buffer.toString();
  }
  
  UEvent copyWith({String? name, String? streetAddress, String? state, String? city, String? zipCode, String? details, String? date, String? time, List<String>? membersAttending, List<String>? membersNotAttending, UUser? owner, UUser? leader, UProject? project, String? eventPicture, String? checkInCode, String? uEventOwnerId, String? uEventLeaderId}) {
    return UEvent._internal(
      id: id,
      name: name ?? this.name,
      streetAddress: streetAddress ?? this.streetAddress,
      state: state ?? this.state,
      city: city ?? this.city,
      zipCode: zipCode ?? this.zipCode,
      details: details ?? this.details,
      date: date ?? this.date,
      time: time ?? this.time,
      membersAttending: membersAttending ?? this.membersAttending,
      membersNotAttending: membersNotAttending ?? this.membersNotAttending,
      owner: owner ?? this.owner,
      leader: leader ?? this.leader,
      project: project ?? this.project,
      eventPicture: eventPicture ?? this.eventPicture,
      checkInCode: checkInCode ?? this.checkInCode,
      uEventOwnerId: uEventOwnerId ?? this.uEventOwnerId,
      uEventLeaderId: uEventLeaderId ?? this.uEventLeaderId);
  }
  
  UEvent copyWithModelFieldValues({
    ModelFieldValue<String>? name,
    ModelFieldValue<String?>? streetAddress,
    ModelFieldValue<String?>? state,
    ModelFieldValue<String?>? city,
    ModelFieldValue<String?>? zipCode,
    ModelFieldValue<String?>? details,
    ModelFieldValue<String?>? date,
    ModelFieldValue<String?>? time,
    ModelFieldValue<List<String>?>? membersAttending,
    ModelFieldValue<List<String>?>? membersNotAttending,
    ModelFieldValue<UUser?>? owner,
    ModelFieldValue<UUser?>? leader,
    ModelFieldValue<UProject>? project,
    ModelFieldValue<String?>? eventPicture,
    ModelFieldValue<String?>? checkInCode,
    ModelFieldValue<String?>? uEventOwnerId,
    ModelFieldValue<String?>? uEventLeaderId
  }) {
    return UEvent._internal(
      id: id,
      name: name == null ? this.name : name.value,
      streetAddress: streetAddress == null ? this.streetAddress : streetAddress.value,
      state: state == null ? this.state : state.value,
      city: city == null ? this.city : city.value,
      zipCode: zipCode == null ? this.zipCode : zipCode.value,
      details: details == null ? this.details : details.value,
      date: date == null ? this.date : date.value,
      time: time == null ? this.time : time.value,
      membersAttending: membersAttending == null ? this.membersAttending : membersAttending.value,
      membersNotAttending: membersNotAttending == null ? this.membersNotAttending : membersNotAttending.value,
      owner: owner == null ? this.owner : owner.value,
      leader: leader == null ? this.leader : leader.value,
      project: project == null ? this.project : project.value,
      eventPicture: eventPicture == null ? this.eventPicture : eventPicture.value,
      checkInCode: checkInCode == null ? this.checkInCode : checkInCode.value,
      uEventOwnerId: uEventOwnerId == null ? this.uEventOwnerId : uEventOwnerId.value,
      uEventLeaderId: uEventLeaderId == null ? this.uEventLeaderId : uEventLeaderId.value
    );
  }
  
  UEvent.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _name = json['name'],
      _streetAddress = json['streetAddress'],
      _state = json['state'],
      _city = json['city'],
      _zipCode = json['zipCode'],
      _details = json['details'],
      _date = json['date'],
      _time = json['time'],
      _membersAttending = json['membersAttending']?.cast<String>(),
      _membersNotAttending = json['membersNotAttending']?.cast<String>(),
      _owner = json['owner']?['serializedData'] != null
        ? UUser.fromJson(new Map<String, dynamic>.from(json['owner']['serializedData']))
        : null,
      _leader = json['leader']?['serializedData'] != null
        ? UUser.fromJson(new Map<String, dynamic>.from(json['leader']['serializedData']))
        : null,
      _project = json['project']?['serializedData'] != null
        ? UProject.fromJson(new Map<String, dynamic>.from(json['project']['serializedData']))
        : null,
      _eventPicture = json['eventPicture'],
      _checkInCode = json['checkInCode'],
      _createdAt = json['createdAt'] != null ? amplify_core.TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? amplify_core.TemporalDateTime.fromString(json['updatedAt']) : null,
      _uEventOwnerId = json['uEventOwnerId'],
      _uEventLeaderId = json['uEventLeaderId'];
  
  Map<String, dynamic> toJson() => {
    'id': id, 'name': _name, 'streetAddress': _streetAddress, 'state': _state, 'city': _city, 'zipCode': _zipCode, 'details': _details, 'date': _date, 'time': _time, 'membersAttending': _membersAttending, 'membersNotAttending': _membersNotAttending, 'owner': _owner?.toJson(), 'leader': _leader?.toJson(), 'project': _project?.toJson(), 'eventPicture': _eventPicture, 'checkInCode': _checkInCode, 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format(), 'uEventOwnerId': _uEventOwnerId, 'uEventLeaderId': _uEventLeaderId
  };
  
  Map<String, Object?> toMap() => {
    'id': id,
    'name': _name,
    'streetAddress': _streetAddress,
    'state': _state,
    'city': _city,
    'zipCode': _zipCode,
    'details': _details,
    'date': _date,
    'time': _time,
    'membersAttending': _membersAttending,
    'membersNotAttending': _membersNotAttending,
    'owner': _owner,
    'leader': _leader,
    'project': _project,
    'eventPicture': _eventPicture,
    'checkInCode': _checkInCode,
    'createdAt': _createdAt,
    'updatedAt': _updatedAt,
    'uEventOwnerId': _uEventOwnerId,
    'uEventLeaderId': _uEventLeaderId
  };

  static final amplify_core.QueryModelIdentifier<UEventModelIdentifier> MODEL_IDENTIFIER = amplify_core.QueryModelIdentifier<UEventModelIdentifier>();
  static final ID = amplify_core.QueryField(fieldName: "id");
  static final NAME = amplify_core.QueryField(fieldName: "name");
  static final STREETADDRESS = amplify_core.QueryField(fieldName: "streetAddress");
  static final STATE = amplify_core.QueryField(fieldName: "state");
  static final CITY = amplify_core.QueryField(fieldName: "city");
  static final ZIPCODE = amplify_core.QueryField(fieldName: "zipCode");
  static final DETAILS = amplify_core.QueryField(fieldName: "details");
  static final DATE = amplify_core.QueryField(fieldName: "date");
  static final TIME = amplify_core.QueryField(fieldName: "time");
  static final MEMBERSATTENDING = amplify_core.QueryField(fieldName: "membersAttending");
  static final MEMBERSNOTATTENDING = amplify_core.QueryField(fieldName: "membersNotAttending");
  static final OWNER = amplify_core.QueryField(
    fieldName: "owner",
    fieldType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.model, ofModelName: 'UUser'));
  static final LEADER = amplify_core.QueryField(
    fieldName: "leader",
    fieldType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.model, ofModelName: 'UUser'));
  static final PROJECT = amplify_core.QueryField(
    fieldName: "project",
    fieldType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.model, ofModelName: 'UProject'));
  static final EVENTPICTURE = amplify_core.QueryField(fieldName: "eventPicture");
  static final CHECKINCODE = amplify_core.QueryField(fieldName: "checkInCode");
  static final UEVENTOWNERID = amplify_core.QueryField(fieldName: "uEventOwnerId");
  static final UEVENTLEADERID = amplify_core.QueryField(fieldName: "uEventLeaderId");
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
      key: UEvent.STREETADDRESS,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: UEvent.STATE,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: UEvent.CITY,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: UEvent.ZIPCODE,
      isRequired: false,
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
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: UEvent.MEMBERSATTENDING,
      isRequired: false,
      isArray: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.collection, ofModelName: amplify_core.ModelFieldTypeEnum.string.name)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: UEvent.MEMBERSNOTATTENDING,
      isRequired: false,
      isArray: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.collection, ofModelName: amplify_core.ModelFieldTypeEnum.string.name)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.hasOne(
      key: UEvent.OWNER,
      isRequired: false,
      ofModelName: 'UUser',
      associatedKey: UUser.ID
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.hasOne(
      key: UEvent.LEADER,
      isRequired: false,
      ofModelName: 'UUser',
      associatedKey: UUser.ID
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
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: UEvent.CHECKINCODE,
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
      key: UEvent.UEVENTOWNERID,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: UEvent.UEVENTLEADERID,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
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