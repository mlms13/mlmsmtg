package app.storage;

import app.state.*;
import haxe.ds.Option;
import npm.lf.Schema;
import npm.lf.schema.Builder;
import npm.lf.schema.ConnectOptions;
import thx.Error;
import thx.Nil;
using thx.promise.Promise;

class Lovefield {
  static function createDeckBuilder() {
    return Schema.create('deckbuilder', 4);
  }

  static function createCollectionTable(builder : Builder) {
    return builder.createTable('Collection')
      .addColumn('id', npm.lf.Type.INTEGER)
      .addColumn('name', npm.lf.Type.STRING)
      .addColumn('code', npm.lf.Type.STRING)
      .addColumn('gathererCode', npm.lf.Type.STRING)
      .addColumn('magicCardsInfoCode', npm.lf.Type.STRING)
      .addColumn('releaseDate', npm.lf.Type.DATE_TIME)
      .addColumn('border', npm.lf.Type.STRING)
      .addColumn('type', npm.lf.Type.STRING)
      // .addColumn('booster', npm.lf.Type.ARRAY_BUFFER)
      .addColumn('parent', npm.lf.Type.INTEGER)
      .addNullable(['code', 'gathererCode', 'magicCardsInfoCode', 'releaseDate', 'border', 'type', 'parent'])
      .addPrimaryKey([{ name : 'id', autoIncrement : true }])
      .addForeignKey('fkparent', {
        local: 'parent',
        ref: 'Collection.id'
      });
  }

  static function createCardTable(builder : Builder) {
    return builder.createTable('Card')
      .addColumn('artist', npm.lf.Type.STRING)
      .addColumn('cmc', npm.lf.Type.INTEGER)
      .addColumn('colors', npm.lf.Type.ARRAY_BUFFER)
      .addColumn('flavor', npm.lf.Type.STRING)
      .addColumn('id', npm.lf.Type.STRING)
      .addColumn('imageName', npm.lf.Type.STRING)
      .addColumn('layout', npm.lf.Type.STRING)
      .addColumn('manaCost', npm.lf.Type.STRING)
      .addColumn('multiverseid', npm.lf.Type.INTEGER)
      .addColumn('name', npm.lf.Type.STRING)
      .addColumn('power', npm.lf.Type.STRING)
      .addColumn('rarity', npm.lf.Type.STRING)
      .addColumn('subtypes', npm.lf.Type.ARRAY_BUFFER)
      .addColumn('text', npm.lf.Type.STRING)
      .addColumn('toughness', npm.lf.Type.STRING)
      .addColumn('type', npm.lf.Type.STRING)
      .addColumn('types', npm.lf.Type.ARRAY_BUFFER)
      .addPrimaryKey(['id']);
  }

  static function createCollectionCardsTable(builder : Builder) {
    return builder.createTable('CollectionCards')
      .addColumn('cardId', npm.lf.Type.STRING)
      .addColumn('collectionId', npm.lf.Type.INTEGER)
      .addForeignKey('fkcardId', {
        local: 'cardId',
        ref: 'Card.id'
      })
      .addForeignKey('fkcollectionId', {
        local: 'collectionId',
        ref: 'Collection.id'
      });
  }

  public static function getDefaultCollection() : Promise<Option<Collection>> {
    return connect()
      .mapSuccessPromise(function (db) {
        var collections = db.getSchema().table('Collection');

        return db.select()
          .from(collections)
          .limit(1)
          .exec().promise();
      })
      .mapSuccessPromise(function (rows) {
        if (rows != null && rows.length > 0) {
          try {
            var collection = Collection.fromDynamic(rows[0]);
            return Promise.value(Some(collection));
          } catch (e : Dynamic) {
            return Promise.error(Error.fromDynamic(e));
          }
        } else {
          return Promise.value(None);
        }
      })
      .failure(function (e) {
        trace(e);
      });
  }

  public static function saveCollection(collection : Collection) : Promise<Nil> {
    return Promise.nil;
  }

  public static function connect(?opts : ConnectOptions) : Promise<npm.lf.Database> {
    var builder = createDeckBuilder();
    createCollectionTable(builder);
    createCardTable(builder);
    createCollectionCardsTable(builder);
    return builder.connect(opts).promise();
  }
}
