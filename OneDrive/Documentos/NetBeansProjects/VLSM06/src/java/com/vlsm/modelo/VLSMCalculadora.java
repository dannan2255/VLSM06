/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.vlsm.modelo;

/**
 *
 * @author danna
 */
import java.util.List;
import java.util.ArrayList;
import java.util.Collections;

public class VLSMCalculadora {
    public static String ipABinario(String ip) {
        String[] octetos = ip.split("\\.");
        StringBuilder binario = new StringBuilder();

        for (int i = 0; i < octetos.length; i++) {
            int octeto = Integer.parseInt(octetos[i]);
            

            String octBinario = String.format("%8s", Integer.toBinaryString(octeto)).replace(' ', '0');
            binario.append(octBinario);
            
            if (i < octetos.length - 1) {
                binario.append(".");
            }
        }
        return binario.toString();
    }

    public static String binarioAIp(String binario) {
        String[] octetos = binario.split("\\.");
        StringBuilder ip = new StringBuilder();

        for (int i = 0; i < octetos.length; i++) {
            int decimal = Integer.parseInt(octetos[i], 2);
            
            ip.append(decimal);
            
            if (i < octetos.length - 1) {
                ip.append(".");
            }
        }
        return ip.toString();
    }

    public static String obtenerMascaraDecimal(int prefijo) {
        StringBuilder mascara = new StringBuilder();
        int bitsRestantes = prefijo;  // Cuantos bits de la mascara estan en 1
        
        for (int i = 0; i < 4; i++) {
            int octeto = 0;
            
            if (bitsRestantes >= 8) {
                octeto = 255;
                bitsRestantes -= 8;
            } else if (bitsRestantes > 0) {
                octeto = 256 - (int)Math.pow(2, 8 - bitsRestantes);
                bitsRestantes = 0;
            }
            
            mascara.append(octeto);
            if (i < 3) {
                mascara.append(".");
            }
        }
        
        return mascara.toString();
    }

    public static int calcularHostsNecesarios(int hostsSolicitados) {
        int totalNecesario = hostsSolicitados + 2;
        int potencia = 1;
        
        while (potencia < totalNecesario) {
            potencia *= 2;
        }
        return potencia;
    }

    public static int calcularNuevoPrefijo(int prefijoOriginal, int hostsNecesarios) {
        int bitsNecesarios = (int) (Math.log(hostsNecesarios) / Math.log(2));
        return 32 - bitsNecesarios;
    }

    private static String longAIp(long ip) {
        int octeto1 = (int)(ip / 16777216) % 256;
        int octeto2 = (int)(ip / 65536) % 256;
        int octeto3 = (int)(ip / 256) % 256;
        int octeto4 = (int)(ip % 256);
        
        return octeto1 + "." + octeto2 + "." + octeto3 + "." + octeto4;
    }

    public static List<SubredInfo> calcularVLSM(String ipBase, int prefijoOriginal, List<Integer> hostsPorSubred) {
        List<SubredInfo> subredes = new ArrayList<>();
        List<Integer> hostsOrdenados = new ArrayList<>(hostsPorSubred);
        Collections.sort(hostsOrdenados, Collections.reverseOrder());

        String[] octetos = ipBase.split("\\.");
        long ipBaseLong = 0;
        for (int i = 0; i < 4; i++) {
            ipBaseLong = ipBaseLong * 256 + Integer.parseInt(octetos[i]);
        }

        long ipActual = ipBaseLong;
        int numeroSubred = 1;

        for (int i = 0; i < hostsOrdenados.size(); i++) {
            int hostsSolicitados = hostsOrdenados.get(i);
            int hostsNecesarios = calcularHostsNecesarios(hostsSolicitados);
            int nuevoPrefijo = calcularNuevoPrefijo(prefijoOriginal, hostsNecesarios);

            String direccionRed = longAIp(ipActual);
            String direccionRedBinaria = ipABinario(direccionRed);
            String mascara = obtenerMascaraDecimal(nuevoPrefijo);
            String mascaraBinaria = ipABinario(mascara);

            long rangoInicioLong = ipActual + 1;
            long rangoFinLong = ipActual + hostsNecesarios - 2;
            long broadcastLong = ipActual + hostsNecesarios - 1;

            String rangoInicio = longAIp(rangoInicioLong);
            String rangoFin = longAIp(rangoFinLong);
            String broadcast = longAIp(broadcastLong);

            String procesoBinario = generarProcesoBinario(direccionRedBinaria, nuevoPrefijo, numeroSubred);

            SubredInfo subred = new SubredInfo(
                    "Subred " + numeroSubred,
                    direccionRed,
                    direccionRedBinaria,
                    mascara,
                    mascaraBinaria,
                    rangoInicio,
                    rangoFin,
                    broadcast,
                    hostsSolicitados,
                    hostsNecesarios - 2,
                    procesoBinario
            );

            subredes.add(subred);
            ipActual += hostsNecesarios;
            numeroSubred++;
        }

        return subredes;
    }

    private static String generarProcesoBinario(String ipBinaria, int prefijo, int numeroSubred) {
        StringBuilder proceso = new StringBuilder();
        String[] octetosBinarios = ipBinaria.split("\\.");
        String ipBinariaSinPuntos = String.join("", octetosBinarios);
        
        proceso.append(ipBinariaSinPuntos.substring(0, prefijo));
        
        if (prefijo < 32) {
            proceso.append(" ");
            proceso.append(ipBinariaSinPuntos.substring(prefijo));
        }
        
        proceso.append(" /").append(prefijo).append("  --> Subred ").append(numeroSubred);
        proceso.append("\n").append(binarioAIp(ipBinaria)).append("/").append(prefijo);
        
        return proceso.toString();
    }

    public static List<String> generarPasoAPaso(String ipBase, int prefijoOriginal, List<Integer> hostsPorSubred) {
        List<String> pasos = new ArrayList<>();
        List<Integer> hostsOrdenados = new ArrayList<>(hostsPorSubred);
        Collections.sort(hostsOrdenados, Collections.reverseOrder());

        pasos.add("=== PROCESO VLSM PASO A PASO ===");
        pasos.add("");
        pasos.add("Red original: " + ipBase + "/" + prefijoOriginal);
        pasos.add("En binario: " + ipABinario(ipBase));
        pasos.add("Máscara original: " + obtenerMascaraDecimal(prefijoOriginal));
        pasos.add("En binario: " + ipABinario(obtenerMascaraDecimal(prefijoOriginal)));
        pasos.add("");

        pasos.add("Paso 1: Ordenar subredes por número de hosts (mayor a menor)");
        for (int i = 0; i < hostsOrdenados.size(); i++) {
            pasos.add("Subred " + (i + 1) + ": " + hostsOrdenados.get(i) + " hosts");
        }
        pasos.add("");

        String[] octetos = ipBase.split("\\.");
        long ipBaseLong = 0;
        for (int i = 0; i < 4; i++) {
            ipBaseLong = ipBaseLong * 256 + Integer.parseInt(octetos[i]);
        }

        long ipActual = ipBaseLong;
        int numeroSubred = 1;

        for (int i = 0; i < hostsOrdenados.size(); i++) {
            int hostsSolicitados = hostsOrdenados.get(i);
            pasos.add("=== SUBRED " + numeroSubred + " ===");
            pasos.add("Hosts solicitados: " + hostsSolicitados);

            int hostsNecesarios = calcularHostsNecesarios(hostsSolicitados);
            pasos.add("Hosts necesarios (incluyendo red y broadcast): " + hostsNecesarios);

            int nuevoPrefijo = calcularNuevoPrefijo(prefijoOriginal, hostsNecesarios);
            pasos.add("Bits necesarios para hosts: " + (32 - nuevoPrefijo));
            pasos.add("Nueva máscara: /" + nuevoPrefijo);

            String direccionRed = longAIp(ipActual);
            pasos.add("Dirección de red: " + direccionRed);
            
            String ipBinaria = ipABinario(direccionRed);
            pasos.add("En binario: " + ipBinaria);
            
            String procesoBinario = generarProcesoBinario(ipBinaria, nuevoPrefijo, numeroSubred);
            pasos.add("\nProceso en binario:");
            pasos.add(procesoBinario);

            String mascara = obtenerMascaraDecimal(nuevoPrefijo);
            pasos.add("\nMáscara de subred: " + mascara);
            pasos.add("En binario: " + ipABinario(mascara));

            long rangoInicioLong = ipActual + 1;
            long rangoFinLong = ipActual + hostsNecesarios - 2;
            long broadcastLong = ipActual + hostsNecesarios - 1;

            pasos.add("Primer host: " + longAIp(rangoInicioLong));
            pasos.add("Último host: " + longAIp(rangoFinLong));
            pasos.add("Broadcast: " + longAIp(broadcastLong));
            pasos.add("Hosts disponibles: " + (hostsNecesarios - 2));
            pasos.add("");

            ipActual += hostsNecesarios;
            numeroSubred++;
        }

        return pasos;
    }
}
