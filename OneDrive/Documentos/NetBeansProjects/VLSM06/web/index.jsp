<%-- 
    Document   : index
    Created on : 18 jun 2025, 4:38:06 p.m.
    Author     : danna
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.vlsm.modelo.SubredInfo"%>
<%@page import="com.vlsm.modelo.VLSMCalculadora"%>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Calculadora VLSM</title>
    <style>
        :root {
            --primary-color: #6a0dad;
            --primary-dark: #4b0082;
            --primary-light: #9b59b6;
            --dark-color: #1a1a1a;
            --light-color: #f8f9fa;
            --accent-color: #e1bee7;
            --success-color: #4caf50;
            --warning-color: #ff9800;
            --error-color: #f44336;
        }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
            background-color: var(--dark-color);
            color: #e0e0e0;
            line-height: 1.6;
        }
        
        .container {
            background-color: #2d2d2d;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.3);
            margin-bottom: 25px;
            border-left: 4px solid var(--primary-color);
        }
        
        h1, h2, h3, h4 {
            color: var(--primary-light);
        }
        
        h1 {
            text-align: center;
            margin-bottom: 30px;
            padding-bottom: 15px;
            border-bottom: 1px solid var(--primary-dark);
            font-size: 2.2em;
            text-shadow: 0 2px 4px rgba(0, 0, 0, 0.3);
        }
        
        h2 {
            color: var(--primary-light);
            margin-top: 0;
            font-size: 1.6em;
            padding-bottom: 10px;
            border-bottom: 1px solid #444;
        }
        
        .form-group {
            margin-bottom: 20px;
        }
        
        label {
            display: block;
            margin-bottom: 8px;
            font-weight: 600;
            color: var(--accent-color);
        }
        
        input[type="text"], 
        input[type="number"] {
            width: 100%;
            padding: 12px;
            border: 1px solid #444;
            border-radius: 4px;
            box-sizing: border-box;
            background-color: #3d3d3d;
            color: #fff;
            font-size: 16px;
            transition: border 0.3s, box-shadow 0.3s;
        }
        
        input[type="text"]:focus, 
        input[type="number"]:focus {
            border-color: var(--primary-light);
            box-shadow: 0 0 0 2px rgba(154, 89, 182, 0.3);
            outline: none;
        }
        
        .btn {
            background-color: var(--primary-color);
            color: white;
            padding: 12px 24px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            margin-right: 10px;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            transition: background-color 0.3s, transform 0.2s;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2);
        }
        
        .btn:hover {
            background-color: var(--primary-dark);
            transform: translateY(-1px);
        }
        
        .btn:active {
            transform: translateY(0);
        }
        
        .btn:disabled {
            background-color: #555;
            cursor: not-allowed;
            transform: none;
        }
        
        .resultado {
            background-color: #333;
            padding: 20px;
            border-radius: 6px;
            margin-top: 25px;
            border-left: 4px solid var(--success-color);
        }
        
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 15px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2);
        }
        
        th, td {
            border: 1px solid #444;
            padding: 12px;
            text-align: left;
        }
        
        th {
            background-color: var(--primary-dark);
            color: white;
            font-weight: 600;
        }
        
        tr:nth-child(even) {
            background-color: #3a3a3a;
        }
        
        tr:hover {
            background-color: #4a4a4a;
        }
        
        .proceso {
            background-color: #333;
            padding: 20px;
            border-radius: 6px;
            margin-top: 25px;
            white-space: pre-line;
            font-family: 'Courier New', monospace;
            border-left: 4px solid var(--warning-color);
            overflow-x: auto;
        }
        
        .error {
            background-color: #3a1a1a;
            color: #ff6b6b;
            padding: 20px;
            border-radius: 6px;
            margin-top: 25px;
            border-left: 4px solid var(--error-color);
        }
        
        .debug {
            background-color: #1a3a3a;
            color: #6bffb8;
            padding: 15px;
            border-radius: 6px;
            margin: 15px 0;
            font-family: 'Courier New', monospace;
            font-size: 13px;
            border-left: 4px solid #00bcd4;
        }
        
        .info-box {
            background-color: #2d3748;
            padding: 15px;
            border-radius: 6px;
            margin-bottom: 20px;
            border-left: 4px solid #4299e1;
        }
        
        .info-box p {
            margin: 5px 0;
        }
        
        .btn-group {
            display: flex;
            gap: 10px;
            margin-top: 20px;
            flex-wrap: wrap;
        }
        
        .btn-secondary {
            background-color: #555;
        }
        
        .btn-secondary:hover {
            background-color: #666;
        }
        
        .badge {
            display: inline-block;
            padding: 3px 8px;
            border-radius: 12px;
            font-size: 12px;
            font-weight: bold;
            background-color: var(--primary-dark);
            color: white;
            margin-left: 5px;
        }
        
        @media (max-width: 768px) {
            body {
                padding: 15px;
            }
            
            .container {
                padding: 20px;
            }
            
            table {
                display: block;
                overflow-x: auto;
            }
        }
        
        .proceso-binario {
            font-family: 'Courier New', monospace;
            white-space: pre;
            background-color: #1e1e1e;
            padding: 15px;
            border-radius: 5px;
            overflow-x: auto;
            margin: 10px 0;
            border-left: 3px solid var(--primary-light);
        }
        
        .proceso-binario .bits-red {
            color: #4fc3f7;
        }
        
        .proceso-binario .bits-host {
            color: #81c784;
        }
    </style>
</head>
<body>
    <h1>Calculadora VLSM</h1>
    <h2 style="font-size: smaller;">Hecho por: Jairo Farinango</h2>
    
    <%
        String paso = request.getParameter("paso");
        if (paso == null) paso = "1";
        
        String ipBase = request.getParameter("ipBase");
        String mascaraRed = request.getParameter("mascaraRed");
        String numSubredes = request.getParameter("numSubredes");
        
        boolean showDebug = "true".equals(request.getParameter("debug"));
        
        if (showDebug) {
            out.println("<div class='debug'>");
            out.println("DEBUG - Parámetros recibidos:<br>");
            out.println("paso: " + paso + "<br>");
            out.println("ipBase: " + ipBase + "<br>");
            out.println("mascaraRed: " + mascaraRed + "<br>");
            out.println("numSubredes: " + numSubredes + "<br>");
            out.println("hostsPorSubred: " + request.getParameter("hostsPorSubred") + "<br>");
            out.println("</div>");
        }
        
        String[] hostsPorSubred = null;
        if (request.getParameter("hostsPorSubred") != null) {
            hostsPorSubred = request.getParameter("hostsPorSubred").split(",");
        }
        
        int contadorSubred = 0;
        if (request.getParameter("contadorSubred") != null) {
            contadorSubred = Integer.parseInt(request.getParameter("contadorSubred"));
        }
    %>
    
    <!-- PASO 1: Ingreso de datos iniciales osea el index pues  -->
    <% if (paso.equals("1")) { %>
    <div class="container">
        <h2>Paso 1: Datos de la Red Principal</h2>
        <form method="post" action="index.jsp">
            <div class="form-group">
                <label for="ipBase">Dirección IP base:</label>
                <input type="text" id="ipBase" name="ipBase" placeholder="Ejemplo: 192.168.1.0" 
                       value="<%= ipBase != null ? ipBase : "" %>" required>
            </div>
            
            <div class="form-group">
                <label for="mascaraRed">Máscara de red (prefijo):</label>
                <input type="number" id="mascaraRed" name="mascaraRed" placeholder="Ejemplo: 24" 
                       min="1" max="30" value="<%= mascaraRed != null ? mascaraRed : "" %>" required>
            </div>
            
            <div class="form-group">
                <label for="numSubredes">Número de subredes a crear:</label>
                <input type="number" id="numSubredes" name="numSubredes" placeholder="Ejemplo: 5" 
                       min="1" value="<%= numSubredes != null ? numSubredes : "" %>" required>
            </div>
            
            <input type="hidden" name="paso" value="2">
            <div class="btn-group">
                <button type="submit" class="btn">Siguiente</button>
            </div>
        </form>
    </div>
    <% } %>
    
    <!-- PASO 2: Este es el ingreso de Hosts por subred -->
    
    
    <% if (paso.equals("2")) { %>
    <div class="container">
        <h2>Paso 2: Configuración de Hosts por Subred</h2>
        
        <div class="info-box">
            <p><strong>Red base:</strong> <%= ipBase %>/<%= mascaraRed %></p>
            <p><strong>Número de subredes:</strong> <%= numSubredes %></p>
        </div>
        
        <form method="post" action="index.jsp">
            <%
                int numSub = Integer.parseInt(numSubredes);
                String hostsActuales = request.getParameter("hostsPorSubred");
                if (hostsActuales == null) hostsActuales = "";
                
                String[] hostsArray = new String[numSub];
                
                if (!hostsActuales.isEmpty()) {
                    String[] hostsTemp = hostsActuales.split(",", -1);
                    
                    for (int i = 0; i < hostsTemp.length && i < numSub; i++) {
                        hostsArray[i] = hostsTemp[i];
                    }
                }
                
                for (int i = 0; i < hostsArray.length; i++) {
                    if (hostsArray[i] == null) {
                        hostsArray[i] = "";
                    }
                }
                
                if (request.getParameter("agregarHost") != null) {
                    contadorSubred = Integer.parseInt(request.getParameter("contadorSubred"));
                    String nuevoHost = request.getParameter("hostsSubred");
                    
                    if (contadorSubred >= 0 && contadorSubred < numSub && nuevoHost != null && !nuevoHost.trim().isEmpty()) {
                        hostsArray[contadorSubred] = nuevoHost.trim();
                        contadorSubred++;
                        
                        StringBuilder sb = new StringBuilder();
                        for (int i = 0; i < hostsArray.length; i++) {
                            if (i > 0) sb.append(",");
                            sb.append(hostsArray[i]);
                        }
                        hostsActuales = sb.toString();
                    }
                }
                
                boolean todosConfigurados = true;
                for (int i = 0; i < numSub; i++) {
                    if (hostsArray[i] == null || hostsArray[i].trim().isEmpty()) {
                        todosConfigurados = false;
                        break;
                    }
                }
            %>
            
            <% if (!todosConfigurados && contadorSubred < numSub) { %>
            
            <div class="form-group">
                <label>¿Cuántos hosts necesita para la subred <%= contadorSubred + 1 %>?</label>
                <input type="number" name="hostsSubred" placeholder="Número de hosts" min="1" required>
            </div>
            <% } %>
            
            <% if (!hostsActuales.isEmpty()) { %>
            
            <div class="resultado">
                <h4>Hosts configurados:</h4>
                <% 
                    String[] hostsConfigurados = hostsActuales.split(",", -1);
                    for (int i = 0; i < hostsConfigurados.length && i < numSub; i++) {
                        if (!hostsConfigurados[i].isEmpty()) {
                %>
                    <p>Subred <%= i + 1 %>: <%= hostsConfigurados[i] %> hosts</p>
                <% 
                        }
                    }
                %>
            </div>
            <% } %>
            
            <input type="hidden" name="ipBase" value="<%= ipBase %>">
            <input type="hidden" name="mascaraRed" value="<%= mascaraRed %>">
            <input type="hidden" name="numSubredes" value="<%= numSubredes %>">
            <input type="hidden" name="hostsPorSubred" value="<%= hostsActuales %>">
            <input type="hidden" name="contadorSubred" value="<%= contadorSubred %>">
            
            <div class="btn-group">
                <% if (!todosConfigurados && contadorSubred < numSub) { %>
                    <input type="hidden" name="paso" value="2">
                    <button type="submit" name="agregarHost" value="true" class="btn">Agregar Hosts</button>
                <% } else { %>
                    <input type="hidden" name="paso" value="3">
                    <button type="submit" class="btn">Calcular VLSM</button>
                    <button type="submit" name="debug" value="true" class="btn btn-secondary">Debug</button>
                <% } %>
            </div>
        </form>
    </div>
    <% } %>
    
    
    <!-- PASO 3: Resultados -->
    
    
    <% if (paso.equals("3")) { %>
    <div class="container">
        <h2>Resultados VLSM</h2>
        
        <%
            try {
                if (ipBase == null || ipBase.trim().isEmpty()) {
                    throw new Exception("Dirección IP base no válida: " + ipBase);
                }
                if (mascaraRed == null || mascaraRed.trim().isEmpty()) {
                    throw new Exception("Máscara de red no válida: " + mascaraRed);
                }
                
                List<Integer> listaHosts = new ArrayList<>();
                String hostsPorSubredParam = request.getParameter("hostsPorSubred");
                
                if (hostsPorSubredParam == null || hostsPorSubredParam.trim().isEmpty()) {
                    throw new Exception("No se encontraron configuraciones de hosts para las subredes.");
                }
                
                String[] hostsStr = hostsPorSubredParam.split(",", -1);
                for (String host : hostsStr) {
                    if (host != null && !host.trim().isEmpty()) {
                        try {
                            int hostCount = Integer.parseInt(host.trim());
                            if (hostCount > 0) {
                                listaHosts.add(hostCount);
                            }
                        } catch (NumberFormatException e) {
                            out.println("<div class='error'>Error al procesar host: '" + host + "' - " + e.getMessage() + "</div>");
                        }
                    }
                }
                
                if (listaHosts.isEmpty()) {
                    throw new Exception("No se encontraron configuraciones válidas de hosts.");
                }
                
                int prefijo = Integer.parseInt(mascaraRed.trim());
                
                if (showDebug) {
                    out.println("<div class='debug'>");
                    out.println("DEBUG - Datos para cálculo:<br>");
                    out.println("IP Base: " + ipBase + "<br>");
                    out.println("Prefijo: " + prefijo + "<br>");
                    out.println("Lista de hosts: " + listaHosts + "<br>");
                    out.println("</div>");
                }
                
                List<SubredInfo> subredes = VLSMCalculadora.calcularVLSM(ipBase, prefijo, listaHosts);
                
                session.setAttribute("subredes", subredes);
                session.setAttribute("ipBase", ipBase);
                session.setAttribute("prefijo", prefijo);
                session.setAttribute("pasoAPaso", VLSMCalculadora.generarPasoAPaso(ipBase, prefijo, listaHosts));
        %>
        
        <div class="resultado">
            <h3>Configuración de Subredes</h3>
            <table>
                <thead>
                    <tr>
                        <th>Subred</th>
                        <th>Dirección de Red</th>
                        <th>Máscara</th>
                        <th>Rango de Hosts</th>
                        <th>Broadcast</th>
                        <th>Hosts Solicitados</th>
                        <th>Hosts Disponibles</th>
                    </tr>
                </thead>
                <tbody>
                    <% for (SubredInfo subred : subredes) { %>
                    <tr>
                        <td><%= subred.getNombre() %></td>
                        <td><%= subred.getDireccionIp() %></td>
                        <td><%= subred.getMascaraSubred() %></td>
                        <td><%= subred.getRangoInicio() %> - <%= subred.getRangoFin() %></td>
                        <td><%= subred.getBroadcast() %></td>
                        <td><%= subred.getHostsSolicitados() %></td>
                        <td><%= subred.getHostsDisponibles() %></td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
        </div>
        
        <div class="proceso">
            <h3>Proceso Paso a Paso</h3>
            <% 
                List<String> pasos = VLSMCalculadora.generarPasoAPaso(ipBase, prefijo, listaHosts);
                for (String pasoTexto : pasos) {
                    if (pasoTexto.contains("/") && pasoTexto.contains("-->")) {
                        out.println("<div class='proceso-binario'>" + pasoTexto + "</div>");
                    } else {
                        out.println(pasoTexto + "<br>");
                    }
                }
            %>
        </div>
        
        <%
            } catch (Exception e) {
                out.println("<div class='error'>");
                out.println("<h3>Error en el cálculo VLSM:</h3>");
                out.println("<p><strong>Mensaje:</strong> " + e.getMessage() + "</p>");
                if (e.getCause() != null) {
                    out.println("<p><strong>Causa:</strong> " + e.getCause().getMessage() + "</p>");
                }
                out.println("<p><strong>Datos recibidos:</strong></p>");
                out.println("<ul>");
                out.println("<li>IP Base: " + ipBase + "</li>");
                out.println("<li>Máscara: " + mascaraRed + "</li>");
                out.println("<li>Hosts por subred: " + request.getParameter("hostsPorSubred") + "</li>");
                out.println("</ul>");
                out.println("</div>");
                e.printStackTrace();
            }
        %>
        
        <div class="btn-group">
            <form method="post" action="generarPDF.jsp" target="_blank">
                <button type="submit" class="btn">Descargar PDF</button>
            </form>
            
            <form method="get" action="index.jsp">
                <button type="submit" class="btn">Nueva Configuración</button>
            </form>
        </div>
    </div>
    <% } %>
</body>
</html>