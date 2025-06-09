/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Model.RoomBooking;
import java.util.ArrayList;

/**
 *
 * @author ACER
 */
public interface IDAORoomBooking {
     ArrayList<RoomBooking> getAll();
  int checkAvailableRoom(String startTime, String endTime);

    boolean BookRoom(String accountId ,String roomId ,String startTime ,String endTime );
    int RoomId (String id );
}
