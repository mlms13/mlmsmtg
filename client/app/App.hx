package app;

import npm.lf.Schema;
using thx.promise.Promise;

class App {
  public function new() {
    var schemaBuilder = npm.lf.Schema.create("todo", 1);
    schemaBuilder.createTable("Item")
      .addColumn("id", npm.lf.Type.INTEGER)
      .addColumn("description", npm.lf.Type.STRING)
      .addColumn("deadline", npm.lf.Type.DATE_TIME)
      .addColumn("done", npm.lf.Type.BOOLEAN)
      .addPrimaryKey(["id"])
      .addIndex("idxDeadline", ["deadline"], false, npm.lf.Order.DESC);

    var todoDb, item;

    schemaBuilder.connect()
      .promise()
      .mapSuccessPromise(function (db) {
        todoDb = db;
        item = db.getSchema().table("Item");
        var row = item.createRow({
          "id" : 1,
          "description" : "Get a cup of coffee",
          "deadline" : Date.now(),
          "done" : false
        });

        return db.insertOrReplace().into(item).values([row]).exec().promise()
          .mapSuccessPromise(function (_) {
            return todoDb.select().from(item).where(Reflect.field(item, "done").eq(false)).exec().promise();
          })
          .success(function (results) {
            trace(results);
          });
      });
  }

  public static function main() {
    new App();
  }
}
