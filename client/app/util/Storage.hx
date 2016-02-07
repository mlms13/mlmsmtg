package app.util;

import app.state.*;
import haxe.ds.Option;
import npm.lf.Schema;
import npm.lf.schema.ConnectOptions;
import thx.Error;
using thx.promise.Promise;

class Storage {
  static function createDeckBuilder() {
    return Schema.create('deckbuilder', 4);
  }

  static function createCollectionTable(builder) {
    return builder.createTable('Collection')
      .addColumn('name', npm.lf.Type.STRING)
      .addColumn('code', npm.lf.Type.STRING)
      .addColumn('gathererCode', npm.lf.Type.STRING)
      .addColumn('magicCardsInfoCode', npm.lf.Type.STRING)
      .addColumn('releaseDate', npm.lf.Type.DATE_TIME)
      .addColumn('border', npm.lf.Type.STRING)
      .addColumn('type', npm.lf.Type.STRING)
      .addColumn('booster', npm.lf.Type.ARRAY_BUFFER)
      .addPrimaryKey(['code']);
  }

  static function createCardTable(builder) {
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

  public static function connect(?opts : ConnectOptions) : Promise<npm.lf.Database> {
    var builder = createDeckBuilder();
    createCollectionTable(builder);
    createCardTable(builder);
    return builder.connect(opts).promise();
  }
}
