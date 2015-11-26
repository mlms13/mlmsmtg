import abe.App;
import mw.ConnectLivereload;
import js.node.Path;
import express.*;

class Main {
  public static function main() {
    var app = new App();
    app.router.use(ConnectLivereload.create());
    app.router.use(function (req : Request, res : Response, next : Next) {
      if (Path.extname(req.path).length > 0) {
        // if they requested a resource with a file extension, just send it
        next.call();
      } else {
        // otherwise, always return the same mithril app for routing purposes
        res.sendFile('index.html', { root : './public' });
      }
    });
    app.router.serve('/', './public');
    app.http(3333);
  }
}
