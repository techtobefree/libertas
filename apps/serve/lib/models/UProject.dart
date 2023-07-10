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
import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';


/** This is an auto generated class representing the UProject type in your schema. */
@immutable
class UProject extends Model {
  static const classType = const _UProjectModelType();
  final String id;
  final String? _name;
  final String? _privacy;
  final String? _bio;
  final String? _description;
  final String? _city;
  final String? _state;
  final double? _hoursSpent;
  final String? _date;
  final List<String>? _members;
  final List<UPost>? _posts;
  final String? _projectPicture;
  final List<USponsor>? _sponsors;
  final bool? _isCompleted;
  final TemporalDateTime? _createdAt;
  final TemporalDateTime? _updatedAt;
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
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  String get privacy {
    try {
      return _privacy!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
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
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
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
  
  String? get date {
    return _date;
  }
  
  List<String>? get members {
    return _members;
  }
  
  List<UPost>? get posts {
    return _posts;
  }
  
  String get projectPicture {
    try {
      return _projectPicture!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  List<USponsor>? get sponsors {
    return _sponsors;
  }
  
  bool get isCompleted {
    try {
      return _isCompleted!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  String? get uUserProjectsId {
    return _uUserProjectsId;
  }
  
  const UProject._internal({required this.id, required name, required privacy, bio, required description, city, state, hoursSpent, date, members, posts, required projectPicture, sponsors, required isCompleted, createdAt, updatedAt, uUserProjectsId}): _name = name, _privacy = privacy, _bio = bio, _description = description, _city = city, _state = state, _hoursSpent = hoursSpent, _date = date, _members = members, _posts = posts, _projectPicture = projectPicture, _sponsors = sponsors, _isCompleted = isCompleted, _createdAt = createdAt, _updatedAt = updatedAt, _uUserProjectsId = uUserProjectsId;
  
  factory UProject({String? id, required String name, required String privacy, String? bio, required String description, String? city, String? state, double? hoursSpent, String? date, List<String>? members, List<UPost>? posts, required String projectPicture, List<USponsor>? sponsors, required bool isCompleted, String? uUserProjectsId}) {
    return UProject._internal(
      id: id == null ? UUID.getUUID() : id,
      name: name,
      privacy: privacy,
      bio: bio,
      description: description,
      city: city,
      state: state,
      hoursSpent: hoursSpent,
      date: date,
      members: members != null ? List<String>.unmodifiable(members) : members,
      posts: posts != null ? List<UPost>.unmodifiable(posts) : posts,
      projectPicture: projectPicture,
      sponsors: sponsors != null ? List<USponsor>.unmodifiable(sponsors) : sponsors,
      isCompleted: isCompleted,
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
      _date == other._date &&
      DeepCollectionEquality().equals(_members, other._members) &&
      DeepCollectionEquality().equals(_posts, other._posts) &&
      _projectPicture == other._projectPicture &&
      DeepCollectionEquality().equals(_sponsors, other._sponsors) &&
      _isCompleted == other._isCompleted &&
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
    buffer.write("date=" + "$_date" + ", ");
    buffer.write("members=" + (_members != null ? _members!.toString() : "null") + ", ");
    buffer.write("projectPicture=" + "$_projectPicture" + ", ");
    buffer.write("isCompleted=" + (_isCompleted != null ? _isCompleted!.toString() : "null") + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null") + ", ");
    buffer.write("uUserProjectsId=" + "$_uUserProjectsId");
    buffer.write("}");
    
    return buffer.toString();
  }
  
  UProject copyWith({String? name, String? privacy, String? bio, String? description, String? city, String? state, double? hoursSpent, String? date, List<String>? members, List<UPost>? posts, String? projectPicture, List<USponsor>? sponsors, bool? isCompleted, String? uUserProjectsId}) {
    return UProject._internal(
      id: id,
      name: name ?? this.name,
      privacy: privacy ?? this.privacy,
      bio: bio ?? this.bio,
      description: description ?? this.description,
      city: city ?? this.city,
      state: state ?? this.state,
      hoursSpent: hoursSpent ?? this.hoursSpent,
      date: date ?? this.date,
      members: members ?? this.members,
      posts: posts ?? this.posts,
      projectPicture: projectPicture ?? this.projectPicture,
      sponsors: sponsors ?? this.sponsors,
      isCompleted: isCompleted ?? this.isCompleted,
      uUserProjectsId: uUserProjectsId ?? this.uUserProjectsId);
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
      _date = json['date'],
      _members = json['members']?.cast<String>(),
      _posts = json['posts'] is List
        ? (json['posts'] as List)
          .where((e) => e?['serializedData'] != null)
          .map((e) => UPost.fromJson(new Map<String, dynamic>.from(e['serializedData'])))
          .toList()
        : null,
      _projectPicture = json['projectPicture'],
      _sponsors = json['sponsors'] is List
        ? (json['sponsors'] as List)
          .where((e) => e?['serializedData'] != null)
          .map((e) => USponsor.fromJson(new Map<String, dynamic>.from(e['serializedData'])))
          .toList()
        : null,
      _isCompleted = json['isCompleted'],
      _createdAt = json['createdAt'] != null ? TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? TemporalDateTime.fromString(json['updatedAt']) : null,
      _uUserProjectsId = json['uUserProjectsId'];
  
  Map<String, dynamic> toJson() => {
    'id': id, 'name': _name, 'privacy': _privacy, 'bio': _bio, 'description': _description, 'city': _city, 'state': _state, 'hoursSpent': _hoursSpent, 'date': _date, 'members': _members, 'posts': _posts?.map((UPost? e) => e?.toJson()).toList(), 'projectPicture': _projectPicture, 'sponsors': _sponsors?.map((USponsor? e) => e?.toJson()).toList(), 'isCompleted': _isCompleted, 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format(), 'uUserProjectsId': _uUserProjectsId
  };
  
  Map<String, Object?> toMap() => {
    'id': id, 'name': _name, 'privacy': _privacy, 'bio': _bio, 'description': _description, 'city': _city, 'state': _state, 'hoursSpent': _hoursSpent, 'date': _date, 'members': _members, 'posts': _posts, 'projectPicture': _projectPicture, 'sponsors': _sponsors, 'isCompleted': _isCompleted, 'createdAt': _createdAt, 'updatedAt': _updatedAt, 'uUserProjectsId': _uUserProjectsId
  };

  static final QueryModelIdentifier<UProjectModelIdentifier> MODEL_IDENTIFIER = QueryModelIdentifier<UProjectModelIdentifier>();
  static final QueryField ID = QueryField(fieldName: "id");
  static final QueryField NAME = QueryField(fieldName: "name");
  static final QueryField PRIVACY = QueryField(fieldName: "privacy");
  static final QueryField BIO = QueryField(fieldName: "bio");
  static final QueryField DESCRIPTION = QueryField(fieldName: "description");
  static final QueryField CITY = QueryField(fieldName: "city");
  static final QueryField STATE = QueryField(fieldName: "state");
  static final QueryField HOURSSPENT = QueryField(fieldName: "hoursSpent");
  static final QueryField DATE = QueryField(fieldName: "date");
  static final QueryField MEMBERS = QueryField(fieldName: "members");
  static final QueryField POSTS = QueryField(
    fieldName: "posts",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: 'UPost'));
  static final QueryField PROJECTPICTURE = QueryField(fieldName: "projectPicture");
  static final QueryField SPONSORS = QueryField(
    fieldName: "sponsors",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: 'USponsor'));
  static final QueryField ISCOMPLETED = QueryField(fieldName: "isCompleted");
  static final QueryField UUSERPROJECTSID = QueryField(fieldName: "uUserProjectsId");
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "UProject";
    modelSchemaDefinition.pluralName = "UProjects";
    
    modelSchemaDefinition.addField(ModelFieldDefinition.id());
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: UProject.NAME,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: UProject.PRIVACY,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: UProject.BIO,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: UProject.DESCRIPTION,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: UProject.CITY,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: UProject.STATE,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: UProject.HOURSSPENT,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.double)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: UProject.DATE,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: UProject.MEMBERS,
      isRequired: false,
      isArray: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.collection, ofModelName: describeEnum(ModelFieldTypeEnum.string))
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.hasMany(
      key: UProject.POSTS,
      isRequired: false,
      ofModelName: 'UPost',
      associatedKey: UPost.PROJECT
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: UProject.PROJECTPICTURE,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.hasMany(
      key: UProject.SPONSORS,
      isRequired: false,
      ofModelName: 'USponsor',
      associatedKey: USponsor.UPROJECTSPONSORSID
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: UProject.ISCOMPLETED,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.bool)
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
      key: UProject.UUSERPROJECTSID,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
  });
}

class _UProjectModelType extends ModelType<UProject> {
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
@immutable
class UProjectModelIdentifier implements ModelIdentifier<UProject> {
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