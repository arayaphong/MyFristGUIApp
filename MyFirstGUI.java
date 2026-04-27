import java.util.Locale;
import java.util.Objects;

import javafx.application.Application;
import javafx.application.ColorScheme;
import javafx.application.Platform;
import javafx.geometry.Insets;
import javafx.scene.Scene;
import javafx.scene.control.Alert;
import javafx.scene.control.Button;
import javafx.scene.control.ButtonType;
import javafx.scene.control.Label;
import javafx.scene.image.Image;
import javafx.scene.image.ImageView;
import javafx.scene.layout.VBox;
import javafx.stage.Modality;
import javafx.stage.Stage;

public class MyFirstGUI extends Application {
    private Stage primaryStage;

    public static void main(String[] args) {
        Locale.setDefault(Locale.forLanguageTag("th-TH"));
        launch(args);
    }

    private void showExitConfirmation() {
        var yes = new ButtonType("ใช่");
        var no = new ButtonType("ไม่ใช่");
        var confirm = new Alert(Alert.AlertType.CONFIRMATION, "คุณต้องการออกใช่หรือไม่?", yes, no);
        confirm.setTitle("ยืนยัน");
        confirm.setHeaderText(null);
        confirm.initOwner(primaryStage);
        confirm.initModality(Modality.WINDOW_MODAL);
        confirm.showAndWait().ifPresent(answer -> {
            if (answer == yes) {
                Platform.exit();
            }
        });
    }

    @Override
    public void start(Stage stage) {
        primaryStage = stage;
        var label = new Label("สวัสดี! นี่คือ GUI ตัวแรกของฉัน");

        var gifUrl = Objects.requireNonNull(getClass().getResource("กระดึ๊บ.gif"));
        var gifView = new ImageView(new Image(gifUrl.toExternalForm()));

        var exitButton = new Button("ออก");
        exitButton.setOnAction(_ -> showExitConfirmation());

        var root = new VBox();
        root.setPadding(new Insets(30, 10, 10, 10));
        root.setStyle("-fx-alignment: top-center;");
        VBox.setMargin(label, new Insets(10, 0, 0, 0));
        VBox.setMargin(exitButton, new Insets(20, 0, 0, 0));
        root.getChildren().addAll(gifView, label, exitButton);

        var scene = new Scene(root, 420, 360);

        // ใช้ธีม Dark/Light ตามการตั้งค่าระบบ
        var darkCss = Objects.requireNonNull(getClass().getResource("dark.css")).toExternalForm();
        if (Platform.getPreferences().getColorScheme() == ColorScheme.DARK) {
            scene.getStylesheets().add(darkCss);
        }
        Platform.getPreferences().colorSchemeProperty().addListener((_, _, scheme) -> {
            switch (scheme) {
                case DARK -> scene.getStylesheets().add(darkCss);
                default  -> scene.getStylesheets().remove(darkCss);
            }
        });

        stage.setOnCloseRequest(e -> {
            e.consume();
            showExitConfirmation();
        });

        stage.setTitle("จัดวางแนวตั้ง");
        stage.setResizable(false);
        stage.setScene(scene);
        stage.centerOnScreen();
        stage.show();
    }
}
