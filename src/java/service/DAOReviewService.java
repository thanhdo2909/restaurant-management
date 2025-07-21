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
        this.daoReview =new  DAOReview();
    }
         public ArrayList<Review> getAll (String id){
             return daoReview.getAll(id);
         }
         public boolean insertReview (String FoodId, String AccountId, String Comment, String Rating, String CreatedAt){
             return daoReview.insertReview(FoodId, AccountId, Comment, Rating, CreatedAt);
         }
      public static void main(String[] args) {
        DAOReviewService d = new DAOReviewService();
        ArrayList<Review> a = d.getAll("1");
          for (Review Review : a) {
              System.out.println(Review);
          }
}
}
