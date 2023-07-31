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

/** This is an auto generated class representing the UPost type in your schema. */
@immutable
class UPost extends Model {
  static const classType = const _UPostModelType();
  final String id;
  final UUser? _user;
  final String? _content;
  final String? _date;
  final List<UComment>? _comments;
  final TemporalDateTime? _createdAt;
  final TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;

  @Deprecated(
      '[getId] is being deprecated in favor of custom primary key feature. Use getter [modelIdentifier] to get model identifier.')
  @override
  String getId() => id;

  UPostModelIdentifier get modelIdentifier {
    return UPostModelIdentifier(id: id);
  }

  UUser get user {
    try {
      return _user!;
    } catch (e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages
              .codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion: AmplifyExceptionMessages
              .codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString());
    }
  }

  String get content {
    try {
      return _content!;
    } catch (e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages
              .codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion: AmplifyExceptionMessages
              .codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString());
    }
  }

  String get date {
    try {
      return _date!;
    } catch (e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages
              .codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion: AmplifyExceptionMessages
              .codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString());
    }
  }

  List<UComment>? get comments {
    return _comments;
  }

  TemporalDateTime? get createdAt {
    return _createdAt;
  }

  TemporalDateTime? get updatedAt {
    return _updatedAt;
  }

  const UPost._internal(
      {required this.id,
      required user,
      required content,
      required date,
      comments,
      createdAt,
      updatedAt})
      : _user = user,
        _content = content,
        _date = date,
        _comments = comments,
        _createdAt = createdAt,
        _updatedAt = updatedAt;

  factory UPost(
      {String? id,
      required UUser user,
      required String content,
      required String date,
      List<UComment>? comments}) {
    return UPost._internal(
        id: id == null ? UUID.getUUID() : id,
        user: user,
        content: content,
        date: date,
        comments: comments != null
            ? List<UComment>.unmodifiable(comments)
            : comments);
  }

  bool equals(Object other) {
    return this == other;
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UPost &&
        id == other.id &&
        _user == other._user &&
        _content == other._content &&
        _date == other._date &&
        DeepCollectionEquality().equals(_comments, other._comments);
  }

  @override
  int get hashCode => toString().hashCode;

  @override
  String toString() {
    var buffer = new StringBuffer();

    buffer.write("UPost {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("user=" + (_user != null ? _user!.toString() : "null") + ", ");
    buffer.write("content=" + "$_content" + ", ");
    buffer.write("date=" + "$_date" + ", ");
    buffer.write("createdAt=" +
        (_createdAt != null ? _createdAt!.format() : "null") +
        ", ");
    buffer.write(
        "updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");

    return buffer.toString();
  }

  UPost copyWith(
      {UUser? user, String? content, String? date, List<UComment>? comments}) {
    return UPost._internal(
        id: id,
        user: user ?? this.user,
        content: content ?? this.content,
        date: date ?? this.date,
        comments: comments ?? this.comments);
  }

  UPost.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        _user = json['user']?['serializedData'] != null
            ? UUser.fromJson(
                new Map<String, dynamic>.from(json['user']['serializedData']))
            : null,
        _content = json['content'],
        _date = json['date'],
        _comments = json['comments'] is List
            ? (json['comments'] as List)
                .where((e) => e?['serializedData'] != null)
                .map((e) => UComment.fromJson(
                    new Map<String, dynamic>.from(e['serializedData'])))
                .toList()
            : null,
        _createdAt = json['createdAt'] != null
            ? TemporalDateTime.fromString(json['createdAt'])
            : null,
        _updatedAt = json['updatedAt'] != null
            ? TemporalDateTime.fromString(json['updatedAt'])
            : null;

  Map<String, dynamic> toJson() => {
        'id': id,
        'user': _user?.toJson(),
        'content': _content,
        'date': _date,
        'comments': _comments?.map((UComment? e) => e?.toJson()).toList(),
        'createdAt': _createdAt?.format(),
        'updatedAt': _updatedAt?.format()
      };

  Map<String, Object?> toMap() => {
        'id': id,
        'user': _user,
        'content': _content,
        'date': _date,
        'comments': _comments,
        'createdAt': _createdAt,
        'updatedAt': _updatedAt
      };

  static final QueryModelIdentifier<UPostModelIdentifier> MODEL_IDENTIFIER =
      QueryModelIdentifier<UPostModelIdentifier>();
  static final QueryField ID = QueryField(fieldName: "id");
  static final QueryField USER = QueryField(
      fieldName: "user",
      fieldType:
          ModelFieldType(ModelFieldTypeEnum.model, ofModelName: 'UUser'));
  static final QueryField CONTENT = QueryField(fieldName: "content");
  static final QueryField DATE = QueryField(fieldName: "date");
  static final QueryField COMMENTS = QueryField(
      fieldName: "comments",
      fieldType:
          ModelFieldType(ModelFieldTypeEnum.model, ofModelName: 'UComment'));
  static var schema =
      Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "UPost";
    modelSchemaDefinition.pluralName = "UPosts";

    modelSchemaDefinition.addField(ModelFieldDefinition.id());

    modelSchemaDefinition.addField(ModelFieldDefinition.belongsTo(
        key: UPost.USER,
        isRequired: true,
        targetNames: ['uUserPostsId'],
        ofModelName: 'UUser'));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: UPost.CONTENT,
        isRequired: true,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: UPost.DATE,
        isRequired: true,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.hasMany(
        key: UPost.COMMENTS,
        isRequired: false,
        ofModelName: 'UComment',
        associatedKey: UComment.POST));

    modelSchemaDefinition.addField(ModelFieldDefinition.nonQueryField(
        fieldName: 'createdAt',
        isRequired: false,
        isReadOnly: true,
        ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)));

    modelSchemaDefinition.addField(ModelFieldDefinition.nonQueryField(
        fieldName: 'updatedAt',
        isRequired: false,
        isReadOnly: true,
        ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)));
  });
}

class _UPostModelType extends ModelType<UPost> {
  const _UPostModelType();

  @override
  UPost fromJson(Map<String, dynamic> jsonData) {
    return UPost.fromJson(jsonData);
  }

  @override
  String modelName() {
    return 'UPost';
  }
}

/**
 * This is an auto generated class representing the model identifier
 * of [UPost] in your schema.
 */
@immutable
class UPostModelIdentifier implements ModelIdentifier<UPost> {
  final String id;

  /** Create an instance of UPostModelIdentifier using [id] the primary key. */
  const UPostModelIdentifier({required this.id});

  @override
  Map<String, dynamic> serializeAsMap() => (<String, dynamic>{'id': id});

  @override
  List<Map<String, dynamic>> serializeAsList() => serializeAsMap()
      .entries
      .map((entry) => (<String, dynamic>{entry.key: entry.value}))
      .toList();

  @override
  String serializeAsString() => serializeAsMap().values.join('#');

  @override
  String toString() => 'UPostModelIdentifier(id: $id)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }

    return other is UPostModelIdentifier && id == other.id;
  }

  @override
  int get hashCode => id.hashCode;
}
