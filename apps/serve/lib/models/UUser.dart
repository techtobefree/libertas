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


/** This is an auto generated class representing the UUser type in your schema. */
@immutable
class UUser extends Model {
  static const classType = const _UUserModelType();
  final String id;
  final String? _password;
  final String? _email;
  final String? _firstName;
  final String? _lastName;
  final String? _profilePictureUrl;
  final String? _coverPictureUrl;
  final List<UProject>? _projects;
  final List<UUser>? _friends;
  final List<UPost>? _posts;
  final List<USponsor>? _sponsors;
  final TemporalDateTime? _createdAt;
  final TemporalDateTime? _updatedAt;
  final String? _uUserFriendsId;

  @override
  getInstanceType() => classType;
  
  @Deprecated('[getId] is being deprecated in favor of custom primary key feature. Use getter [modelIdentifier] to get model identifier.')
  @override
  String getId() => id;
  
  UUserModelIdentifier get modelIdentifier {
      return UUserModelIdentifier(
        id: id
      );
  }
  
  String get password {
    try {
      return _password!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  String get email {
    try {
      return _email!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  String get firstName {
    try {
      return _firstName!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  String get lastName {
    try {
      return _lastName!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  String? get profilePictureUrl {
    return _profilePictureUrl;
  }
  
  String? get coverPictureUrl {
    return _coverPictureUrl;
  }
  
  List<UProject>? get projects {
    return _projects;
  }
  
  List<UUser>? get friends {
    return _friends;
  }
  
  List<UPost>? get posts {
    return _posts;
  }
  
  List<USponsor>? get sponsors {
    return _sponsors;
  }
  
  TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  String? get uUserFriendsId {
    return _uUserFriendsId;
  }
  
  const UUser._internal({required this.id, required password, required email, required firstName, required lastName, profilePictureUrl, coverPictureUrl, projects, friends, posts, sponsors, createdAt, updatedAt, uUserFriendsId}): _password = password, _email = email, _firstName = firstName, _lastName = lastName, _profilePictureUrl = profilePictureUrl, _coverPictureUrl = coverPictureUrl, _projects = projects, _friends = friends, _posts = posts, _sponsors = sponsors, _createdAt = createdAt, _updatedAt = updatedAt, _uUserFriendsId = uUserFriendsId;
  
  factory UUser({String? id, required String password, required String email, required String firstName, required String lastName, String? profilePictureUrl, String? coverPictureUrl, List<UProject>? projects, List<UUser>? friends, List<UPost>? posts, List<USponsor>? sponsors, String? uUserFriendsId}) {
    return UUser._internal(
      id: id == null ? UUID.getUUID() : id,
      password: password,
      email: email,
      firstName: firstName,
      lastName: lastName,
      profilePictureUrl: profilePictureUrl,
      coverPictureUrl: coverPictureUrl,
      projects: projects != null ? List<UProject>.unmodifiable(projects) : projects,
      friends: friends != null ? List<UUser>.unmodifiable(friends) : friends,
      posts: posts != null ? List<UPost>.unmodifiable(posts) : posts,
      sponsors: sponsors != null ? List<USponsor>.unmodifiable(sponsors) : sponsors,
      uUserFriendsId: uUserFriendsId);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UUser &&
      id == other.id &&
      _password == other._password &&
      _email == other._email &&
      _firstName == other._firstName &&
      _lastName == other._lastName &&
      _profilePictureUrl == other._profilePictureUrl &&
      _coverPictureUrl == other._coverPictureUrl &&
      DeepCollectionEquality().equals(_projects, other._projects) &&
      DeepCollectionEquality().equals(_friends, other._friends) &&
      DeepCollectionEquality().equals(_posts, other._posts) &&
      DeepCollectionEquality().equals(_sponsors, other._sponsors) &&
      _uUserFriendsId == other._uUserFriendsId;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("UUser {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("password=" + "$_password" + ", ");
    buffer.write("email=" + "$_email" + ", ");
    buffer.write("firstName=" + "$_firstName" + ", ");
    buffer.write("lastName=" + "$_lastName" + ", ");
    buffer.write("profilePictureUrl=" + "$_profilePictureUrl" + ", ");
    buffer.write("coverPictureUrl=" + "$_coverPictureUrl" + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null") + ", ");
    buffer.write("uUserFriendsId=" + "$_uUserFriendsId");
    buffer.write("}");
    
    return buffer.toString();
  }
  
  UUser copyWith({String? password, String? email, String? firstName, String? lastName, String? profilePictureUrl, String? coverPictureUrl, List<UProject>? projects, List<UUser>? friends, List<UPost>? posts, List<USponsor>? sponsors, String? uUserFriendsId}) {
    return UUser._internal(
      id: id,
      password: password ?? this.password,
      email: email ?? this.email,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      profilePictureUrl: profilePictureUrl ?? this.profilePictureUrl,
      coverPictureUrl: coverPictureUrl ?? this.coverPictureUrl,
      projects: projects ?? this.projects,
      friends: friends ?? this.friends,
      posts: posts ?? this.posts,
      sponsors: sponsors ?? this.sponsors,
      uUserFriendsId: uUserFriendsId ?? this.uUserFriendsId);
  }
  
  UUser.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _password = json['password'],
      _email = json['email'],
      _firstName = json['firstName'],
      _lastName = json['lastName'],
      _profilePictureUrl = json['profilePictureUrl'],
      _coverPictureUrl = json['coverPictureUrl'],
      _projects = json['projects'] is List
        ? (json['projects'] as List)
          .where((e) => e?['serializedData'] != null)
          .map((e) => UProject.fromJson(new Map<String, dynamic>.from(e['serializedData'])))
          .toList()
        : null,
      _friends = json['friends'] is List
        ? (json['friends'] as List)
          .where((e) => e?['serializedData'] != null)
          .map((e) => UUser.fromJson(new Map<String, dynamic>.from(e['serializedData'])))
          .toList()
        : null,
      _posts = json['posts'] is List
        ? (json['posts'] as List)
          .where((e) => e?['serializedData'] != null)
          .map((e) => UPost.fromJson(new Map<String, dynamic>.from(e['serializedData'])))
          .toList()
        : null,
      _sponsors = json['sponsors'] is List
        ? (json['sponsors'] as List)
          .where((e) => e?['serializedData'] != null)
          .map((e) => USponsor.fromJson(new Map<String, dynamic>.from(e['serializedData'])))
          .toList()
        : null,
      _createdAt = json['createdAt'] != null ? TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? TemporalDateTime.fromString(json['updatedAt']) : null,
      _uUserFriendsId = json['uUserFriendsId'];
  
  Map<String, dynamic> toJson() => {
    'id': id, 'password': _password, 'email': _email, 'firstName': _firstName, 'lastName': _lastName, 'profilePictureUrl': _profilePictureUrl, 'coverPictureUrl': _coverPictureUrl, 'projects': _projects?.map((UProject? e) => e?.toJson()).toList(), 'friends': _friends?.map((UUser? e) => e?.toJson()).toList(), 'posts': _posts?.map((UPost? e) => e?.toJson()).toList(), 'sponsors': _sponsors?.map((USponsor? e) => e?.toJson()).toList(), 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format(), 'uUserFriendsId': _uUserFriendsId
  };
  
  Map<String, Object?> toMap() => {
    'id': id, 'password': _password, 'email': _email, 'firstName': _firstName, 'lastName': _lastName, 'profilePictureUrl': _profilePictureUrl, 'coverPictureUrl': _coverPictureUrl, 'projects': _projects, 'friends': _friends, 'posts': _posts, 'sponsors': _sponsors, 'createdAt': _createdAt, 'updatedAt': _updatedAt, 'uUserFriendsId': _uUserFriendsId
  };

  static final QueryModelIdentifier<UUserModelIdentifier> MODEL_IDENTIFIER = QueryModelIdentifier<UUserModelIdentifier>();
  static final QueryField ID = QueryField(fieldName: "id");
  static final QueryField PASSWORD = QueryField(fieldName: "password");
  static final QueryField EMAIL = QueryField(fieldName: "email");
  static final QueryField FIRSTNAME = QueryField(fieldName: "firstName");
  static final QueryField LASTNAME = QueryField(fieldName: "lastName");
  static final QueryField PROFILEPICTUREURL = QueryField(fieldName: "profilePictureUrl");
  static final QueryField COVERPICTUREURL = QueryField(fieldName: "coverPictureUrl");
  static final QueryField PROJECTS = QueryField(
    fieldName: "projects",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: 'UProject'));
  static final QueryField FRIENDS = QueryField(
    fieldName: "friends",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: 'UUser'));
  static final QueryField POSTS = QueryField(
    fieldName: "posts",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: 'UPost'));
  static final QueryField SPONSORS = QueryField(
    fieldName: "sponsors",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: 'USponsor'));
  static final QueryField UUSERFRIENDSID = QueryField(fieldName: "uUserFriendsId");
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "UUser";
    modelSchemaDefinition.pluralName = "UUsers";
    
    modelSchemaDefinition.addField(ModelFieldDefinition.id());
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: UUser.PASSWORD,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: UUser.EMAIL,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: UUser.FIRSTNAME,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: UUser.LASTNAME,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: UUser.PROFILEPICTUREURL,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: UUser.COVERPICTUREURL,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.hasMany(
      key: UUser.PROJECTS,
      isRequired: false,
      ofModelName: 'UProject',
      associatedKey: UProject.UUSERPROJECTSID
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.hasMany(
      key: UUser.FRIENDS,
      isRequired: false,
      ofModelName: 'UUser',
      associatedKey: UUser.UUSERFRIENDSID
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.hasMany(
      key: UUser.POSTS,
      isRequired: false,
      ofModelName: 'UPost',
      associatedKey: UPost.USER
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.hasMany(
      key: UUser.SPONSORS,
      isRequired: false,
      ofModelName: 'USponsor',
      associatedKey: USponsor.USER
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
      key: UUser.UUSERFRIENDSID,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
  });
}

class _UUserModelType extends ModelType<UUser> {
  const _UUserModelType();
  
  @override
  UUser fromJson(Map<String, dynamic> jsonData) {
    return UUser.fromJson(jsonData);
  }
  
  @override
  String modelName() {
    return 'UUser';
  }
}

/**
 * This is an auto generated class representing the model identifier
 * of [UUser] in your schema.
 */
@immutable
class UUserModelIdentifier implements ModelIdentifier<UUser> {
  final String id;

  /** Create an instance of UUserModelIdentifier using [id] the primary key. */
  const UUserModelIdentifier({
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
  String toString() => 'UUserModelIdentifier(id: $id)';
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    
    return other is UUserModelIdentifier &&
      id == other.id;
  }
  
  @override
  int get hashCode =>
    id.hashCode;
}