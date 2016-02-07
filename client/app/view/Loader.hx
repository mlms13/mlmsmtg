package app.view;

import Doom.*;

class Loader extends Doom {
  @:state
  var message : String;

  override function render() {
    return div(message);
  }
}
