import abe.App;
import mw.ConnectLivereload;
import js.node.Path;
import express.*;
import routes.*;

class Main {
  public static function main() {
    var app = new App(),
        api = app.sub("/api"),
        stat = app.sub("/");

    api.router.register(new Cards());

    stat.router.use(ConnectLivereload.create());
    stat.router.use(function (req : Request, res : Response, next : Next) {
      if (Path.extname(req.path).length > 0) {
        // if they requested a resource with a file extension, just send it
        next.call();
      } else {
        // otherwise, always return the same mithril app for routing purposes
        res.sendFile('index.html', { root : './public' });
      }
    });
    stat.router.serve('/', './public');

    // server all subrouters on 3333
    app.http(3333);
  }
}
