<%-- 
    Document   : generarPDF
    Created on : 18 jun 2025, 4:38:35 p.m.
    Author     : danna
--%>

<%@page contentType="application/pdf" pageEncoding="UTF-8"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.lowagie.text.Document"%>
<%@page import="com.lowagie.text.Element"%>
<%@page import="com.lowagie.text.Font"%>
<%@page import="com.lowagie.text.PageSize"%>
<%@page import="com.lowagie.text.Paragraph"%>
<%@page import="com.lowagie.text.Phrase"%>
<%@page import="com.lowagie.text.pdf.PdfWriter"%>
<%@page import="com.lowagie.text.pdf.PdfPTable"%>
<%@page import="com.lowagie.text.pdf.PdfPCell"%>
<%@page import="com.vlsm.modelo.SubredInfo"%>
<%@page import="com.vlsm.modelo.VLSMCalculadora"%>
<%@page import="java.io.IOException"%>

<%
    try {
        // Obtener datos de la sesión, en este caso de las subredes
        List<SubredInfo> subredes = (List<SubredInfo>) session.getAttribute("subredes");
        String ipBase = (String) session.getAttribute("ipBase");
        Integer prefijo = (Integer) session.getAttribute("prefijo");
        List<String> pasoAPaso = (List<String>) session.getAttribute("pasoAPaso");
        
        if (subredes == null || ipBase == null || prefijo == null) {
            response.sendRedirect("index.jsp");
            return;
        }
        
        response.setContentType("application/pdf");
        response.setHeader("Content-Disposition", "attachment; filename=\"VLSM_Reporte.pdf\"");
        
        Document documento = new Document(PageSize.A4);
        PdfWriter writer = PdfWriter.getInstance(documento, response.getOutputStream());
        
        documento.open();
        
        Font tituloFont = new Font(Font.HELVETICA, 18, Font.BOLD);
        Font subtituloFont = new Font(Font.HELVETICA, 14, Font.BOLD);
        Font normalFont = new Font(Font.HELVETICA, 10, Font.NORMAL);
        Font monoFont = new Font(Font.COURIER, 8, Font.NORMAL);
        Font monoBoldFont = new Font(Font.COURIER, 8, Font.BOLD);
        
        Paragraph titulo = new Paragraph("REPORTE VLSM", tituloFont);
        titulo.setAlignment(Element.ALIGN_CENTER);
        documento.add(titulo);
        
        documento.add(new Paragraph(" "));
        
        Paragraph info = new Paragraph("Configuración de Red", subtituloFont);
        documento.add(info);
        documento.add(new Paragraph("Red base: " + ipBase + "/" + prefijo, normalFont));
        documento.add(new Paragraph("Fecha: " + new Date().toString(), normalFont));
        documento.add(new Paragraph(" "));
        
        // Tabla de resultados
        Paragraph tablaTitle = new Paragraph("Configuración de Subredes", subtituloFont);
        documento.add(tablaTitle);
        
        PdfPTable tabla = new PdfPTable(7);
        tabla.setWidthPercentage(100);
        tabla.setSpacingBefore(10f);
        
        PdfPCell celda;
        String[] encabezados = {"Subred", "Dirección de Red", "Máscara", "Rango Inicio", "Rango Fin", "Broadcast", "Hosts"};
        
        for (String encabezado : encabezados) {
            celda = new PdfPCell(new Phrase(encabezado, subtituloFont));
            celda.setHorizontalAlignment(Element.ALIGN_CENTER);
            tabla.addCell(celda);
        }
        
        for (SubredInfo subred : subredes) {
            tabla.addCell(new Phrase(subred.getNombre(), normalFont));
            tabla.addCell(new Phrase(subred.getDireccionIp(), normalFont));
            tabla.addCell(new Phrase(subred.getMascaraSubred(), normalFont));
            tabla.addCell(new Phrase(subred.getRangoInicio(), normalFont));
            tabla.addCell(new Phrase(subred.getRangoFin(), normalFont));
            tabla.addCell(new Phrase(subred.getBroadcast(), normalFont));
            tabla.addCell(new Phrase(subred.getHostsSolicitados() + "/" + subred.getHostsDisponibles(), normalFont));
        }
        
        documento.add(tabla);
        
        documento.newPage();
        
        Paragraph procesoTitle = new Paragraph("Proceso Paso a Paso", subtituloFont);
        documento.add(procesoTitle);
        documento.add(new Paragraph(" "));
        
        if (pasoAPaso != null) {
            for (String paso : pasoAPaso) {
                if (!paso.trim().isEmpty()) {
                
                    Font fontToUse = paso.contains("/") && paso.contains("-->") ? monoBoldFont : monoFont;
                    Paragraph parrafo = new Paragraph(paso, fontToUse);
                    documento.add(parrafo);
                }
            }
        }
        
        documento.close();
        
    } catch (Exception e) {
        e.printStackTrace();
        
            response.reset();
        response.setContentType("text/html");
        
        out.println("<html><body>");
        out.println("<h2>Error al generar PDF</h2>");
        out.println("<p>Error: " + e.getMessage() + "</p>");
        out.println("<p>Causa: " + (e.getCause() != null ? e.getCause().getMessage() : "Desconocida") + "</p>");
        out.println("<a href='index.jsp'>Volver al inicio</a>");
        out.println("</body></html>");
    }
%>
