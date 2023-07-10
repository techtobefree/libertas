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


/** This is an auto generated class representing the UComment type in your schema. */
@immutable
class UComment extends Model {
  static const classType = const _UCommentModelType();
  final String id;
  final String? _content;
  final int? _likes;
  final List<UComment>? _comments;
  final UPost? _post;
  final TemporalDateTime? _createdAt;
  final TemporalDateTime? _updatedAt;
  final String? _uCommentCommentsId;

  @override
  getInstanceType() => classType;
  
  @Deprecated('[getId] is being deprecated in favor of custom primary key feature. Use getter [modelIdentifier] to get model identifier.')
  @override
  String getId() => id;
  
  UCommentModelIdentifier get modelIdentifier {
      return UCommentModelIdentifier(
        id: id
      );
  }
  
  String get content {
    try {
      return _content!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  int get likes {
    try {
      return _likes!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  List<UComment>? get comments {
    return _comments;
  }
  
  UPost? get post {
    return _post;
  }
  
  TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  String? get uCommentCommentsId {
    return _uCommentCommentsId;
  }
  
  const UComment._internal({required this.id, required content, required likes, comments, post, createdAt, updatedAt, uCommentCommentsId}): _content = content, _likes = likes, _comments = comments, _post = post, _createdAt = createdAt, _updatedAt = updatedAt, _uCommentCommentsId = uCommentCommentsId;
  
  factory UComment({String? id, required String content, required int likes, List<UComment>? comments, UPost? post, String? uCommentCommentsId}) {
    return UComment._internal(
      id: id == null ? UUID.getUUID() : id,
      content: content,
      likes: likes,
      comments: comments != null ? List<UComment>.unmodifiable(comments) : comments,
      post: post,
      uCommentCommentsId: uCommentCommentsId);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UComment &&
      id == other.id &&
      _content == other._content &&
      _likes == other._likes &&
      DeepCollectionEquality().equals(_comments, other._comments) &&
      _post == other._post &&
      _uCommentCommentsId == other._uCommentCommentsId;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("UComment {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("content=" + "$_content" + ", ");
    buffer.write("likes=" + (_likes != null ? _likes!.toString() : "null") + ", ");
    buffer.write("post=" + (_post != null ? _post!.toString() : "null") + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null") + ", ");
    buffer.write("uCommentCommentsId=" + "$_uCommentCommentsId");
    buffer.write("}");
    
    return buffer.toString();
  }
  
  UComment copyWith({String? content, int? likes, List<UComment>? comments, UPost? post, String? uCommentCommentsId}) {
    return UComment._internal(
      id: id,
      content: content ?? this.content,
      likes: likes ?? this.likes,
      comments: comments ?? this.comments,
      post: post ?? this.post,
      uCommentCommentsId: uCommentCommentsId ?? this.uCommentCommentsId);
  }
  
  UComment.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _content = json['content'],
      _likes = (json['likes'] as num?)?.toInt(),
      _comments = json['comments'] is List
        ? (json['comments'] as List)
          .where((e) => e?['serializedData'] != null)
          .map((e) => UComment.fromJson(new Map<String, dynamic>.from(e['serializedData'])))
          .toList()
        : null,
      _post = json['post']?['serializedData'] != null
        ? UPost.fromJson(new Map<String, dynamic>.from(json['post']['serializedData']))
        : null,
      _createdAt = json['createdAt'] != null ? TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? TemporalDateTime.fromString(json['updatedAt']) : null,
      _uCommentCommentsId = json['uCommentCommentsId'];
  
  Map<String, dynamic> toJson() => {
    'id': id, 'content': _content, 'likes': _likes, 'comments': _comments?.map((UComment? e) => e?.toJson()).toList(), 'post': _post?.toJson(), 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format(), 'uCommentCommentsId': _uCommentCommentsId
  };
  
  Map<String, Object?> toMap() => {
    'id': id, 'content': _content, 'likes': _likes, 'comments': _comments, 'post': _post, 'createdAt': _createdAt, 'updatedAt': _updatedAt, 'uCommentCommentsId': _uCommentCommentsId
  };

  static final QueryModelIdentifier<UCommentModelIdentifier> MODEL_IDENTIFIER = QueryModelIdentifier<UCommentModelIdentifier>();
  static final QueryField ID = QueryField(fieldName: "id");
  static final QueryField CONTENT = QueryField(fieldName: "content");
  static final QueryField LIKES = QueryField(fieldName: "likes");
  static final QueryField COMMENTS = QueryField(
    fieldName: "comments",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: 'UComment'));
  static final QueryField POST = QueryField(
    fieldName: "post",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: 'UPost'));
  static final QueryField UCOMMENTCOMMENTSID = QueryField(fieldName: "uCommentCommentsId");
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "UComment";
    modelSchemaDefinition.pluralName = "UComments";
    
    modelSchemaDefinition.addField(ModelFieldDefinition.id());
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: UComment.CONTENT,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: UComment.LIKES,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.int)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.hasMany(
      key: UComment.COMMENTS,
      isRequired: false,
      ofModelName: 'UComment',
      associatedKey: UComment.UCOMMENTCOMMENTSID
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.belongsTo(
      key: UComment.POST,
      isRequired: false,
      targetNames: ['uPostCommentsId'],
      ofModelName: 'UPost'
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
      key: UComment.UCOMMENTCOMMENTSID,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
  });
}

class _UCommentModelType extends ModelType<UComment> {
  const _UCommentModelType();
  
  @override
  UComment fromJson(Map<String, dynamic> jsonData) {
    return UComment.fromJson(jsonData);
  }
  
  @override
  String modelName() {
    return 'UComment';
  }
}

/**
 * This is an auto generated class representing the model identifier
 * of [UComment] in your schema.
 */
@immutable
class UCommentModelIdentifier implements ModelIdentifier<UComment> {
  final String id;

  /** Create an instance of UCommentModelIdentifier using [id] the primary key. */
  const UCommentModelIdentifier({
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
  String toString() => 'UCommentModelIdentifier(id: $id)';
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    
    return other is UCommentModelIdentifier &&
      id == other.id;
  }
  
  @override
  int get hashCode =>
    id.hashCode;
}