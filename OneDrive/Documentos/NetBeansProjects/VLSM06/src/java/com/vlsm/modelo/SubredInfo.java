/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.vlsm.modelo;

/**
 *
 * @author danna
 */
public class SubredInfo {
    private String nombre;
    private String direccionIp;
    private String direccionIpBinaria;
    private String mascaraSubred;
    private String mascaraSubredBinaria;
    private String rangoInicio;
    private String rangoFin;
    private String broadcast;
    private int hostsSolicitados;
    private int hostsDisponibles;
    private String procesoBinario;

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getDireccionIp() {
        return direccionIp;
    }

    public void setDireccionIp(String direccionIp) {
        this.direccionIp = direccionIp;
    }

    public String getDireccionIpBinaria() {
        return direccionIpBinaria;
    }

    public void setDireccionIpBinaria(String direccionIpBinaria) {
        this.direccionIpBinaria = direccionIpBinaria;
    }

    public String getMascaraSubred() {
        return mascaraSubred;
    }

    public void setMascaraSubred(String mascaraSubred) {
        this.mascaraSubred = mascaraSubred;
    }

    public String getMascaraSubredBinaria() {
        return mascaraSubredBinaria;
    }

    public void setMascaraSubredBinaria(String mascaraSubredBinaria) {
        this.mascaraSubredBinaria = mascaraSubredBinaria;
    }

    public String getRangoInicio() {
        return rangoInicio;
    }

    public void setRangoInicio(String rangoInicio) {
        this.rangoInicio = rangoInicio;
    }

    public String getRangoFin() {
        return rangoFin;
    }

    public void setRangoFin(String rangoFin) {
        this.rangoFin = rangoFin;
    }

    public String getBroadcast() {
        return broadcast;
    }

    public void setBroadcast(String broadcast) {
        this.broadcast = broadcast;
    }

    public int getHostsSolicitados() {
        return hostsSolicitados;
    }

    public void setHostsSolicitados(int hostsSolicitados) {
        this.hostsSolicitados = hostsSolicitados;
    }

    public int getHostsDisponibles() {
        return hostsDisponibles;
    }

    public void setHostsDisponibles(int hostsDisponibles) {
        this.hostsDisponibles = hostsDisponibles;
    }

    public String getProcesoBinario() {
        return procesoBinario;
    }

    public void setProcesoBinario(String procesoBinario) {
        this.procesoBinario = procesoBinario;
    }
    
    public SubredInfo() {
    }

    public SubredInfo(String nombre, String direccionIp, String direccionIpBinaria,
            String mascaraSubred, String mascaraSubredBinaria,
            String rangoInicio, String rangoFin, String broadcast,
            int hostsSolicitados, int hostsDisponibles, String procesoBinario) {
        this.nombre = nombre;
        this.direccionIp = direccionIp;
        this.direccionIpBinaria = direccionIpBinaria;
        this.mascaraSubred = mascaraSubred;
        this.mascaraSubredBinaria = mascaraSubredBinaria;
        this.rangoInicio = rangoInicio;
        this.rangoFin = rangoFin;
        this.broadcast = broadcast;
        this.hostsSolicitados = hostsSolicitados;
        this.hostsDisponibles = hostsDisponibles;
        this.procesoBinario = procesoBinario;
    }
}
