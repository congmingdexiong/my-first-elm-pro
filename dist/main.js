// main.js
import { Elm } from "./Main.elm";
import { renderReactComponent } from "./reactBridge";

const app = Elm.Main.init({
  node: document.getElementById("elm-root"),
});

app.ports.renderReact.subscribe(({ divId, initialValue }) => {
  renderReactComponent(divId, {
    initialValue,
    onChange: (newValue) => app.ports.receiveFromReact.send(newValue),
  });
});
