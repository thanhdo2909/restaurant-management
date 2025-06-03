/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package LoginbyGoogle;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
public class Constants {
    public static String GOOGLE_CLIENT_ID = "699392886816-j6212kjvnv15d5njg55emslgb50ta4ub.apps.googleusercontent.com";

	public static String GOOGLE_CLIENT_SECRET = "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";

	public static String GOOGLE_REDIRECT_URI = "http://localhost:9999/quan_ly_nha_hang/home/Home.jsp";

	public static String GOOGLE_LINK_GET_TOKEN = "https://oauth2.googleapis.com/token";

	public static String GOOGLE_LINK_GET_USER_INFO = "https://www.googleapis.com/oauth2/v1/userinfo?access_token=";

	public static String GOOGLE_GRANT_TYPE = "authorization_code";
}
