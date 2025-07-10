package Model;

public class Room {

    private int roomID;

    private String roomType;

    private int maxCapacity;

    private String status;

    private String qrCodePath;

    public Room() {
    }

    public Room(int roomID, String roomType, int maxCapacity, String status, String qrCodePath) {
        this.roomID = roomID;
        this.roomType = roomType;
        this.maxCapacity = maxCapacity;
        this.status = status;
        this.qrCodePath = qrCodePath;
    }

    public int getRoomID() {
        return roomID;
    }
    public void setRoomID(int roomID) {
        this.roomID = roomID;
    }

    public String getRoomType() {
        return roomType;
    }
    public void setRoomType(String roomType) {
        this.roomType = roomType;
    }

    public int getMaxCapacity() {
        return maxCapacity;
    }
    public void setMaxCapacity(int maxCapacity) {
        this.maxCapacity = maxCapacity;
    }

    public String getStatus() {
        return status;
    }
    public void setStatus(String status) {
        this.status = status;
    }

    public String getQrCodePath() {
        return qrCodePath;
    }
    public void setQrCodePath(String qrCodePath) {
        this.qrCodePath = qrCodePath;
    }

    @Override
    public String toString() {
        return "Room{" +
                "roomID=" + roomID +
                ", roomType='" + roomType + '\'' +
                ", maxCapacity=" + maxCapacity +
                ", status='" + status + '\'' +
                ", qrCodePath='" + qrCodePath + '\'' +
                '}';
    }
}
