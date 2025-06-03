/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

/**
 *
 * @author ACER
 */
public class Room {
    private int roomID;
    private String qrCodePath;
    private String status;

    // Constructor
    public Room(int roomID, String qrCodePath, String status) {
        this.roomID = roomID;
        this.qrCodePath = qrCodePath;
        this.status = status;
    }

    // Getters and setters
    public int getRoomID() {
        return roomID;
    }

    public void setRoomID(int roomID) {
        this.roomID = roomID;
    }

    public String getQrCodePath() {
        return qrCodePath;
    }

    public void setQrCodePath(String qrCodePath) {
        this.qrCodePath = qrCodePath;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    @Override
    public String toString() {
        return "Room{" +
                "roomID=" + roomID +
                ", qrCodePath='" + qrCodePath + '\'' +
                ", status='" + status + '\'' +
                '}';
    }
}

