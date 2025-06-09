/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

/**
 *
 * @author ACER
 */
import java.util.Date;

public class RoomBooking {
    private int bookingID;
    private int accountId;
    private int roomID;
    private Date startTime;
    private Date endTime;

    // Constructor
    public RoomBooking(int bookingID, int accountId, int roomID, Date startTime, Date endTime) {
        this.bookingID = bookingID;
        this.accountId = accountId;
        this.roomID = roomID;
        this.startTime = startTime;
        this.endTime = endTime;
    }

    // Getters and setters
    public int getBookingID() {
        return bookingID;
    }

    public void setBookingID(int bookingID) {
        this.bookingID = bookingID;
    }

    public int getAccountId() {
        return accountId;
    }

    public void setAccountId(int accountId) {
        this.accountId = accountId;
    }

  

    public int getRoomID() {
        return roomID;
    }

    public void setRoomID(int roomID) {
        this.roomID = roomID;
    }

    public Date getStartTime() {
        return startTime;
    }

    public void setStartTime(Date startTime) {
        this.startTime = startTime;
    }

    public Date getEndTime() {
        return endTime;
    }

    public void setEndTime(Date endTime) {
        this.endTime = endTime;
    }

    @Override
    public String toString() {
        return "RoomBooking{" +
                "bookingID=" + bookingID +
              
                ", roomID=" + roomID +
                ", startTime=" + startTime +
                ", endTime=" + endTime +
                '}';
    }
}

