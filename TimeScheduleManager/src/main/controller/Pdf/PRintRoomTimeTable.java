package main.controller.Pdf;

import com.itextpdf.text.*;
import com.itextpdf.text.Font;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;
import main.model.WorkingDaysSub;
import main.service.WorkingDaysService;
import main.service.impl.WorkingDaysServiceImpl;

import java.awt.*;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;

public class PRintRoomTimeTable {

    int count=0;
    private static Font catFont = new Font(Font.FontFamily.TIMES_ROMAN, 15,
            Font.BOLD);
        private static Font smallBold = new Font(Font.FontFamily.TIMES_ROMAN, 10,
            Font.BOLD);

    private static WorkingDaysService workingDaysService;
    public static final Logger log = Logger.getLogger(PRintRoomTimeTable.class.getName());

    public PRintRoomTimeTable() {
        this.workingDaysService = new WorkingDaysServiceImpl();
    }

    //
    /*-------------------Generate Current Date -----------------*/
    public static String getCurrentDate() {
        DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        Date date = new Date();
        String newDate = dateFormat.format(date);

        return newDate;
    }

    //
    /*-------------------Generate Current Time -----------------*/
    public static String getCurrentTime() {

        Calendar cal = Calendar.getInstance();
        SimpleDateFormat sdf = new SimpleDateFormat("HH-mm-ss");

        return (sdf.format(cal.getTime()));

    }


    public void generateCustomerReportPdf(String[][] arr,String [][]timeString, int workingDaysCount, int hourSize,String RoomName) {

        String fileName = getCurrentDate() + "_" + getCurrentTime() +"-"+RoomName+ ".pdf";
        String file1 = "C:/Users/" + System.getProperty("user.name") + "/Documents/" + fileName;

        try {

            Document document = new Document();
            PdfWriter.getInstance(document, new FileOutputStream(file1));
            document.open();
            addMetaData(document,RoomName);
            addTitlePage(document,RoomName);
            createTable(document, arr,timeString,workingDaysCount,hourSize);
            if (Desktop.isDesktopSupported()) {
                try {
                    File myFile = new File(file1);
                    Desktop.getDesktop().open(myFile);
                } catch (IOException ex) {
                    // no application registered for PDFs
                }
            }
            document.close();

        } catch (Exception e) {
            log.log(Level.SEVERE,e.getMessage());
        }


    }


    private void addMetaData(Document document,String groupId) {

        document.addTitle(groupId);

    }


    private static void addTitlePage(Document document,String groupId)
            throws DocumentException {
        Paragraph preface = new Paragraph();
        // We add one empty line
        addEmptyLine(preface, 1);
        // Lets write a big header
        preface.add(new Paragraph(groupId, catFont));

        addEmptyLine(preface, 1);
        // Will create: Report generated by: _name, _date
        preface.add(new Paragraph(
                "Report generated by: " + System.getProperty("user.name") + ", " + new Date(), //$NON-NLS-1$ //$NON-NLS-2$ //$NON-NLS-3$
                smallBold));
        addEmptyLine(preface, 3);
        document.add(preface);
    }

    private static void createTable(Document subCatPart, String[][] arr,String [][] timeString, int workingDaysCount, int hourSize) throws BadElementException {
        try {
            ArrayList<WorkingDaysSub> list = workingDaysService.getAllSubDetails();
            PdfPTable table1 = new PdfPTable(list.size()+1);
            PdfPCell c1 = new PdfPCell(new Phrase(" "));
            c1.setHorizontalAlignment(Element.ALIGN_CENTER);
            table1.addCell(c1);
            for (WorkingDaysSub s : list
            ) {
                c1 = new PdfPCell(new Phrase(s.getWorkingday()));

                c1.setHorizontalAlignment(Element.ALIGN_CENTER);
                table1.addCell(c1);
            }
            table1.setHeaderRows(1);

            for (int i = 0; i <hourSize; i++) {
                table1.addCell(timeString[i][0]);
                for (int j = 0; j < workingDaysCount; j++) {
                    if(arr[i][j]!=null){
                        PdfPCell c2 = new PdfPCell(new Phrase(arr[i][j],new Font(Font.FontFamily.TIMES_ROMAN, 9, Font.BOLD)));
                        c2.setHorizontalAlignment(Element.ALIGN_CENTER);
                        table1.addCell(c2);
                    }else{
                        PdfPCell c2 = new PdfPCell(new Phrase("-",new Font(Font.FontFamily.TIMES_ROMAN, 9, Font.BOLD)));
                        c2.setHorizontalAlignment(Element.ALIGN_CENTER);
                        table1.addCell(c2);
                    }

                }
            }
            subCatPart.add(table1);
        } catch (SQLException|DocumentException e) {
            log.log(Level.SEVERE,e.getMessage());
        }


    }

 private static void addEmptyLine(Paragraph paragraph, int number) {
        for (int i = 0; i < number; i++) {
            paragraph.add(new Paragraph(" "));
        }
    }
}
