package Model;

import java.math.BigDecimal;

public class RevenueStats {
    private String timeUnit;
    private BigDecimal totalRevenue;

    public RevenueStats(String timeUnit, BigDecimal totalRevenue) {
        this.timeUnit = timeUnit;
        this.totalRevenue = totalRevenue;
    }

    public String getTimeUnit() {
        return timeUnit;
    }

    public BigDecimal getTotalRevenue() {
        return totalRevenue;
    }
}
