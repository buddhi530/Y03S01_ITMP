package main.controller.WorkSchedule;

import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.fxml.Initializable;
import javafx.scene.Parent;
import javafx.scene.control.Button;
import javafx.scene.layout.BorderPane;

import java.io.IOException;
import java.net.URL;
import java.util.ResourceBundle;
import java.util.logging.Level;
import java.util.logging.Logger;

public class pnlDaysController implements Initializable {

    @FXML
    private Button btnDelete;

    @FXML
    private Button btnAdd;

    @FXML
    private BorderPane pnlMain;

    public static final Logger log = Logger.getLogger(pnlDaysController.class.getName());

    @FXML
    void handleEvents(ActionEvent event) {

        try {
            if (event.getSource() == btnAdd) {
                FXMLLoader loader = new FXMLLoader();
                loader.setLocation(getClass().getResource("/main/views/WorkSchedule/WorkingDays.fxml"));
                Parent root = loader.load();
                pnlMain.setCenter(root);
            }
        } catch (IOException e) {
            log.log(Level.SEVERE,e.getMessage());
        }

    }

    @Override
    public void initialize(URL location, ResourceBundle resources) {
        pnlMain.getChildren().removeAll();
        Parent root = null;
        try {
            FXMLLoader loader = new FXMLLoader();
            loader.setLocation(getClass().getResource("/main/views/WorkSchedule/WorkingDays.fxml"));
            root = loader.load();
            pnlMain.setCenter(root);

        } catch (IOException e) {
            log.log(Level.SEVERE,e.getMessage());
        }
        pnlMain.setCenter(root);
    }
}
