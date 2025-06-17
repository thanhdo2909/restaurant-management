/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Model.Notification;
import java.util.ArrayList;

/**
 *
 * @author ACER
 */
public interface IDAONotification {
     ArrayList <Notification> getAll(String id);
     Notification  notificationDetail(String id );
     boolean isRead (String id);
}
