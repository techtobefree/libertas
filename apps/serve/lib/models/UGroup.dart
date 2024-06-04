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


/** This is an auto generated class representing the UGroup type in your schema. */
class UGroup extends amplify_core.Model {
  static const classType = const _UGroupModelType();
  final String id;
  final String? _name;
  final String? _privacy;
  final String? _bio;
  final String? _description;
  final String? _city;
  final String? _state;
  final String? _leader;
  final String? _date;
  final List<UProject>? _projects;
  final List<String>? _members;
  final List<String>? _posts;
  final String? _groupPicture;
  final String? _zipCode;
  final amplify_core.TemporalDateTime? _createdAt;
  final amplify_core.TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;
  
  @Deprecated('[getId] is being deprecated in favor of custom primary key feature. Use getter [modelIdentifier] to get model identifier.')
  @override
  String getId() => id;
  
  UGroupModelIdentifier get modelIdentifier {
      return UGroupModelIdentifier(
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
  
  String? get leader {
    return _leader;
  }
  
  String? get date {
    return _date;
  }
  
  List<UProject>? get projects {
    return _projects;
  }
  
  List<String>? get members {
    return _members;
  }
  
  List<String>? get posts {
    return _posts;
  }
  
  String get groupPicture {
    try {
      return _groupPicture!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
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
  
  const UGroup._internal({required this.id, required name, required privacy, bio, required description, city, state, leader, date, projects, members, posts, required groupPicture, zipCode, createdAt, updatedAt}): _name = name, _privacy = privacy, _bio = bio, _description = description, _city = city, _state = state, _leader = leader, _date = date, _projects = projects, _members = members, _posts = posts, _groupPicture = groupPicture, _zipCode = zipCode, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory UGroup({String? id, required String name, required String privacy, String? bio, required String description, String? city, String? state, String? leader, String? date, List<UProject>? projects, List<String>? members, List<String>? posts, required String groupPicture, String? zipCode}) {
    return UGroup._internal(
      id: id == null ? amplify_core.UUID.getUUID() : id,
      name: name,
      privacy: privacy,
      bio: bio,
      description: description,
      city: city,
      state: state,
      leader: leader,
      date: date,
      projects: projects != null ? List<UProject>.unmodifiable(projects) : projects,
      members: members != null ? List<String>.unmodifiable(members) : members,
      posts: posts != null ? List<String>.unmodifiable(posts) : posts,
      groupPicture: groupPicture,
      zipCode: zipCode);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UGroup &&
      id == other.id &&
      _name == other._name &&
      _privacy == other._privacy &&
      _bio == other._bio &&
      _description == other._description &&
      _city == other._city &&
      _state == other._state &&
      _leader == other._leader &&
      _date == other._date &&
      DeepCollectionEquality().equals(_projects, other._projects) &&
      DeepCollectionEquality().equals(_members, other._members) &&
      DeepCollectionEquality().equals(_posts, other._posts) &&
      _groupPicture == other._groupPicture &&
      _zipCode == other._zipCode;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("UGroup {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("name=" + "$_name" + ", ");
    buffer.write("privacy=" + "$_privacy" + ", ");
    buffer.write("bio=" + "$_bio" + ", ");
    buffer.write("description=" + "$_description" + ", ");
    buffer.write("city=" + "$_city" + ", ");
    buffer.write("state=" + "$_state" + ", ");
    buffer.write("leader=" + "$_leader" + ", ");
    buffer.write("date=" + "$_date" + ", ");
    buffer.write("members=" + (_members != null ? _members!.toString() : "null") + ", ");
    buffer.write("posts=" + (_posts != null ? _posts!.toString() : "null") + ", ");
    buffer.write("groupPicture=" + "$_groupPicture" + ", ");
    buffer.write("zipCode=" + "$_zipCode" + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  UGroup copyWith({String? name, String? privacy, String? bio, String? description, String? city, String? state, String? leader, String? date, List<UProject>? projects, List<String>? members, List<String>? posts, String? groupPicture, String? zipCode}) {
    return UGroup._internal(
      id: id,
      name: name ?? this.name,
      privacy: privacy ?? this.privacy,
      bio: bio ?? this.bio,
      description: description ?? this.description,
      city: city ?? this.city,
      state: state ?? this.state,
      leader: leader ?? this.leader,
      date: date ?? this.date,
      projects: projects ?? this.projects,
      members: members ?? this.members,
      posts: posts ?? this.posts,
      groupPicture: groupPicture ?? this.groupPicture,
      zipCode: zipCode ?? this.zipCode);
  }
  
  UGroup copyWithModelFieldValues({
    ModelFieldValue<String>? name,
    ModelFieldValue<String>? privacy,
    ModelFieldValue<String?>? bio,
    ModelFieldValue<String>? description,
    ModelFieldValue<String?>? city,
    ModelFieldValue<String?>? state,
    ModelFieldValue<String?>? leader,
    ModelFieldValue<String?>? date,
    ModelFieldValue<List<UProject>?>? projects,
    ModelFieldValue<List<String>?>? members,
    ModelFieldValue<List<String>?>? posts,
    ModelFieldValue<String>? groupPicture,
    ModelFieldValue<String?>? zipCode
  }) {
    return UGroup._internal(
      id: id,
      name: name == null ? this.name : name.value,
      privacy: privacy == null ? this.privacy : privacy.value,
      bio: bio == null ? this.bio : bio.value,
      description: description == null ? this.description : description.value,
      city: city == null ? this.city : city.value,
      state: state == null ? this.state : state.value,
      leader: leader == null ? this.leader : leader.value,
      date: date == null ? this.date : date.value,
      projects: projects == null ? this.projects : projects.value,
      members: members == null ? this.members : members.value,
      posts: posts == null ? this.posts : posts.value,
      groupPicture: groupPicture == null ? this.groupPicture : groupPicture.value,
      zipCode: zipCode == null ? this.zipCode : zipCode.value
    );
  }
  
  UGroup.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _name = json['name'],
      _privacy = json['privacy'],
      _bio = json['bio'],
      _description = json['description'],
      _city = json['city'],
      _state = json['state'],
      _leader = json['leader'],
      _date = json['date'],
      _projects = json['projects']  is Map
        ? (json['projects']['items'] is List
          ? (json['projects']['items'] as List)
              .where((e) => e != null)
              .map((e) => UProject.fromJson(new Map<String, dynamic>.from(e)))
              .toList()
          : null)
        : (json['projects'] is List
          ? (json['projects'] as List)
              .where((e) => e?['serializedData'] != null)
              .map((e) => UProject.fromJson(new Map<String, dynamic>.from(e?['serializedData'])))
              .toList()
          : null),
      _members = json['members']?.cast<String>(),
      _posts = json['posts']?.cast<String>(),
      _groupPicture = json['groupPicture'],
      _zipCode = json['zipCode'],
      _createdAt = json['createdAt'] != null ? amplify_core.TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? amplify_core.TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'name': _name, 'privacy': _privacy, 'bio': _bio, 'description': _description, 'city': _city, 'state': _state, 'leader': _leader, 'date': _date, 'projects': _projects?.map((UProject? e) => e?.toJson()).toList(), 'members': _members, 'posts': _posts, 'groupPicture': _groupPicture, 'zipCode': _zipCode, 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };
  
  Map<String, Object?> toMap() => {
    'id': id,
    'name': _name,
    'privacy': _privacy,
    'bio': _bio,
    'description': _description,
    'city': _city,
    'state': _state,
    'leader': _leader,
    'date': _date,
    'projects': _projects,
    'members': _members,
    'posts': _posts,
    'groupPicture': _groupPicture,
    'zipCode': _zipCode,
    'createdAt': _createdAt,
    'updatedAt': _updatedAt
  };

  static final amplify_core.QueryModelIdentifier<UGroupModelIdentifier> MODEL_IDENTIFIER = amplify_core.QueryModelIdentifier<UGroupModelIdentifier>();
  static final ID = amplify_core.QueryField(fieldName: "id");
  static final NAME = amplify_core.QueryField(fieldName: "name");
  static final PRIVACY = amplify_core.QueryField(fieldName: "privacy");
  static final BIO = amplify_core.QueryField(fieldName: "bio");
  static final DESCRIPTION = amplify_core.QueryField(fieldName: "description");
  static final CITY = amplify_core.QueryField(fieldName: "city");
  static final STATE = amplify_core.QueryField(fieldName: "state");
  static final LEADER = amplify_core.QueryField(fieldName: "leader");
  static final DATE = amplify_core.QueryField(fieldName: "date");
  static final PROJECTS = amplify_core.QueryField(
    fieldName: "projects",
    fieldType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.model, ofModelName: 'UProject'));
  static final MEMBERS = amplify_core.QueryField(fieldName: "members");
  static final POSTS = amplify_core.QueryField(fieldName: "posts");
  static final GROUPPICTURE = amplify_core.QueryField(fieldName: "groupPicture");
  static final ZIPCODE = amplify_core.QueryField(fieldName: "zipCode");
  static var schema = amplify_core.Model.defineSchema(define: (amplify_core.ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "UGroup";
    modelSchemaDefinition.pluralName = "UGroups";
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.id());
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: UGroup.NAME,
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: UGroup.PRIVACY,
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: UGroup.BIO,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: UGroup.DESCRIPTION,
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: UGroup.CITY,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: UGroup.STATE,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: UGroup.LEADER,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: UGroup.DATE,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.hasMany(
      key: UGroup.PROJECTS,
      isRequired: false,
      ofModelName: 'UProject',
      associatedKey: UProject.UGROUPPROJECTSID
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: UGroup.MEMBERS,
      isRequired: false,
      isArray: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.collection, ofModelName: amplify_core.ModelFieldTypeEnum.string.name)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: UGroup.POSTS,
      isRequired: false,
      isArray: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.collection, ofModelName: amplify_core.ModelFieldTypeEnum.string.name)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: UGroup.GROUPPICTURE,
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: UGroup.ZIPCODE,
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

class _UGroupModelType extends amplify_core.ModelType<UGroup> {
  const _UGroupModelType();
  
  @override
  UGroup fromJson(Map<String, dynamic> jsonData) {
    return UGroup.fromJson(jsonData);
  }
  
  @override
  String modelName() {
    return 'UGroup';
  }
}

/**
 * This is an auto generated class representing the model identifier
 * of [UGroup] in your schema.
 */
class UGroupModelIdentifier implements amplify_core.ModelIdentifier<UGroup> {
  final String id;

  /** Create an instance of UGroupModelIdentifier using [id] the primary key. */
  const UGroupModelIdentifier({
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
  String toString() => 'UGroupModelIdentifier(id: $id)';
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    
    return other is UGroupModelIdentifier &&
      id == other.id;
  }
  
  @override
  int get hashCode =>
    id.hashCode;
}