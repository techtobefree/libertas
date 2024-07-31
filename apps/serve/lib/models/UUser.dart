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


/** This is an auto generated class representing the UUser type in your schema. */
class UUser extends amplify_core.Model {
  static const classType = const _UUserModelType();
  final String id;
  final String? _password;
  final String? _email;
  final String? _firstName;
  final String? _lastName;
  final String? _profilePictureUrl;
  final String? _coverPictureUrl;
  final List<UProject>? _projects;
  final List<String>? _friends;
  final List<UPost>? _posts;
  final List<USponsor>? _sponsors;
  final List<UNotification>? _notificationsSent;
  final List<UNotification>? _notificationsReceived;
  final String? _bio;
  final String? _city;
  final String? _state;
  final int? _pointsBalance;
  final List<UPoints>? _pointsactions;
  final amplify_core.TemporalDateTime? _createdAt;
  final amplify_core.TemporalDateTime? _updatedAt;

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
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  String get email {
    try {
      return _email!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  String get firstName {
    try {
      return _firstName!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  String get lastName {
    try {
      return _lastName!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
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
  
  List<String>? get friends {
    return _friends;
  }
  
  List<UPost>? get posts {
    return _posts;
  }
  
  List<USponsor>? get sponsors {
    return _sponsors;
  }
  
  List<UNotification>? get notificationsSent {
    return _notificationsSent;
  }
  
  List<UNotification>? get notificationsReceived {
    return _notificationsReceived;
  }
  
  String? get bio {
    return _bio;
  }
  
  String? get city {
    return _city;
  }
  
  String? get state {
    return _state;
  }
  
  int? get pointsBalance {
    return _pointsBalance;
  }
  
  List<UPoints>? get pointsactions {
    return _pointsactions;
  }
  
  amplify_core.TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  amplify_core.TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  const UUser._internal({required this.id, required password, required email, required firstName, required lastName, profilePictureUrl, coverPictureUrl, projects, friends, posts, sponsors, notificationsSent, notificationsReceived, bio, city, state, pointsBalance, pointsactions, createdAt, updatedAt}): _password = password, _email = email, _firstName = firstName, _lastName = lastName, _profilePictureUrl = profilePictureUrl, _coverPictureUrl = coverPictureUrl, _projects = projects, _friends = friends, _posts = posts, _sponsors = sponsors, _notificationsSent = notificationsSent, _notificationsReceived = notificationsReceived, _bio = bio, _city = city, _state = state, _pointsBalance = pointsBalance, _pointsactions = pointsactions, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory UUser({String? id, required String password, required String email, required String firstName, required String lastName, String? profilePictureUrl, String? coverPictureUrl, List<UProject>? projects, List<String>? friends, List<UPost>? posts, List<USponsor>? sponsors, List<UNotification>? notificationsSent, List<UNotification>? notificationsReceived, String? bio, String? city, String? state, int? pointsBalance, List<UPoints>? pointsactions}) {
    return UUser._internal(
      id: id == null ? amplify_core.UUID.getUUID() : id,
      password: password,
      email: email,
      firstName: firstName,
      lastName: lastName,
      profilePictureUrl: profilePictureUrl,
      coverPictureUrl: coverPictureUrl,
      projects: projects != null ? List<UProject>.unmodifiable(projects) : projects,
      friends: friends != null ? List<String>.unmodifiable(friends) : friends,
      posts: posts != null ? List<UPost>.unmodifiable(posts) : posts,
      sponsors: sponsors != null ? List<USponsor>.unmodifiable(sponsors) : sponsors,
      notificationsSent: notificationsSent != null ? List<UNotification>.unmodifiable(notificationsSent) : notificationsSent,
      notificationsReceived: notificationsReceived != null ? List<UNotification>.unmodifiable(notificationsReceived) : notificationsReceived,
      bio: bio,
      city: city,
      state: state,
      pointsBalance: pointsBalance,
      pointsactions: pointsactions != null ? List<UPoints>.unmodifiable(pointsactions) : pointsactions);
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
      DeepCollectionEquality().equals(_notificationsSent, other._notificationsSent) &&
      DeepCollectionEquality().equals(_notificationsReceived, other._notificationsReceived) &&
      _bio == other._bio &&
      _city == other._city &&
      _state == other._state &&
      _pointsBalance == other._pointsBalance &&
      DeepCollectionEquality().equals(_pointsactions, other._pointsactions);
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
    buffer.write("friends=" + (_friends != null ? _friends!.toString() : "null") + ", ");
    buffer.write("bio=" + "$_bio" + ", ");
    buffer.write("city=" + "$_city" + ", ");
    buffer.write("state=" + "$_state" + ", ");
    buffer.write("pointsBalance=" + (_pointsBalance != null ? _pointsBalance!.toString() : "null") + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  UUser copyWith({String? password, String? email, String? firstName, String? lastName, String? profilePictureUrl, String? coverPictureUrl, List<UProject>? projects, List<String>? friends, List<UPost>? posts, List<USponsor>? sponsors, List<UNotification>? notificationsSent, List<UNotification>? notificationsReceived, String? bio, String? city, String? state, int? pointsBalance, List<UPoints>? pointsactions}) {
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
      notificationsSent: notificationsSent ?? this.notificationsSent,
      notificationsReceived: notificationsReceived ?? this.notificationsReceived,
      bio: bio ?? this.bio,
      city: city ?? this.city,
      state: state ?? this.state,
      pointsBalance: pointsBalance ?? this.pointsBalance,
      pointsactions: pointsactions ?? this.pointsactions);
  }
  
  UUser copyWithModelFieldValues({
    ModelFieldValue<String>? password,
    ModelFieldValue<String>? email,
    ModelFieldValue<String>? firstName,
    ModelFieldValue<String>? lastName,
    ModelFieldValue<String?>? profilePictureUrl,
    ModelFieldValue<String?>? coverPictureUrl,
    ModelFieldValue<List<UProject>?>? projects,
    ModelFieldValue<List<String>?>? friends,
    ModelFieldValue<List<UPost>?>? posts,
    ModelFieldValue<List<USponsor>?>? sponsors,
    ModelFieldValue<List<UNotification>?>? notificationsSent,
    ModelFieldValue<List<UNotification>?>? notificationsReceived,
    ModelFieldValue<String?>? bio,
    ModelFieldValue<String?>? city,
    ModelFieldValue<String?>? state,
    ModelFieldValue<int?>? pointsBalance,
    ModelFieldValue<List<UPoints>?>? pointsactions
  }) {
    return UUser._internal(
      id: id,
      password: password == null ? this.password : password.value,
      email: email == null ? this.email : email.value,
      firstName: firstName == null ? this.firstName : firstName.value,
      lastName: lastName == null ? this.lastName : lastName.value,
      profilePictureUrl: profilePictureUrl == null ? this.profilePictureUrl : profilePictureUrl.value,
      coverPictureUrl: coverPictureUrl == null ? this.coverPictureUrl : coverPictureUrl.value,
      projects: projects == null ? this.projects : projects.value,
      friends: friends == null ? this.friends : friends.value,
      posts: posts == null ? this.posts : posts.value,
      sponsors: sponsors == null ? this.sponsors : sponsors.value,
      notificationsSent: notificationsSent == null ? this.notificationsSent : notificationsSent.value,
      notificationsReceived: notificationsReceived == null ? this.notificationsReceived : notificationsReceived.value,
      bio: bio == null ? this.bio : bio.value,
      city: city == null ? this.city : city.value,
      state: state == null ? this.state : state.value,
      pointsBalance: pointsBalance == null ? this.pointsBalance : pointsBalance.value,
      pointsactions: pointsactions == null ? this.pointsactions : pointsactions.value
    );
  }
  
  UUser.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _password = json['password'],
      _email = json['email'],
      _firstName = json['firstName'],
      _lastName = json['lastName'],
      _profilePictureUrl = json['profilePictureUrl'],
      _coverPictureUrl = json['coverPictureUrl'],
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
      _friends = json['friends']?.cast<String>(),
      _posts = json['posts']  is Map
        ? (json['posts']['items'] is List
          ? (json['posts']['items'] as List)
              .where((e) => e != null)
              .map((e) => UPost.fromJson(new Map<String, dynamic>.from(e)))
              .toList()
          : null)
        : (json['posts'] is List
          ? (json['posts'] as List)
              .where((e) => e?['serializedData'] != null)
              .map((e) => UPost.fromJson(new Map<String, dynamic>.from(e?['serializedData'])))
              .toList()
          : null),
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
      _notificationsSent = json['notificationsSent']  is Map
        ? (json['notificationsSent']['items'] is List
          ? (json['notificationsSent']['items'] as List)
              .where((e) => e != null)
              .map((e) => UNotification.fromJson(new Map<String, dynamic>.from(e)))
              .toList()
          : null)
        : (json['notificationsSent'] is List
          ? (json['notificationsSent'] as List)
              .where((e) => e?['serializedData'] != null)
              .map((e) => UNotification.fromJson(new Map<String, dynamic>.from(e?['serializedData'])))
              .toList()
          : null),
      _notificationsReceived = json['notificationsReceived']  is Map
        ? (json['notificationsReceived']['items'] is List
          ? (json['notificationsReceived']['items'] as List)
              .where((e) => e != null)
              .map((e) => UNotification.fromJson(new Map<String, dynamic>.from(e)))
              .toList()
          : null)
        : (json['notificationsReceived'] is List
          ? (json['notificationsReceived'] as List)
              .where((e) => e?['serializedData'] != null)
              .map((e) => UNotification.fromJson(new Map<String, dynamic>.from(e?['serializedData'])))
              .toList()
          : null),
      _bio = json['bio'],
      _city = json['city'],
      _state = json['state'],
      _pointsBalance = (json['pointsBalance'] as num?)?.toInt(),
      _pointsactions = json['pointsactions']  is Map
        ? (json['pointsactions']['items'] is List
          ? (json['pointsactions']['items'] as List)
              .where((e) => e != null)
              .map((e) => UPoints.fromJson(new Map<String, dynamic>.from(e)))
              .toList()
          : null)
        : (json['pointsactions'] is List
          ? (json['pointsactions'] as List)
              .where((e) => e?['serializedData'] != null)
              .map((e) => UPoints.fromJson(new Map<String, dynamic>.from(e?['serializedData'])))
              .toList()
          : null),
      _createdAt = json['createdAt'] != null ? amplify_core.TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? amplify_core.TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'password': _password, 'email': _email, 'firstName': _firstName, 'lastName': _lastName, 'profilePictureUrl': _profilePictureUrl, 'coverPictureUrl': _coverPictureUrl, 'projects': _projects?.map((UProject? e) => e?.toJson()).toList(), 'friends': _friends, 'posts': _posts?.map((UPost? e) => e?.toJson()).toList(), 'sponsors': _sponsors?.map((USponsor? e) => e?.toJson()).toList(), 'notificationsSent': _notificationsSent?.map((UNotification? e) => e?.toJson()).toList(), 'notificationsReceived': _notificationsReceived?.map((UNotification? e) => e?.toJson()).toList(), 'bio': _bio, 'city': _city, 'state': _state, 'pointsBalance': _pointsBalance, 'pointsactions': _pointsactions?.map((UPoints? e) => e?.toJson()).toList(), 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };
  
  Map<String, Object?> toMap() => {
    'id': id,
    'password': _password,
    'email': _email,
    'firstName': _firstName,
    'lastName': _lastName,
    'profilePictureUrl': _profilePictureUrl,
    'coverPictureUrl': _coverPictureUrl,
    'projects': _projects,
    'friends': _friends,
    'posts': _posts,
    'sponsors': _sponsors,
    'notificationsSent': _notificationsSent,
    'notificationsReceived': _notificationsReceived,
    'bio': _bio,
    'city': _city,
    'state': _state,
    'pointsBalance': _pointsBalance,
    'pointsactions': _pointsactions,
    'createdAt': _createdAt,
    'updatedAt': _updatedAt
  };

  static final amplify_core.QueryModelIdentifier<UUserModelIdentifier> MODEL_IDENTIFIER = amplify_core.QueryModelIdentifier<UUserModelIdentifier>();
  static final ID = amplify_core.QueryField(fieldName: "id");
  static final PASSWORD = amplify_core.QueryField(fieldName: "password");
  static final EMAIL = amplify_core.QueryField(fieldName: "email");
  static final FIRSTNAME = amplify_core.QueryField(fieldName: "firstName");
  static final LASTNAME = amplify_core.QueryField(fieldName: "lastName");
  static final PROFILEPICTUREURL = amplify_core.QueryField(fieldName: "profilePictureUrl");
  static final COVERPICTUREURL = amplify_core.QueryField(fieldName: "coverPictureUrl");
  static final PROJECTS = amplify_core.QueryField(
    fieldName: "projects",
    fieldType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.model, ofModelName: 'UProject'));
  static final FRIENDS = amplify_core.QueryField(fieldName: "friends");
  static final POSTS = amplify_core.QueryField(
    fieldName: "posts",
    fieldType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.model, ofModelName: 'UPost'));
  static final SPONSORS = amplify_core.QueryField(
    fieldName: "sponsors",
    fieldType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.model, ofModelName: 'USponsor'));
  static final NOTIFICATIONSSENT = amplify_core.QueryField(
    fieldName: "notificationsSent",
    fieldType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.model, ofModelName: 'UNotification'));
  static final NOTIFICATIONSRECEIVED = amplify_core.QueryField(
    fieldName: "notificationsReceived",
    fieldType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.model, ofModelName: 'UNotification'));
  static final BIO = amplify_core.QueryField(fieldName: "bio");
  static final CITY = amplify_core.QueryField(fieldName: "city");
  static final STATE = amplify_core.QueryField(fieldName: "state");
  static final POINTSBALANCE = amplify_core.QueryField(fieldName: "pointsBalance");
  static final POINTSACTIONS = amplify_core.QueryField(
    fieldName: "pointsactions",
    fieldType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.model, ofModelName: 'UPoints'));
  static var schema = amplify_core.Model.defineSchema(define: (amplify_core.ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "UUser";
    modelSchemaDefinition.pluralName = "UUsers";
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.id());
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: UUser.PASSWORD,
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: UUser.EMAIL,
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: UUser.FIRSTNAME,
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: UUser.LASTNAME,
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: UUser.PROFILEPICTUREURL,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: UUser.COVERPICTUREURL,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.hasMany(
      key: UUser.PROJECTS,
      isRequired: false,
      ofModelName: 'UProject',
      associatedKey: UProject.UUSERPROJECTSID
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: UUser.FRIENDS,
      isRequired: false,
      isArray: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.collection, ofModelName: amplify_core.ModelFieldTypeEnum.string.name)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.hasMany(
      key: UUser.POSTS,
      isRequired: false,
      ofModelName: 'UPost',
      associatedKey: UPost.USER
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.hasMany(
      key: UUser.SPONSORS,
      isRequired: false,
      ofModelName: 'USponsor',
      associatedKey: USponsor.USER
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.hasMany(
      key: UUser.NOTIFICATIONSSENT,
      isRequired: false,
      ofModelName: 'UNotification',
      associatedKey: UNotification.RECEIVER
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.hasMany(
      key: UUser.NOTIFICATIONSRECEIVED,
      isRequired: false,
      ofModelName: 'UNotification',
      associatedKey: UNotification.RECEIVER
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: UUser.BIO,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: UUser.CITY,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: UUser.STATE,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: UUser.POINTSBALANCE,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.int)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.hasMany(
      key: UUser.POINTSACTIONS,
      isRequired: false,
      ofModelName: 'UPoints',
      associatedKey: UPoints.USER
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

class _UUserModelType extends amplify_core.ModelType<UUser> {
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
class UUserModelIdentifier implements amplify_core.ModelIdentifier<UUser> {
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