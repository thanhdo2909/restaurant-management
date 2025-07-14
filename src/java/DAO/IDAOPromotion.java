/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import java.util.List;
import Model.Promotion;
/**
 *
 * @author admin
 */
public interface IDAOPromotion {
    List<Promotion> getAll();
    Promotion getById(int id);
    void add(Promotion p);
    void update(Promotion p);
    void delete(int id);
    void toggleStatus(int id, boolean active);
}
