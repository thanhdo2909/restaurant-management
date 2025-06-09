/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package service;

import DAO.DAORoomBooking;

/**
 *
 * @author ACER
 */
public class DAORoomBookingService {
      private DAORoomBooking daoRoomBooking;

    public DAORoomBookingService( ) {
    
    this.daoRoomBooking = new DAORoomBooking(); 
    }
    public int checkAvailableRoom(String startTime, String endTime){
        return daoRoomBooking.checkAvailableRoom(startTime, endTime);
    }
    public boolean BookRoom (String accountId, String roomId, String startTime, String endTime){
        return daoRoomBooking.BookRoom(accountId, roomId, startTime, endTime);
    }
    public int RoomId (String id ){
        return daoRoomBooking.RoomId(id);
    }
    
}
