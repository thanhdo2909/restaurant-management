/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

/**
 *
 * @author ACER
 */
public class OrderChartStats {
   private String timeUnit;
    private int orderCount;

    public OrderChartStats(String timeUnit, int orderCount) {
        this.timeUnit = timeUnit;
        this.orderCount = orderCount;
    }

    public String getTimeUnit() { return timeUnit; }
    public int getOrderCount() { return orderCount; } 
}
