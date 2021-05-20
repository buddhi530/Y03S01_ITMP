package main.controller.Tag;


import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.fxml.Initializable;
import javafx.scene.Parent;
import javafx.scene.control.Button;
import javafx.scene.layout.BorderPane;
import jdk.nashorn.internal.runtime.ECMAException;
import main.controller.Subject.PnlSubjectController;

import java.io.IOException;
import java.net.URL;
import java.util.ResourceBundle;
import java.util.logging.Level;
import java.util.logging.Logger;


public class PnlTagController implements Initializable {

    @FXML
    public BorderPane pnlTag;
    @FXML
    private Button btnTag;

    public static final Logger log = Logger.getLogger(PnlTagController.class.getName());

    public void handleEvents(ActionEvent event) {
        try {
            if (event.getSource() == btnTag) {
                pnlTag.getChildren().removeAll();
                FXMLLoader loader = new FXMLLoader();
                loader.setLocation(getClass().getResource("/main/views/Tag/Tag.fxml"));
                Parent root = loader.load();
                pnlTag.setCenter(root);
            }
        }catch (Exception e){
            log.log(Level.SEVERE,e.getMessage());
        }
    }

    @Override
    public void initialize(URL location, ResourceBundle resources) {
        try {
            pnlTag.getChildren().removeAll();
            FXMLLoader loader = new FXMLLoader();
            loader.setLocation(getClass().getResource("/main/views/Tag/Tag.fxml"));
            Parent root = loader.load();
            pnlTag.setCenter(root);
        } catch (IOException e) {
            log.log(Level.SEVERE,e.getMessage());
        }
    }
}
