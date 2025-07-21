package Model;

import java.sql.Timestamp;

public class RoomBooking {
    private int bookingID;
    private int accountID;
    private int roomID;
    private Timestamp startTime;
    private Timestamp endTime;
    private String status;
    private int people;
    private String message;
    private String phone; // Added phone field

    public RoomBooking() {
    }

    public RoomBooking(int bookingID, int accountID, int roomID, Timestamp startTime, Timestamp endTime, String status) {
        this.bookingID = bookingID;
        this.accountID = accountID;
        this.roomID = roomID;
        this.startTime = startTime;
        this.endTime = endTime;
        this.status = status;
    }

    public RoomBooking(int bookingID, int accountID, int roomID, Timestamp startTime, Timestamp endTime, String status, int people, String message, String phone) {
        this(bookingID, accountID, roomID, startTime, endTime, status);
        this.people = people;
        this.message = message;
        this.phone = phone;
    }

    public int getBookingID() {
        return bookingID;
    }
    public void setBookingID(int bookingID) {
        this.bookingID = bookingID;
    }

    public int getAccountID() {
        return accountID;
    }
    public void setAccountID(int accountID) {
        this.accountID = accountID;
    }

    public int getRoomID() {
        return roomID;
    }
    public void setRoomID(int roomID) {
        this.roomID = roomID;
    }

    public Timestamp getStartTime() {
        return startTime;
    }
    public void setStartTime(Timestamp startTime) {
        this.startTime = startTime;
    }

    public Timestamp getEndTime() {
        return endTime;
    }
    public void setEndTime(Timestamp endTime) {
        this.endTime = endTime;
    }

    public String getStatus() {
        return status;
    }
    public void setStatus(String status) {
        this.status = status;
    }

    public int getPeople() {
        return people;
    }
    public void setPeople(int people) {
        this.people = people;
    }

    public String getMessage() {
        return message;
    }
    public void setMessage(String message) {
        this.message = message;
    }

    public String getPhone() {
        return phone;
    }
    public void setPhone(String phone) {
        this.phone = phone;
    }

    @Override
    public String toString() {
        return "RoomBooking{" +
                "bookingID=" + bookingID +
                ", accountID=" + accountID +
                ", roomID=" + roomID +
                ", startTime=" + startTime +
                ", endTime=" + endTime +
                ", status='" + status + '\'' +
                ", people=" + people +
                ", message='" + message + '\'' +
                ", phone='" + phone + '\'' +
                '}';
    }
}