
FROM tomcat:11.0-jdk17  # Usa Tomcat 11 con Java 17 (versión compatible con tu proyecto)
COPY dist/VLSM06.war /usr/local/tomcat/webapps/ROOT.war  # Copia tu WAR al directorio de Tomcat
EXPOSE 8080  # Puerto que usará Tomcat (Railway lo redirigirá automáticamente)