import javafx.*;
import javafx.stage.*;
import javafx.scene.*;
import javafx.scene.control.*;
import javafx.scene.layout.*;
import javafx.scene.paint.*;

application {
    title = "JavaFX Script Tool"
    scene = Scene {
        content: VBox {
            spacing: 10
            content: [
                Label {
                    text: "Dynamic User Interface Framework"
                    style: "-fx-font-size: 20px; -fx-font-weight: bold;"
                },
                Button {
                    text: "Click Me"
                    onAction: function(e: ActionEvent) {
                        label.setText("Button clicked at: " + new Date());
                    }
                },
                Label {
                    fx:id: "label"
                    text: "Waiting for interaction..."
                },
                Rectangle {
                    width: 200
                    height: 100
                    fill: Color.LIGHTBLUE
                    stroke: Color.BLUE
                }
            ]
        }
    }
}
