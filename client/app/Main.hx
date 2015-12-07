package app;

import app.util.Storage.*;
import app.data.*;
import app.views.*;
import lies.Store;
import npm.lf.Schema;
using thx.promise.Promise;

class Main {
  public function new() {
    var store = Store.create(Reducers.mtgApp, {});
    createSetTable();
    createCardTable();
    connect({
      onUpgrade : checkFirstLaunch
    });

    var app = new app.views.App(store);
  }

  function checkFirstLaunch(rawDb : npm.lf.raw.BackStore) {
    if (rawDb.getVersion() == 0) {
      trace("This was the first run");
    }
  }

  public static function main() {
    new Main();
  }
}
