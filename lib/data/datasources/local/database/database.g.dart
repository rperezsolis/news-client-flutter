// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $SavedArticlesTable extends SavedArticles
    with TableInfo<$SavedArticlesTable, SavedArticle> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SavedArticlesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _contentMeta =
      const VerificationMeta('content');
  @override
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
      'content', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _urlMeta = const VerificationMeta('url');
  @override
  late final GeneratedColumn<String> url = GeneratedColumn<String>(
      'url', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _urlToImageMeta =
      const VerificationMeta('urlToImage');
  @override
  late final GeneratedColumn<String> urlToImage = GeneratedColumn<String>(
      'url_to_image', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _authorMeta = const VerificationMeta('author');
  @override
  late final GeneratedColumn<String> author = GeneratedColumn<String>(
      'author', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _sourceMeta = const VerificationMeta('source');
  @override
  late final GeneratedColumn<String> source = GeneratedColumn<String>(
      'source', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, title, description, content, url, urlToImage, author, source];
  @override
  String get aliasedName => _alias ?? 'saved_articles';
  @override
  String get actualTableName => 'saved_articles';
  @override
  VerificationContext validateIntegrity(Insertable<SavedArticle> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('content')) {
      context.handle(_contentMeta,
          content.isAcceptableOrUnknown(data['content']!, _contentMeta));
    } else if (isInserting) {
      context.missing(_contentMeta);
    }
    if (data.containsKey('url')) {
      context.handle(
          _urlMeta, url.isAcceptableOrUnknown(data['url']!, _urlMeta));
    } else if (isInserting) {
      context.missing(_urlMeta);
    }
    if (data.containsKey('url_to_image')) {
      context.handle(
          _urlToImageMeta,
          urlToImage.isAcceptableOrUnknown(
              data['url_to_image']!, _urlToImageMeta));
    }
    if (data.containsKey('author')) {
      context.handle(_authorMeta,
          author.isAcceptableOrUnknown(data['author']!, _authorMeta));
    }
    if (data.containsKey('source')) {
      context.handle(_sourceMeta,
          source.isAcceptableOrUnknown(data['source']!, _sourceMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SavedArticle map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SavedArticle(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description'])!,
      content: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}content'])!,
      url: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}url'])!,
      urlToImage: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}url_to_image']),
      author: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}author']),
      source: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}source']),
    );
  }

  @override
  $SavedArticlesTable createAlias(String alias) {
    return $SavedArticlesTable(attachedDatabase, alias);
  }
}

class SavedArticle extends DataClass implements Insertable<SavedArticle> {
  final int id;
  final String title;
  final String description;
  final String content;
  final String url;
  final String? urlToImage;
  final String? author;
  final String? source;
  const SavedArticle(
      {required this.id,
      required this.title,
      required this.description,
      required this.content,
      required this.url,
      this.urlToImage,
      this.author,
      this.source});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    map['description'] = Variable<String>(description);
    map['content'] = Variable<String>(content);
    map['url'] = Variable<String>(url);
    if (!nullToAbsent || urlToImage != null) {
      map['url_to_image'] = Variable<String>(urlToImage);
    }
    if (!nullToAbsent || author != null) {
      map['author'] = Variable<String>(author);
    }
    if (!nullToAbsent || source != null) {
      map['source'] = Variable<String>(source);
    }
    return map;
  }

  SavedArticlesCompanion toCompanion(bool nullToAbsent) {
    return SavedArticlesCompanion(
      id: Value(id),
      title: Value(title),
      description: Value(description),
      content: Value(content),
      url: Value(url),
      urlToImage: urlToImage == null && nullToAbsent
          ? const Value.absent()
          : Value(urlToImage),
      author:
          author == null && nullToAbsent ? const Value.absent() : Value(author),
      source:
          source == null && nullToAbsent ? const Value.absent() : Value(source),
    );
  }

  factory SavedArticle.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SavedArticle(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      description: serializer.fromJson<String>(json['description']),
      content: serializer.fromJson<String>(json['content']),
      url: serializer.fromJson<String>(json['url']),
      urlToImage: serializer.fromJson<String?>(json['urlToImage']),
      author: serializer.fromJson<String?>(json['author']),
      source: serializer.fromJson<String?>(json['source']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'description': serializer.toJson<String>(description),
      'content': serializer.toJson<String>(content),
      'url': serializer.toJson<String>(url),
      'urlToImage': serializer.toJson<String?>(urlToImage),
      'author': serializer.toJson<String?>(author),
      'source': serializer.toJson<String?>(source),
    };
  }

  SavedArticle copyWith(
          {int? id,
          String? title,
          String? description,
          String? content,
          String? url,
          Value<String?> urlToImage = const Value.absent(),
          Value<String?> author = const Value.absent(),
          Value<String?> source = const Value.absent()}) =>
      SavedArticle(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
        content: content ?? this.content,
        url: url ?? this.url,
        urlToImage: urlToImage.present ? urlToImage.value : this.urlToImage,
        author: author.present ? author.value : this.author,
        source: source.present ? source.value : this.source,
      );
  @override
  String toString() {
    return (StringBuffer('SavedArticle(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('content: $content, ')
          ..write('url: $url, ')
          ..write('urlToImage: $urlToImage, ')
          ..write('author: $author, ')
          ..write('source: $source')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, title, description, content, url, urlToImage, author, source);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SavedArticle &&
          other.id == this.id &&
          other.title == this.title &&
          other.description == this.description &&
          other.content == this.content &&
          other.url == this.url &&
          other.urlToImage == this.urlToImage &&
          other.author == this.author &&
          other.source == this.source);
}

class SavedArticlesCompanion extends UpdateCompanion<SavedArticle> {
  final Value<int> id;
  final Value<String> title;
  final Value<String> description;
  final Value<String> content;
  final Value<String> url;
  final Value<String?> urlToImage;
  final Value<String?> author;
  final Value<String?> source;
  const SavedArticlesCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.description = const Value.absent(),
    this.content = const Value.absent(),
    this.url = const Value.absent(),
    this.urlToImage = const Value.absent(),
    this.author = const Value.absent(),
    this.source = const Value.absent(),
  });
  SavedArticlesCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    required String description,
    required String content,
    required String url,
    this.urlToImage = const Value.absent(),
    this.author = const Value.absent(),
    this.source = const Value.absent(),
  })  : title = Value(title),
        description = Value(description),
        content = Value(content),
        url = Value(url);
  static Insertable<SavedArticle> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<String>? description,
    Expression<String>? content,
    Expression<String>? url,
    Expression<String>? urlToImage,
    Expression<String>? author,
    Expression<String>? source,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (content != null) 'content': content,
      if (url != null) 'url': url,
      if (urlToImage != null) 'url_to_image': urlToImage,
      if (author != null) 'author': author,
      if (source != null) 'source': source,
    });
  }

  SavedArticlesCompanion copyWith(
      {Value<int>? id,
      Value<String>? title,
      Value<String>? description,
      Value<String>? content,
      Value<String>? url,
      Value<String?>? urlToImage,
      Value<String?>? author,
      Value<String?>? source}) {
    return SavedArticlesCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      content: content ?? this.content,
      url: url ?? this.url,
      urlToImage: urlToImage ?? this.urlToImage,
      author: author ?? this.author,
      source: source ?? this.source,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (url.present) {
      map['url'] = Variable<String>(url.value);
    }
    if (urlToImage.present) {
      map['url_to_image'] = Variable<String>(urlToImage.value);
    }
    if (author.present) {
      map['author'] = Variable<String>(author.value);
    }
    if (source.present) {
      map['source'] = Variable<String>(source.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SavedArticlesCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('content: $content, ')
          ..write('url: $url, ')
          ..write('urlToImage: $urlToImage, ')
          ..write('author: $author, ')
          ..write('source: $source')
          ..write(')'))
        .toString();
  }
}

abstract class _$Database extends GeneratedDatabase {
  _$Database(QueryExecutor e) : super(e);
  late final $SavedArticlesTable savedArticles = $SavedArticlesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [savedArticles];
}
