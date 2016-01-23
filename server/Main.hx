import abe.App;
import mw.ConnectLivereload;
import js.node.Path;
import express.*;
import routes.*;

class Main {
  public static function main() {
    var app = new App(),
        api = app.sub("/api"),
        stat = app.sub("/"),
        port = 3333;

    if (js.Node.process.argv[2] != null) {
      port = Std.parseInt(js.Node.process.argv[2]);
    }

    api.router.register(new Cards());

    stat.router.use(ConnectLivereload.create());
    stat.router.use(function (req : Request, res : Response, next : Next) {
      if (Path.extname(req.path).length > 0) {
        // if they requested a resource with a file extension, just send it
        next.call();
      } else {
        // otherwise, return the same app and let the client handle routing
        res.sendFile('index.html', { root : './public' });
      }
    });
    stat.router.serve('/', './public');
    app.http(port, function () {
      trace('Listening on port $port');
    });
  }
}
