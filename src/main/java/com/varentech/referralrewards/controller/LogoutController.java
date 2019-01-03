package com.varentech.referralrewards.controller;

import org.springframework.stereotype.Controller;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;

@Controller
public class LogoutController extends HttpServlet {
private static final long serialVersionUID = 1L;
protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
    response.setContentType("text/html");
    PrintWriter out = response.getWriter();
    out.println("Thanks For Visiting!");
    HttpSession session = request.getSession(false);
    session.removeAttribute("user");

}



}
 /*   @RequestMapping(value = "/loginPage", method = RequestMethod.GET)
    public ModelAndView loginPage(@RequestParam(value = "error",required = false) String error,
                                  @RequestParam(value = "/logout",	required = false) String logout) {

        ModelAndView model = new ModelAndView();
        if (error != null) {
            model.addObject("error", "Invalid Credentials provided.");
        }

        if (logout != null) {
            model.addObject("message", "Logged out from JournalDEV successfully.");
        }

        model.setViewName("/loginPage");
        return model;
    }*/



   /* @GetMapping("/logout")
    public String processLogout(){
        System.out.println("reached");
        return "logout";
    }*/

    /*@GetMapping(value="/logout")
    public String processLogout (HttpServletRequest request, HttpServletResponse response) {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        if (auth != null){
            new SecurityContextLogoutHandler().logout(request, response, auth);
        }
        return "redirect:/login?logout";//You can redirect wherever you want, but generally it's a good practice to show login screen again.
    }*/
//}
