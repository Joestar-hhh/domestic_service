package com.cykj.domestic.config.intercepors;

import com.alibaba.fastjson.JSON;
import com.cykj.domestic.entity.Company;
import com.cykj.domestic.util.ResultData;
import org.springframework.boot.ansi.AnsiOutput;
import org.springframework.lang.Nullable;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@Component
public class LoginInterceptor implements HandlerInterceptor  {
    //这个方法是在访问接口之前执行的，我们只需要在这里写验证登陆状态的业务逻辑，就可以在用户调用指定接口之前验证登陆状态了
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        //每一个项目对于登陆的实现逻辑都有所区别，我这里使用最简单的Session提取User来验证登陆。
        HttpSession session = request.getSession();
        //这里的User是登陆时放入session的
        Company company = (Company) session.getAttribute("company");
        //如果session中没有user，表示没登陆
        if (company == null){
            //这个方法返回false表示忽略当前请求，如果一个用户调用了需要登陆才能使用的接口，如果他没有登陆这里会直接忽略掉
            //当然你可以利用response给用户返回一些提示信息，告诉他没登陆
//            response.sendRedirect(request.getContextPath() + "/pages/company/company_login.jsp");
            System.out.println("未登录--------------"+request.getContextPath());

            if (request.getHeader("x-requested-with") != null
                    && request.getHeader("x-requested-with").equalsIgnoreCase("XMLHttpRequest")) {
                //处理ajax请求
                System.out.println("ajax调用");
                response.setHeader("sessionstatus", "timeout");
                response.setStatus(403);
            } else {
                System.out.println("跳转登录页-----------");
                response.sendRedirect(request.getContextPath() + "/pages/company/company_login.jsp");
            }
            return false;
        }else {
            return true;    //如果session里有user，表示该用户已经登陆，放行，用户即可继续调用自己需要的接口
        }
    }

    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, @Nullable ModelAndView modelAndView) throws Exception {
    }

    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, @Nullable Exception ex) throws Exception {
    }
}

