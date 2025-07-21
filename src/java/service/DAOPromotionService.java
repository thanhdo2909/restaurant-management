/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package service;

import DAO.DAOPromotion;
import DAO.IDAOPromotion;
import Model.Promotion;
import java.util.List;
/**
 *
 * @author admin
 */
public class DAOPromotionService implements IDAOPromotion {
    private final DAOPromotion dao = new DAOPromotion();

    @Override
    public List<Promotion> getAll() {
        return dao.getAll();
    }

    @Override
    public Promotion getById(int id) {
        return dao.getById(id);
    }

    @Override
    public void add(Promotion p) {
        System.out.println(">> DAO.add() called: " + p.getPromoCode());
        dao.add(p);
    }

    @Override
    public void update(Promotion p) {
        dao.update(p);
    }

    @Override
    public void delete(int id) {
        dao.delete(id);
    }

    @Override
    public void toggleStatus(int id, boolean active) {
        dao.toggleStatus(id, active);
    }
}