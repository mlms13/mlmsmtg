package app.view;

import Doom.*;

class EmptyCollection extends Doom {
  @:api var triggerCardLoad : Void -> Void;

  override function render() {
    return button(["click" => triggerCardLoad], "Download Cards");
  }
}
