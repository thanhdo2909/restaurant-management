/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package service;

import DAO.DAOReview;
import Model.Review;
import java.util.ArrayList;

/**
 *
 * @author ACER
 */
public class DAOReviewService {
        private DAOReview daoReview;
         public DAOReviewService( ) {
        this.daoReview = daoReview;
    }
         public ArrayList<Review> getAll() {
        return daoReview.getAll();
    }
      public static void main(String[] args) {
        DAOReviewService d = new DAOReviewService();
        ArrayList<Review> a = d.getAll();
          for (Review Review : a) {
              System.out.println(Review);
          }
}
}
