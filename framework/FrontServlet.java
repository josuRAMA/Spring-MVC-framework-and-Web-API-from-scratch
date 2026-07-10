import java.io.IOException;
import java.util.List;

import annotation.Controller;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.ServletException;

public class FrontServlet extends HttpServlet{

    @Override 
    public void doGet(HttpServletRequest req, HttpServletResponse res) 
        throws ServletException, IOException {
    
        process(req,res);
    }

    @Override 
    public void doPost(HttpServletRequest req, HttpServletResponse res) 
        throws ServletException, IOException {
    
        process(req,res);
    }

    private void process(HttpServletRequest req, HttpServletResponse res)
        throws ServletException, IOException   {

        System.out.println("hello");

        String uri = req.getRequestURI();

        System.out.println(uri);
        //ModelView mv = router.dispatch(url, req);

        /*req.setAttribute("data",mv.getData());
        req.getRequestDispatcher("/WEB-INF/views/" + mv.getView());*/
    }
}
