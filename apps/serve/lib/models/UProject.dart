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
import 'package:collection/collection.dart';


/** This is an auto generated class representing the UProject type in your schema. */
class UProject extends amplify_core.Model {
  static const classType = const _UProjectModelType();
  final String id;
  final String? _name;
  final String? _privacy;
  final String? _bio;
  final String? _description;
  final String? _city;
  final String? _state;
  final double? _hoursSpent;
  final String? _leader;
  final String? _date;
  final List<String>? _members;
  final List<String>? _posts;
  final String? _projectPicture;
  final List<USponsor>? _sponsors;
  final List<UNotification>? _notifications;
  final bool? _isCompleted;
  final List<UEvent>? _events;
  final String? _zipCode;
  final amplify_core.TemporalDateTime? _createdAt;
  final amplify_core.TemporalDateTime? _updatedAt;
  final String? _uUserProjectsId;

  @override
  getInstanceType() => classType;
  
  @Deprecated('[getId] is being deprecated in favor of custom primary key feature. Use getter [modelIdentifier] to get model identifier.')
  @override
  String getId() => id;
  
  UProjectModelIdentifier get modelIdentifier {
      return UProjectModelIdentifier(
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
  
  String get privacy {
    try {
      return _privacy!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  String? get bio {
    return _bio;
  }
  
  String get description {
    try {
      return _description!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  String? get city {
    return _city;
  }
  
  String? get state {
    return _state;
  }
  
  double? get hoursSpent {
    return _hoursSpent;
  }
  
  String? get leader {
    return _leader;
  }
  
  String? get date {
    return _date;
  }
  
  List<String>? get members {
    return _members;
  }
  
  List<String>? get posts {
    return _posts;
  }
  
  String get projectPicture {
    try {
      return _projectPicture!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  List<USponsor>? get sponsors {
    return _sponsors;
  }
  
  List<UNotification>? get notifications {
    return _notifications;
  }
  
  bool get isCompleted {
    try {
      return _isCompleted!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  List<UEvent>? get events {
    return _events;
  }
  
  String? get zipCode {
    return _zipCode;
  }
  
  amplify_core.TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  amplify_core.TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  String? get uUserProjectsId {
    return _uUserProjectsId;
  }
  
  const UProject._internal({required this.id, required name, required privacy, bio, required description, city, state, hoursSpent, leader, date, members, posts, required projectPicture, sponsors, notifications, required isCompleted, events, zipCode, createdAt, updatedAt, uUserProjectsId}): _name = name, _privacy = privacy, _bio = bio, _description = description, _city = city, _state = state, _hoursSpent = hoursSpent, _leader = leader, _date = date, _members = members, _posts = posts, _projectPicture = projectPicture, _sponsors = sponsors, _notifications = notifications, _isCompleted = isCompleted, _events = events, _zipCode = zipCode, _createdAt = createdAt, _updatedAt = updatedAt, _uUserProjectsId = uUserProjectsId;
  
  factory UProject({String? id, required String name, required String privacy, String? bio, required String description, String? city, String? state, double? hoursSpent, String? leader, String? date, List<String>? members, List<String>? posts, required String projectPicture, List<USponsor>? sponsors, List<UNotification>? notifications, required bool isCompleted, List<UEvent>? events, String? zipCode, String? uUserProjectsId}) {
    return UProject._internal(
      id: id == null ? amplify_core.UUID.getUUID() : id,
      name: name,
      privacy: privacy,
      bio: bio,
      description: description,
      city: city,
      state: state,
      hoursSpent: hoursSpent,
      leader: leader,
      date: date,
      members: members != null ? List<String>.unmodifiable(members) : members,
      posts: posts != null ? List<String>.unmodifiable(posts) : posts,
      projectPicture: projectPicture,
      sponsors: sponsors != null ? List<USponsor>.unmodifiable(sponsors) : sponsors,
      notifications: notifications != null ? List<UNotification>.unmodifiable(notifications) : notifications,
      isCompleted: isCompleted,
      events: events != null ? List<UEvent>.unmodifiable(events) : events,
      zipCode: zipCode,
      uUserProjectsId: uUserProjectsId);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UProject &&
      id == other.id &&
      _name == other._name &&
      _privacy == other._privacy &&
      _bio == other._bio &&
      _description == other._description &&
      _city == other._city &&
      _state == other._state &&
      _hoursSpent == other._hoursSpent &&
      _leader == other._leader &&
      _date == other._date &&
      DeepCollectionEquality().equals(_members, other._members) &&
      DeepCollectionEquality().equals(_posts, other._posts) &&
      _projectPicture == other._projectPicture &&
      DeepCollectionEquality().equals(_sponsors, other._sponsors) &&
      DeepCollectionEquality().equals(_notifications, other._notifications) &&
      _isCompleted == other._isCompleted &&
      DeepCollectionEquality().equals(_events, other._events) &&
      _zipCode == other._zipCode &&
      _uUserProjectsId == other._uUserProjectsId;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("UProject {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("name=" + "$_name" + ", ");
    buffer.write("privacy=" + "$_privacy" + ", ");
    buffer.write("bio=" + "$_bio" + ", ");
    buffer.write("description=" + "$_description" + ", ");
    buffer.write("city=" + "$_city" + ", ");
    buffer.write("state=" + "$_state" + ", ");
    buffer.write("hoursSpent=" + (_hoursSpent != null ? _hoursSpent!.toString() : "null") + ", ");
    buffer.write("leader=" + "$_leader" + ", ");
    buffer.write("date=" + "$_date" + ", ");
    buffer.write("members=" + (_members != null ? _members!.toString() : "null") + ", ");
    buffer.write("posts=" + (_posts != null ? _posts!.toString() : "null") + ", ");
    buffer.write("projectPicture=" + "$_projectPicture" + ", ");
    buffer.write("isCompleted=" + (_isCompleted != null ? _isCompleted!.toString() : "null") + ", ");
    buffer.write("zipCode=" + "$_zipCode" + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null") + ", ");
    buffer.write("uUserProjectsId=" + "$_uUserProjectsId");
    buffer.write("}");
    
    return buffer.toString();
  }
  
  UProject copyWith({String? name, String? privacy, String? bio, String? description, String? city, String? state, double? hoursSpent, String? leader, String? date, List<String>? members, List<String>? posts, String? projectPicture, List<USponsor>? sponsors, List<UNotification>? notifications, bool? isCompleted, List<UEvent>? events, String? zipCode, String? uUserProjectsId}) {
    return UProject._internal(
      id: id,
      name: name ?? this.name,
      privacy: privacy ?? this.privacy,
      bio: bio ?? this.bio,
      description: description ?? this.description,
      city: city ?? this.city,
      state: state ?? this.state,
      hoursSpent: hoursSpent ?? this.hoursSpent,
      leader: leader ?? this.leader,
      date: date ?? this.date,
      members: members ?? this.members,
      posts: posts ?? this.posts,
      projectPicture: projectPicture ?? this.projectPicture,
      sponsors: sponsors ?? this.sponsors,
      notifications: notifications ?? this.notifications,
      isCompleted: isCompleted ?? this.isCompleted,
      events: events ?? this.events,
      zipCode: zipCode ?? this.zipCode,
      uUserProjectsId: uUserProjectsId ?? this.uUserProjectsId);
  }
  
  UProject copyWithModelFieldValues({
    ModelFieldValue<String>? name,
    ModelFieldValue<String>? privacy,
    ModelFieldValue<String?>? bio,
    ModelFieldValue<String>? description,
    ModelFieldValue<String?>? city,
    ModelFieldValue<String?>? state,
    ModelFieldValue<double?>? hoursSpent,
    ModelFieldValue<String?>? leader,
    ModelFieldValue<String?>? date,
    ModelFieldValue<List<String>?>? members,
    ModelFieldValue<List<String>?>? posts,
    ModelFieldValue<String>? projectPicture,
    ModelFieldValue<List<USponsor>?>? sponsors,
    ModelFieldValue<List<UNotification>?>? notifications,
    ModelFieldValue<bool>? isCompleted,
    ModelFieldValue<List<UEvent>?>? events,
    ModelFieldValue<String?>? zipCode,
    ModelFieldValue<String?>? uUserProjectsId
  }) {
    return UProject._internal(
      id: id,
      name: name == null ? this.name : name.value,
      privacy: privacy == null ? this.privacy : privacy.value,
      bio: bio == null ? this.bio : bio.value,
      description: description == null ? this.description : description.value,
      city: city == null ? this.city : city.value,
      state: state == null ? this.state : state.value,
      hoursSpent: hoursSpent == null ? this.hoursSpent : hoursSpent.value,
      leader: leader == null ? this.leader : leader.value,
      date: date == null ? this.date : date.value,
      members: members == null ? this.members : members.value,
      posts: posts == null ? this.posts : posts.value,
      projectPicture: projectPicture == null ? this.projectPicture : projectPicture.value,
      sponsors: sponsors == null ? this.sponsors : sponsors.value,
      notifications: notifications == null ? this.notifications : notifications.value,
      isCompleted: isCompleted == null ? this.isCompleted : isCompleted.value,
      events: events == null ? this.events : events.value,
      zipCode: zipCode == null ? this.zipCode : zipCode.value,
      uUserProjectsId: uUserProjectsId == null ? this.uUserProjectsId : uUserProjectsId.value
    );
  }
  
  UProject.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _name = json['name'],
      _privacy = json['privacy'],
      _bio = json['bio'],
      _description = json['description'],
      _city = json['city'],
      _state = json['state'],
      _hoursSpent = (json['hoursSpent'] as num?)?.toDouble(),
      _leader = json['leader'],
      _date = json['date'],
      _members = json['members']?.cast<String>(),
      _posts = json['posts']?.cast<String>(),
      _projectPicture = json['projectPicture'],
      _sponsors = json['sponsors']  is Map
        ? (json['sponsors']['items'] is List
          ? (json['sponsors']['items'] as List)
              .where((e) => e != null)
              .map((e) => USponsor.fromJson(new Map<String, dynamic>.from(e)))
              .toList()
          : null)
        : (json['sponsors'] is List
          ? (json['sponsors'] as List)
              .where((e) => e?['serializedData'] != null)
              .map((e) => USponsor.fromJson(new Map<String, dynamic>.from(e?['serializedData'])))
              .toList()
          : null),
      _notifications = json['notifications']  is Map
        ? (json['notifications']['items'] is List
          ? (json['notifications']['items'] as List)
              .where((e) => e != null)
              .map((e) => UNotification.fromJson(new Map<String, dynamic>.from(e)))
              .toList()
          : null)
        : (json['notifications'] is List
          ? (json['notifications'] as List)
              .where((e) => e?['serializedData'] != null)
              .map((e) => UNotification.fromJson(new Map<String, dynamic>.from(e?['serializedData'])))
              .toList()
          : null),
      _isCompleted = json['isCompleted'],
      _events = json['events']  is Map
        ? (json['events']['items'] is List
          ? (json['events']['items'] as List)
              .where((e) => e != null)
              .map((e) => UEvent.fromJson(new Map<String, dynamic>.from(e)))
              .toList()
          : null)
        : (json['events'] is List
          ? (json['events'] as List)
              .where((e) => e?['serializedData'] != null)
              .map((e) => UEvent.fromJson(new Map<String, dynamic>.from(e?['serializedData'])))
              .toList()
          : null),
      _zipCode = json['zipCode'],
      _createdAt = json['createdAt'] != null ? amplify_core.TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? amplify_core.TemporalDateTime.fromString(json['updatedAt']) : null,
      _uUserProjectsId = json['uUserProjectsId'];
  
  Map<String, dynamic> toJson() => {
    'id': id, 'name': _name, 'privacy': _privacy, 'bio': _bio, 'description': _description, 'city': _city, 'state': _state, 'hoursSpent': _hoursSpent, 'leader': _leader, 'date': _date, 'members': _members, 'posts': _posts, 'projectPicture': _projectPicture, 'sponsors': _sponsors?.map((USponsor? e) => e?.toJson()).toList(), 'notifications': _notifications?.map((UNotification? e) => e?.toJson()).toList(), 'isCompleted': _isCompleted, 'events': _events?.map((UEvent? e) => e?.toJson()).toList(), 'zipCode': _zipCode, 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format(), 'uUserProjectsId': _uUserProjectsId
  };
  
  Map<String, Object?> toMap() => {
    'id': id,
    'name': _name,
    'privacy': _privacy,
    'bio': _bio,
    'description': _description,
    'city': _city,
    'state': _state,
    'hoursSpent': _hoursSpent,
    'leader': _leader,
    'date': _date,
    'members': _members,
    'posts': _posts,
    'projectPicture': _projectPicture,
    'sponsors': _sponsors,
    'notifications': _notifications,
    'isCompleted': _isCompleted,
    'events': _events,
    'zipCode': _zipCode,
    'createdAt': _createdAt,
    'updatedAt': _updatedAt,
    'uUserProjectsId': _uUserProjectsId
  };

  static final amplify_core.QueryModelIdentifier<UProjectModelIdentifier> MODEL_IDENTIFIER = amplify_core.QueryModelIdentifier<UProjectModelIdentifier>();
  static final ID = amplify_core.QueryField(fieldName: "id");
  static final NAME = amplify_core.QueryField(fieldName: "name");
  static final PRIVACY = amplify_core.QueryField(fieldName: "privacy");
  static final BIO = amplify_core.QueryField(fieldName: "bio");
  static final DESCRIPTION = amplify_core.QueryField(fieldName: "description");
  static final CITY = amplify_core.QueryField(fieldName: "city");
  static final STATE = amplify_core.QueryField(fieldName: "state");
  static final HOURSSPENT = amplify_core.QueryField(fieldName: "hoursSpent");
  static final LEADER = amplify_core.QueryField(fieldName: "leader");
  static final DATE = amplify_core.QueryField(fieldName: "date");
  static final MEMBERS = amplify_core.QueryField(fieldName: "members");
  static final POSTS = amplify_core.QueryField(fieldName: "posts");
  static final PROJECTPICTURE = amplify_core.QueryField(fieldName: "projectPicture");
  static final SPONSORS = amplify_core.QueryField(
    fieldName: "sponsors",
    fieldType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.model, ofModelName: 'USponsor'));
  static final NOTIFICATIONS = amplify_core.QueryField(
    fieldName: "notifications",
    fieldType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.model, ofModelName: 'UNotification'));
  static final ISCOMPLETED = amplify_core.QueryField(fieldName: "isCompleted");
  static final EVENTS = amplify_core.QueryField(
    fieldName: "events",
    fieldType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.model, ofModelName: 'UEvent'));
  static final ZIPCODE = amplify_core.QueryField(fieldName: "zipCode");
  static final UUSERPROJECTSID = amplify_core.QueryField(fieldName: "uUserProjectsId");
  static var schema = amplify_core.Model.defineSchema(define: (amplify_core.ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "UProject";
    modelSchemaDefinition.pluralName = "UProjects";
    
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
      key: UProject.NAME,
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: UProject.PRIVACY,
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: UProject.BIO,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: UProject.DESCRIPTION,
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: UProject.CITY,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: UProject.STATE,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: UProject.HOURSSPENT,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.double)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: UProject.LEADER,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: UProject.DATE,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: UProject.MEMBERS,
      isRequired: false,
      isArray: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.collection, ofModelName: amplify_core.ModelFieldTypeEnum.string.name)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: UProject.POSTS,
      isRequired: false,
      isArray: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.collection, ofModelName: amplify_core.ModelFieldTypeEnum.string.name)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: UProject.PROJECTPICTURE,
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.hasMany(
      key: UProject.SPONSORS,
      isRequired: false,
      ofModelName: 'USponsor',
      associatedKey: USponsor.PROJECT
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.hasMany(
      key: UProject.NOTIFICATIONS,
      isRequired: false,
      ofModelName: 'UNotification',
      associatedKey: UNotification.PROJECT
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: UProject.ISCOMPLETED,
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.bool)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.hasMany(
      key: UProject.EVENTS,
      isRequired: false,
      ofModelName: 'UEvent',
      associatedKey: UEvent.PROJECT
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: UProject.ZIPCODE,
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
      key: UProject.UUSERPROJECTSID,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
  });
}

class _UProjectModelType extends amplify_core.ModelType<UProject> {
  const _UProjectModelType();
  
  @override
  UProject fromJson(Map<String, dynamic> jsonData) {
    return UProject.fromJson(jsonData);
  }
  
  @override
  String modelName() {
    return 'UProject';
  }
}

/**
 * This is an auto generated class representing the model identifier
 * of [UProject] in your schema.
 */
class UProjectModelIdentifier implements amplify_core.ModelIdentifier<UProject> {
  final String id;

  /** Create an instance of UProjectModelIdentifier using [id] the primary key. */
  const UProjectModelIdentifier({
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
  String toString() => 'UProjectModelIdentifier(id: $id)';
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    
    return other is UProjectModelIdentifier &&
      id == other.id;
  }
  
  @override
  int get hashCode =>
    id.hashCode;
}