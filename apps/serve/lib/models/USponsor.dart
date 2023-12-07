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


/** This is an auto generated class representing the USponsor type in your schema. */
class USponsor extends amplify_core.Model {
  static const classType = const _USponsorModelType();
  final String id;
  final double? _amount;
  final UUser? _user;
  final UProject? _project;
  final amplify_core.TemporalDateTime? _createdAt;
  final amplify_core.TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;
  
  @Deprecated('[getId] is being deprecated in favor of custom primary key feature. Use getter [modelIdentifier] to get model identifier.')
  @override
  String getId() => id;
  
  USponsorModelIdentifier get modelIdentifier {
      return USponsorModelIdentifier(
        id: id
      );
  }
  
  double get amount {
    try {
      return _amount!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  UUser? get user {
    return _user;
  }
  
  UProject? get project {
    return _project;
  }
  
  amplify_core.TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  amplify_core.TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  const USponsor._internal({required this.id, required amount, user, project, createdAt, updatedAt}): _amount = amount, _user = user, _project = project, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory USponsor({String? id, required double amount, UUser? user, UProject? project}) {
    return USponsor._internal(
      id: id == null ? amplify_core.UUID.getUUID() : id,
      amount: amount,
      user: user,
      project: project);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is USponsor &&
      id == other.id &&
      _amount == other._amount &&
      _user == other._user &&
      _project == other._project;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("USponsor {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("amount=" + (_amount != null ? _amount!.toString() : "null") + ", ");
    buffer.write("user=" + (_user != null ? _user!.toString() : "null") + ", ");
    buffer.write("project=" + (_project != null ? _project!.toString() : "null") + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  USponsor copyWith({double? amount, UUser? user, UProject? project}) {
    return USponsor._internal(
      id: id,
      amount: amount ?? this.amount,
      user: user ?? this.user,
      project: project ?? this.project);
  }
  
  USponsor copyWithModelFieldValues({
    ModelFieldValue<double>? amount,
    ModelFieldValue<UUser?>? user,
    ModelFieldValue<UProject?>? project
  }) {
    return USponsor._internal(
      id: id,
      amount: amount == null ? this.amount : amount.value,
      user: user == null ? this.user : user.value,
      project: project == null ? this.project : project.value
    );
  }
  
  USponsor.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _amount = (json['amount'] as num?)?.toDouble(),
      _user = json['user']?['serializedData'] != null
        ? UUser.fromJson(new Map<String, dynamic>.from(json['user']['serializedData']))
        : null,
      _project = json['project']?['serializedData'] != null
        ? UProject.fromJson(new Map<String, dynamic>.from(json['project']['serializedData']))
        : null,
      _createdAt = json['createdAt'] != null ? amplify_core.TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? amplify_core.TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'amount': _amount, 'user': _user?.toJson(), 'project': _project?.toJson(), 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };
  
  Map<String, Object?> toMap() => {
    'id': id,
    'amount': _amount,
    'user': _user,
    'project': _project,
    'createdAt': _createdAt,
    'updatedAt': _updatedAt
  };

  static final amplify_core.QueryModelIdentifier<USponsorModelIdentifier> MODEL_IDENTIFIER = amplify_core.QueryModelIdentifier<USponsorModelIdentifier>();
  static final ID = amplify_core.QueryField(fieldName: "id");
  static final AMOUNT = amplify_core.QueryField(fieldName: "amount");
  static final USER = amplify_core.QueryField(
    fieldName: "user",
    fieldType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.model, ofModelName: 'UUser'));
  static final PROJECT = amplify_core.QueryField(
    fieldName: "project",
    fieldType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.model, ofModelName: 'UProject'));
  static var schema = amplify_core.Model.defineSchema(define: (amplify_core.ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "USponsor";
    modelSchemaDefinition.pluralName = "USponsors";
    
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
      key: USponsor.AMOUNT,
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.double)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.belongsTo(
      key: USponsor.USER,
      isRequired: false,
      targetNames: ['uUserSponsorsId'],
      ofModelName: 'UUser'
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.belongsTo(
      key: USponsor.PROJECT,
      isRequired: false,
      targetNames: ['uProjectSponsorsId'],
      ofModelName: 'UProject'
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

class _USponsorModelType extends amplify_core.ModelType<USponsor> {
  const _USponsorModelType();
  
  @override
  USponsor fromJson(Map<String, dynamic> jsonData) {
    return USponsor.fromJson(jsonData);
  }
  
  @override
  String modelName() {
    return 'USponsor';
  }
}

/**
 * This is an auto generated class representing the model identifier
 * of [USponsor] in your schema.
 */
class USponsorModelIdentifier implements amplify_core.ModelIdentifier<USponsor> {
  final String id;

  /** Create an instance of USponsorModelIdentifier using [id] the primary key. */
  const USponsorModelIdentifier({
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
  String toString() => 'USponsorModelIdentifier(id: $id)';
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    
    return other is USponsorModelIdentifier &&
      id == other.id;
  }
  
  @override
  int get hashCode =>
    id.hashCode;
}