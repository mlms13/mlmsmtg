package app;

import app.util.Storage.*;
import app.views.*;
import npm.lf.Schema;
using thx.promise.Promise;

class Main {
  public function new() {
    createSetTable();
    createCardTable();
    connect().success(function (db) {
      var item = db.getSchema().table("Item");
      var row = item.createRow({
        "id" : 1,
        "description" : "Get a cup of coffee",
        "deadline" : Date.now(),
        "done" : false
      });
      return db.insertOrReplace().into(item).values([row])
        .exec().promise()
        .mapSuccessPromise(function (_) {
          return db.select().from(item).where(Reflect.field(item, "done").eq(false)).exec().promise();
        })
        .success(function (results) {
          trace(results);
        });
    });

    var app = new app.views.App(new AppApi(), Loading);
  }

  public static function main() {
    new Main();
  }
}
