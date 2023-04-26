/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.tmdt.controllers;

import com.tmdt.pojos.Customer;
import com.tmdt.pojos.Product;
import com.tmdt.pojos.Account;
import com.tmdt.pojos.Admin;
import com.tmdt.pojos.Cart;
import com.tmdt.pojos.Image;
import com.tmdt.pojos.Likes;
import com.tmdt.pojos.OrderDetail;
import com.tmdt.pojos.Orders;
import com.tmdt.pojos.Report;
import com.tmdt.pojos.Seller;
import com.tmdt.pojos.SellerOrder;
import com.tmdt.service.AccountService;
import com.tmdt.service.AdminService;
import com.tmdt.service.CategoryService;
import com.tmdt.service.CustomerService;
import com.tmdt.service.ImageService;
import com.tmdt.service.LocationService;
import com.tmdt.service.MailService;
import com.tmdt.service.OrderDetailService;
import com.tmdt.service.OrderService;
import com.tmdt.service.ProductService;
import com.tmdt.service.SellerService;
import com.tmdt.utils.Utils;
import com.tmdt.validator.AccountValidator;
import java.security.Principal;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import net.bytebuddy.utility.RandomString;
import org.hibernate.annotations.Target;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.env.Environment;
import org.springframework.http.HttpRequest;
import org.springframework.security.core.Authentication;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

/**
 *
 * @author DELL
 */
@Controller
@ControllerAdvice
public class HomeController {

    @Autowired
    private MailService mailService;
    @Autowired
    private AccountService userDetailsService;
    @Autowired
    private CustomerService customerService;
    @Autowired
    private SellerService sellerService;
    @Autowired
    private CategoryService categoryService;
    @Autowired
    private AdminService adminService;
    @Autowired
    private OrderService orderService;
    @Autowired
    private OrderDetailService orderDetailService;
    @Autowired
    private AccountValidator accountValidator;
    @Autowired
    private LocationService locationService;
    @Autowired
    private ProductService productService;
    @Autowired
    private ImageService imageService;
    @Autowired
    private Environment env;
    @Autowired
    private BCryptPasswordEncoder passwordEncoder;

    @ModelAttribute
    public void common(Model model, HttpSession s) {
        model.addAttribute("categories", this.categoryService.getCates());
    }

    @GetMapping("/login")
    public String login() {

        return "login";
    }

    @GetMapping("/access-denied")
    public String accessDenied() {

        return "access-denied";
    }

    @GetMapping("/seller-detail/{sellerId}")
    public String sellerDetail(Model model, @PathVariable(value = "sellerId") int sellerId,
            @RequestParam(required = false) Map<String, String> params, HttpSession s, Authentication a) {
        Account ac = this.userDetailsService.getAcByUsername(a.getName());
        int page = Integer.parseInt(params.getOrDefault("page", "1"));
        Map<String, String> pre = new HashMap<>();
        pre.put("sort", params.getOrDefault("sort", ""));
        pre.put("cateId", params.getOrDefault("cateId", ""));
        pre.put("kw", params.getOrDefault("kw", ""));
        model.addAttribute("general", this.sellerService.getgeneral(sellerId));
        model.addAttribute("seller", this.sellerService.getSellerById(sellerId));
        model.addAttribute("sellerAuthentication", ac.getSeller());
        model.addAttribute("cateBySeller", this.categoryService.getCateBySellerId(sellerId));
        model.addAttribute("productBySeller", this.productService.getProductBySeller(pre, sellerId, page));
        model.addAttribute("counterS", this.productService.getProductBySeller(pre, sellerId, 0).size());
        model.addAttribute("cartCounter", Utils.countCart((Map<Integer, Cart>) s.getAttribute("cartProduct")));
        model.addAttribute("count", env.getProperty("page.size"));
        model.addAttribute("sellerRating", Utils.avgRating(this.productService.getRatingSeller(sellerId)));
        model.addAttribute("pUsdPriceOfProduct", new Utils());
        return "seller-detail";
    }

    @GetMapping("/")
    public String home(Model model, @RequestParam(required = false) Map<String, String> params, HttpSession s) {
        int page = Integer.parseInt(params.getOrDefault("page", "1"));
        Map<String, String> pre = new HashMap<>();
        pre.put("kw", params.getOrDefault("kw", ""));
        pre.put("fp", params.getOrDefault("fp", ""));
        pre.put("tp", params.getOrDefault("tp", ""));
        pre.put("id", params.getOrDefault("id", ""));
        pre.put("sort", params.getOrDefault("sort", "desc"));
        pre.put("seller", params.getOrDefault("seller", ""));
        pre.put("cat", params.getOrDefault("cat", ""));
        pre.put("location", params.getOrDefault("location", ""));
        model.addAttribute("pUsdPriceOfProduct", new Utils());
        String cateId = params.get("cateId");
        model.addAttribute("cateId", cateId);
        if (cateId == null) {
            model.addAttribute("product", this.productService.getProducts(pre, page));
            model.addAttribute("counterS", this.productService.getProducts(pre, 0).size());
            model.addAttribute("buyALot", this.productService.getProductBuyALot(Integer.parseInt(env.getProperty("buyALot.size"))));
            model.addAttribute("likeALot", this.productService.getProductLikeALot(Integer.parseInt(env.getProperty("buyALot.size"))));
        } else {
            model.addAttribute("product", this.productService.getProductByCateId(Integer.parseInt(cateId), page));
            model.addAttribute("counterS", this.productService.getProductByCateId(Integer.parseInt(cateId), 0).size());
        }
        model.addAttribute("count", env.getProperty("page.size"));
        model.addAttribute("cartCounter", Utils.countCart((Map<Integer, Cart>) s.getAttribute("cartProduct")));
        return "home";
    }

    @GetMapping("/search")
    public String search(Model model,
            @RequestParam(required = false) Map<String, String> params, HttpSession s) {
        int page = Integer.parseInt(params.getOrDefault("page", "1"));
        model.addAttribute("categories", this.categoryService.getCates());

        String kw = params.getOrDefault("kw", "");
        model.addAttribute("pUsdPriceOfProduct", new Utils());
        model.addAttribute("sellers", this.sellerService.getSellers(kw, page));
        model.addAttribute("sellerCounterS", this.sellerService.getSellers(kw, 0).size());
        Map<String, String> pre = new HashMap<>();

        pre.put("kw", kw);
        pre.put("fp", params.getOrDefault("fp", ""));
        pre.put("tp", params.getOrDefault("tp", ""));
        pre.put("id", params.getOrDefault("id", ""));
        pre.put("sort", params.getOrDefault("sort", "desc"));
        pre.put("cat", params.getOrDefault("cat", ""));
        pre.put("location", params.getOrDefault("location", ""));

        List<Product> lp = this.productService.getProducts(pre, page);
        model.addAttribute("listProduct", lp);
        model.addAttribute("currentPage", page);
        model.addAttribute("productCounterS", this.productService.getProducts(pre, 0).size());
        model.addAttribute("kw", kw);
        model.addAttribute("count", env.getProperty("page.size"));
        model.addAttribute("cartCounter", Utils.countCart((Map<Integer, Cart>) s.getAttribute("cartProduct")));
        model.addAttribute("locations", this.locationService.getLos());
        return "search";
    }

    @GetMapping("/product-detail/{productId}")
    public String productDetail(Model model, @PathVariable(value = "productId") int productId, HttpSession s, Authentication a) {
        model.addAttribute("product", this.productService.getProductById(productId));
        model.addAttribute("seller", this.productService.getProductById(productId).getIdSeller());
        model.addAttribute("general", this.sellerService.getgeneral(this.productService.getProductById(productId).getIdSeller().getId()));
        model.addAttribute("image", this.imageService.getImageByProductId(productId));
        model.addAttribute("cartCounter", Utils.countCart((Map<Integer, Cart>) s.getAttribute("cartProduct")));
        model.addAttribute("buyALotSeller", this.productService.getProductBuyALotInSeller(Integer.parseInt(env.getProperty("buyALot.size")), this.productService.getProductById(productId).getIdSeller().getId()));
        model.addAttribute("avgRating", Utils.avgRating(this.productService.getRating(productId)));
        model.addAttribute("countRating", this.productService.getRating(productId).size());
        model.addAttribute("sellerRating", Utils.avgRating(this.productService.getRatingSeller(this.productService.getProductById(productId).getIdSeller().getId())));
        model.addAttribute("likes", this.productService.getLikesOfProduct(productId));
        model.addAttribute("productService", this.productService);
        model.addAttribute("pUsdPriceOfProduct", new Utils());
        model.addAttribute("report", new Report());
        model.addAttribute("shipAddress", this.customerService);
        return "product-detail";
    }

    @GetMapping("/product-detail/buyNow")
    public String buyNow(Model model, RedirectAttributes r, HttpServletRequest request, Authentication a) {
        Account ac = this.userDetailsService.getAcByUsername(a.getName());
        Orders o = new Orders();
        o.setActive(1);
        o.setIdCustomer(ac.getCustomer());
        o.setOrderDate(new Date());
        Date requiredDate = new Date();
        requiredDate.setDate(requiredDate.getDate() + 7);
        o.setRequiredDate(requiredDate);
        o.setAmount(Long.parseLong(request.getParameter("amount").replace(".0", "")));
        o.setShipFee(0);
        o.setPaymentType(1);
        o.setIsPayment(0);
        o.setIdShipAdress(this.customerService.findShipPriority(ac.getCustomer()));
        if (this.orderService.addOrder(o) == true) {
            OrderDetail od = new OrderDetail();
            Product p = this.productService.getProductById(Integer.parseInt(request.getParameter("idProduct")));
            od.setIdProduct(p);
            od.setUnitPrice(Long.parseLong(p.getPrice().toString().replace(".0", "")));
            od.setQuantity(1);
            od.setDiscount(0);
            od.setIdOrder(o);
            if (this.orderDetailService.addOrderD(od) == true) {
                SellerOrder so = new SellerOrder();
                so.setIdOrder(o);
                so.setIdSeller(p.getIdSeller());
                if (this.orderDetailService.addSellerOrder(so) == true) {
                    r.addFlashAttribute("errMessage", "Mua thành công!!");
                    SimpleDateFormat dt = new SimpleDateFormat("dd/MM/yyyy hh:mm:ss");
                    SimpleDateFormat dk = new SimpleDateFormat("dd/MM/yyyy");
                    DecimalFormat df = new DecimalFormat("###,###,###,###");

                    String sendTo = o.getIdCustomer().getEmail();
                    String subject = "WEBECOMMERCE THÔNG BÁO - ĐẶT HÀNG THÀNH CÔNG " + RandomString.make(4);
                    String content = "<div style=\"border:1px solid black;margin-bottom:10px\">\n"
                            + "<div style=\"text-align:center; padding: 0.5rem\">\n"
                            + "    <span style=\"font-size:22px\"><b>CHI TIẾT ĐƠN HÀNG </b></span><br>\n"
                            + "    <span>Mã đơn hàng: " + o.getId() + "</span><br>\n"
                            + "    <span>Ngày đặt hàng: " + dt.format(o.getOrderDate()) + "</span><br>\n"
                            + "    <span style=\"color:green\">Trạng thái đơn hàng: ";

                    switch (o.getActive()) {
                        case 1:
                            content += "Đã đặt hàng";
                            break;
                        case 2:
                            content += "Chờ lấy hàng";
                            break;
                        case 3:
                            content += "Chờ vận chuyển";
                            break;
                        case 4:
                            content += "Đang giao";
                            break;
                        case 5:
                            content += "Đã hoàn thành (vào lúc : " + dt.format(o.getOrderReceived()) + ")";
                            break;
                    }
                    content += "</span>\n"
                            + "    <br><span>Ngày dự kiến giao hàng: " + dk.format(o.getRequiredDate()) + "<br></span>\n"
                            + "    <br>\n"
                            + "</div>\n"
                            + "</div>\n"
                            + "<div style=\"margin-top: 1rem;\">\n"
                            + "    <div style=\"border: 1px solid black\">\n"
                            + "        <div style=\"padding: 1.5rem\">\n"
                            + "            <b style=\"font-size:22px\">Địa chỉ nhận hàng</b>\n"
                            + "            <div style=\"padding-top: 1rem\">\n"
                            + "                <b> " + o.getIdShipAdress().getName() + " </b> <span> | </span><label> " + o.getIdShipAdress().getPhone() + "</label> \n"
                            + "                <p style=\"text-transform: capitalize\">" + o.getIdShipAdress().getAddress() + "</p> \n"
                            + "                <p><span style=\"text-transform: capitalize\"> " + o.getIdShipAdress().getWard() + "</span><span style=\"text-transform: capitalize\">, " + o.getIdShipAdress().getDistrict() + "</span><span>, " + o.getIdShipAdress().getCity().getName() + " </span>\n"
                            + "            </div>\n"
                            + "        </div>\n"
                            + "    </div>\n"
                            + "</div>\n"
                            + "<div>\n"
                            + "    <div style=\"border-left: 1px solid #dee2e6;border-right: 1px solid #dee2e6;border-color: black;\">\n"
                            + "        <div style=\"padding: 1rem;\">\n"
                            + "            <div style=\"display:flex;\">\n"
                            + "                <div style=\"display:flex;\">\n"
                            + "                    <div>\n"
                            + "                        <img style=\"border-radius:50%;width:60px;height:50px\" src=\"" + this.sellerService.getSeller(o.getId())[1] + "\"></a>\n"
                            + "                    </div>\n"
                            + "                    <div style=\"font-size: 24px;\">\n"
                            + "                        <label>" + this.sellerService.getSeller(o.getId())[0] + "</label></a>\n"
                            + "                    </div>\n"
                            + "                </div>\n"
                            + "                <div style=\"margin-left:auto;display: flex;\">\n"
                            + "                    <a href=\"http://localhost:8080/WebEcommerce/seller-detail/" + this.sellerService.getSeller(o.getId())[2] + "\" style=\"text-decoration: none\"><button>Xem shop</button></a>\n"
                            + "                </div>\n"
                            + "            </div>\n"
                            + "<div style=\"margin-bottom:10px\">\n"
                            + "                <div >\n"
                            + "                    <table style=\"width:100%\" >\n";
                    for (OrderDetail odetail : this.orderDetailService.getOrderDetail(o.getId())) {
                        content += "<tbody>\n"
                                + "                            <tr >\n"
                                + "                                <td><img style='width:60px; height:50px;margin-right:10px; border:1px solid' src=\"";
                        List<Image> l = (List<Image>) odetail.getIdProduct().getImageCollection();
                        content += l.get(0).getImage() + "\"</td><td ><b>" + odetail.getIdProduct().getName() + "</b></td><td><b>x " + odetail.getQuantity() + "</b></td>"
                                + "                                <td style='text-align:right'><b> <span style='text-decoration:underline'>đ</span> " + df.format(odetail.getUnitPrice()) + "</b></td></tr>"
                                + "                        </tbody>\n";
                    }
                    content += "                    </table>\n"
                            + "                </div>\n"
                            + "            </div> "
                            + "</div>\n"
                            + "    </div>\n"
                            + "</div>\n"
                            + "    <div style=\"border: 1px solid;margin-bottom:10px\" >\n"
                            + "        <table style=\"width: 100%;\">\n"
                            + "            <tbody style=\"background-color: #f8f9fa;\">\n"
                            + "               <tr style=\"text-align: right;\">\n"
                            + "                    <td style=\"border: 1px solid #dee2e6; padding: 10px\"><b>Tổng tiền hàng</b></td>\n"
                            + "                    <td style=\"border: 1px solid #dee2e6\"><span style='text-decoration:underline'>đ</span> " + df.format(o.getAmount()) + "</td>\n"
                            + "                </tr>\n"
                            + "                <tr style=\"text-align: right;\">\n"
                            + "                    <td style=\"border: 1px solid #dee2e6; padding: 10px\"><b>Phí ship</b></td>\n"
                            + "                    <td style=\"border: 1px solid #dee2e6; padding: 10px\"><span style='text-decoration:underline'>đ</span> 0</td>\n"
                            + "                </tr>\n"
                            + "                <tr style=\"text-align: right;\">\n"
                            + "                    <td style=\"border: 1px solid #dee2e6; padding: 10px\"><b>Thành tiền</b></td>\n"
                            + "                    <td style=\"border: 1px solid #dee2e6\"> <span style='text-decoration:underline'>đ</span> " + df.format(o.getAmount()) + "</td>\n"
                            + "                </tr>\n"
                            + "            </tbody>\n"
                            + "        </table>\n"
                            + "    </div>\n"
                            + "<div style=\"border: 1px solid black\">\n"
                            + "    <div style=\"text-align: right;padding:  0.5rem\">\n"
                            + "         <span style=\"font-weight: 700\">Phương thức thanh toán</span><br>\n";
                    if (o.getPaymentType() == 1) {
                        content += "<span style=\"color: #267bd1\">Thanh toán tại nhà";
                    } else if (o.getPaymentType() == 2) {
                        content += "<span style=\"color: #267bd1\">Thanh toán online";
                    }
                    content += "</span>\n"
                            + "        </div>\n"
                            + "    </div>\n";
                    mailService.sendMail(sendTo, subject, content);
                    return "redirect:/customer/list-cus-order";
                }
            }
        }

        return "product-detail";
    }

    @GetMapping("/product-detail/like")
    public String productLike(Model model, RedirectAttributes r, @RequestParam(value = "id") int id, Authentication a) {
        String errMessage = "";
        Likes like = new Likes();
        like.setIdProduct(this.productService.getProductById(id));
        like.setIdCustomer(this.userDetailsService.getAcByUsername(a.getName()).getCustomer());
        this.productService.addLike(like);
        return "redirect:/product-detail/" + id;
    }

    @GetMapping("/product-detail/unlike")
    public String productUnLike(Model model, RedirectAttributes r, @RequestParam(value = "id") int id, Authentication a) {
        String errMessage = "";
        Account ac = this.userDetailsService.getAcByUsername(a.getName());
        Likes like = this.productService.getLikeByCusId(id, ac.getCustomer().getId());
        this.productService.delete(like);
        r.addFlashAttribute("errMessage", errMessage);
        return "redirect:/product-detail/" + id;
    }

    @PostMapping("/product-detail/{productId}/report")
    public String orderDetailPost(Model model, @PathVariable(value = "productId") int productId, Authentication a, @ModelAttribute(value = "report") Report reports, RedirectAttributes r) {
        String errMessage = "";
        Account ac = this.userDetailsService.getAcByUsername(a.getName());
        Product p = this.productService.getProductById(productId);
        reports.setIdProduct(p);
        reports.setIdCustomer(ac.getCustomer());
        reports.setActive(0);
        if (this.customerService.addReport(reports) == true) {
            r.addFlashAttribute("errMessage", String.format("Đã tố cáo sản phẩm thành công"));
            return "redirect:/product-detail/" + p.getId();
        } else {
            model.addAttribute("errMessage", String.format("Có lỗi xảy ra không thể tố cáo sản phẩm!!"));
        }
        return "product-detail";
    }

    @GetMapping("/sellers")
    public String sellers(Model model, @RequestParam(required = false) Map<String, String> params, HttpSession s) {
        int page = Integer.parseInt(params.getOrDefault("page", "1"));
        String kw = params.getOrDefault("kw", "");
        model.addAttribute("sellers", this.sellerService.getSellers(kw, page));
        model.addAttribute("counterS", this.sellerService.getSellers(kw, 0).size());
        model.addAttribute("cartCounter", Utils.countCart((Map<Integer, Cart>) s.getAttribute("cartProduct")));
        model.addAttribute("count", env.getProperty("page.size"));
        model.addAttribute("kw", kw);
        model.addAttribute("productService", this.productService);
        model.addAttribute("sellerRating", new Utils());
        return "sellers";
    }

    @GetMapping("/personal")
    public String personal(Model model, Authentication authentication, HttpSession s) {
        Account ac = this.userDetailsService.getAcByUsername(authentication.getName());
        model.addAttribute("ac", ac);
        try {
            if (ac.getRole().equals(Account.SELLER)) {
                model.addAttribute("sel", this.sellerService.getSellerById(ac.getSeller().getId()));
            } else if (ac.getRole().equals(Account.CUSTOMER)) {
                model.addAttribute("cus", this.customerService.getCusById(ac.getCustomer().getId()));
            } else {
                model.addAttribute("ad", this.adminService.getAdById(ac.getAdmin().getId()));
            }
        } catch (Exception e) {
            return "redirect:/";
        }
        model.addAttribute("cartCounter", Utils.countCart((Map<Integer, Cart>) s.getAttribute("cartProduct")));
        return "personal";
    }

    @GetMapping("/registry")
    public String registry(Model model) {
        model.addAttribute("account", new Account());
        return "registry";
    }

    @PostMapping("/registry")
    public ModelAndView registry(Model model, @ModelAttribute(value = "account") Account ac,
            BindingResult br) {
        accountValidator.validate(ac, br);
        if (br.hasErrors()) {
            return new ModelAndView("registry");
        }
        if (this.userDetailsService.getAccount(ac.getUsername()).size() > 0) {
            model.addAttribute("errMessage", "Tên đăng nhập đã tồn tại!!");
        } else if (ac.getPassword().equals(ac.getConfirmPassword())) {
            if (ac.getRole().equals("ROLE_SELLER")) {
                ac.setActive(0);
            } else {
                ac.setActive(1);
            }
            if (this.userDetailsService.addAccount(ac) == true) {
                if (ac.getRole().equals("ROLE_CUSTOMER")) {
                    return new ModelAndView("redirect:/registry/cus", "id", ac.getId());
                } else {
                    return new ModelAndView("redirect:/registry/sel", "id", ac.getId());
                }
            } else {
                model.addAttribute("errMessage", "Có lỗi xảy ra không thể đăng ký tài khoản!!");
            }
        } else {
            model.addAttribute("errMessage", "Mật khẩu không khớp!!");
        }
        return new ModelAndView("registry");
    }

    @GetMapping("/change-password")
    public String changePass(Model model, Authentication a, HttpSession s) {
        model.addAttribute("ac", this.userDetailsService.getAcByUsername(a.getName()));
        model.addAttribute("cartCounter", Utils.countCart((Map<Integer, Cart>) s.getAttribute("cartProduct")));
        return "change-password";
    }

    @PostMapping("/change-password")
    public String change(Authentication a, Model model, RedirectAttributes r, @ModelAttribute(value = "ac") Account ac) {
        Account acOld = this.userDetailsService.getAcByUsername(a.getName());
        if (this.passwordEncoder.matches(ac.getPasswordOld(), acOld.getPassword())) {
            if (ac.getPasswordNew().equals(ac.getConfirmPassword())) {
                ac.setId(acOld.getId());
                if (ac.getPasswordNew().length() < 8) {
                    model.addAttribute("errMessage", "Mật khẩu cần có tối thiểu 8 ký tự!!");
                } else if (ac.getPasswordNew().length() > 25) {
                    model.addAttribute("errMessage", "Mật khẩu không được quá 25 ký tự!!");
                } else if (this.passwordEncoder.matches(ac.getPasswordNew(), acOld.getPassword())) {
                    model.addAttribute("errMessage", "Mật khẩu mới không được trùng mật khẩu cũ!!");
                } else if (this.userDetailsService.changePassword(ac) > 0) {
                    r.addFlashAttribute("errMessage", "Đổi mật khẩu thành công!!");
                    return "redirect:/";
                } else {
                    model.addAttribute("errMessage", "Có lỗi xảy ra đổi mật khẩu không thành công!!");
                }
            } else {
                model.addAttribute("errMessage", "Mật khẩu không khớp!!");
            }
        } else {
            model.addAttribute("errMessage", "Sai mật khẩu cũ!!");
        }
        return "change-password";
    }

    @GetMapping("/registry/cus")
    public String cusView(Model model, @RequestParam(name = "id", required = false) String id) {
        model.addAttribute("customer", new Customer());
        model.addAttribute("locations", this.locationService.getLos());
        model.addAttribute("ac", this.userDetailsService.getAcById(Integer.parseInt(id)));
        model.addAttribute("action", "/registry/cus");
        return "registry-cus";
    }

    @PostMapping("/registry/cus")
    public String cus(Model model, @ModelAttribute(value = "customer") Customer cus, HttpSession s) {
        cus.setIdAccount(cus.getIdAccount());
        if (this.customerService.addCus(cus) == true) {
            if (s.getAttribute("currentAdmin") == null) {
                return "redirect:/login";
            } else {
                return "redirect:/admin/account";
            }
        } else {
            model.addAttribute("errMessage", "Có lỗi xảy ra đăng ký không thành công!!");
        }
        model.addAttribute("action", "/registry/cus");
        return "registry-cus";
    }

    @GetMapping("/registry/admin")
    public String adminView(Model model, @RequestParam(name = "id", required = false) String id) {
        model.addAttribute("admin", new Admin());
        model.addAttribute("ac", this.userDetailsService.getAcById(Integer.parseInt(id)));
        return "registry-admin";
    }

    @PostMapping("/registry/admin")
    public String admin(Model model, @ModelAttribute(value = "admin") Admin ad) {
        ad.setIdAccount(ad.getIdAccount());
        if (this.adminService.addAdmin(ad) == true) {
            return "redirect:/admin/account";
        }
        return "registry-admin";
    }

    @GetMapping("/registry/sel")
    public String selView(Model model, @RequestParam(name = "id", required = false) String id) {
        model.addAttribute("seller", new Seller());
        model.addAttribute("locations", this.locationService.getLos());
        model.addAttribute("ac", this.userDetailsService.getAcById(Integer.parseInt(id)));
        model.addAttribute("action", "/registry/sel");
        return "registry-sel";
    }

    @PostMapping("/registry/sel")
    public String sel(Model model, @ModelAttribute(value = "seller") Seller sel, HttpSession s) {
        sel.setIdAccount(sel.getIdAccount());
        if (this.sellerService.addSel(sel) == true) {
            if (s.getAttribute("currentAdmin") == null) {
                return "redirect:/login";
            } else {
                return "redirect:/admin/account";
            }
        }
        model.addAttribute("action", "/registry/sel");
        return "registry-sel";
    }

    @GetMapping("/forgot-password")
    public String forgotView(Model model, HttpSession s) {
        model.addAttribute("cartCounter", Utils.countCart((Map<Integer, Cart>) s.getAttribute("cartProduct")));
        return "forgot-password";
    }
    String token = RandomString.make(8);

    @PostMapping("/forgot-password")
    public String forgotPassword(HttpServletRequest request, Model model) {
        String errMessage = "";
        String email = request.getParameter("email");
        String role = request.getParameter("role");
        if (role.equals("ROLE_CUSTOMER")) {
            try {
                Customer c = this.customerService.getCusByEmail(email);
                String content = "<h3>WebEcommerce gửi mã xác thực để cấp lại mật khẩu</h3>"
                        + "<br><br><span>Mã xác thực:<span><strong>" + token + "</strong>";
                this.mailService.sendMail(email, "Xác nhận mã xác thực", content);
                return "redirect:/confirm-token?email=" + email + "&role=" + role;
            } catch (Exception e) {
                errMessage = "Không có mail hợp lệ hoặc chọn nhầm vai trò (Khách hàng / Người bán)";
            }
        } else {
            try {
                Seller s = this.sellerService.getSelByEmail(email).get(0);
                String content = "<h3>WebEcommerce gửi mã xác thực để cấp lại mật khẩu</h3>"
                        + "<br><br><span>Mã xác thực:<span><h5> " + token + "</h5>";
                this.mailService.sendMail(email, "Xác nhận mã xác thực", content);
                return "redirect:/confirm-token?email=" + email + "&role=" + role;
            } catch (Exception e) {
                errMessage = "Không có mail hợp lệ hoặc chọn nhầm vai trò (Khách hàng / Người bán)";
            }

        }
        model.addAttribute("errMessage", errMessage);
        return "forgot-password";
    }

    @GetMapping("/confirm-token")
    public String confirmTokenView(Model model, HttpSession s) {
        model.addAttribute("cartCounter", Utils.countCart((Map<Integer, Cart>) s.getAttribute("cartProduct")));
        return "confirm-token";
    }

    @PostMapping("/confirm-token")
    public String confirmToken(Model model, HttpServletRequest request, @RequestParam(name = "email") String email, @RequestParam(name = "role") String role) {
        String errMessage = "";
        String sendtoken = request.getParameter("sendtoken");
        if (token.equals(sendtoken)) {
            return "redirect:/renew-password?email=" + email + "&role=" + role;
        } else {
            errMessage = "Sai mã xác thực. Một email mới sẽ gửi đến bạn. Yêu cầu nhập lại!";
            token = RandomString.make(8);
            String content = "<h3>WebEcommerce gửi mã xác thực để cấp lại mật khẩu</h3>"
                    + "<br><br><span>Mã xác thực:<span><h5> " + token + "</h5>";
            this.mailService.sendMail(email, "Xác nhận mã xác thực", content);
            model.addAttribute("errMessage", errMessage);
        }
        return "confirm-token";
    }

    @GetMapping("/renew-password")
    public String renewPass(Model model, HttpSession s) {
        model.addAttribute("cartCounter", Utils.countCart((Map<Integer, Cart>) s.getAttribute("cartProduct")));
        return "renew-password";
    }

    @PostMapping("/renew-password")
    public String renewPass(Model model, RedirectAttributes r,
            HttpServletRequest request, @RequestParam(name = "role") String role, @RequestParam(name = "email") String email) {
        token = RandomString.make(8);
        String passwordNew = request.getParameter("passwordNew");
        String confirmPassword = request.getParameter("confirmPassword");
        if (role.equals("ROLE_CUSTOMER")) {
            Customer cus = this.customerService.getCusByEmail(email);
            Account acOld = cus.getIdAccount();
            if (passwordNew.equals(confirmPassword)) {
                if (passwordNew.length() < 8) {
                    model.addAttribute("errMessage", "Mật khẩu cần có tối thiểu 8 ký tự!!");
                } else if (passwordNew.length() > 25) {
                    model.addAttribute("errMessage", "Mật khẩu không được quá 25 ký tự!!");
                } else if (this.userDetailsService.renewPassword(acOld, passwordNew) > 0) {
                    r.addFlashAttribute("errMessage", "Tạo mật khẩu thành công!!");
                    return "redirect:/login";
                } else {
                    model.addAttribute("errMessage", "Có lỗi xảy ra tạo mật khẩu không thành công!!");
                }
            } else {
                model.addAttribute("errMessage", "Mật khẩu không khớp!!");
            }
        } else if (role.equals("ROLE_SELLER")) {
            Seller sel = this.sellerService.getSelByEmail(email).get(0);
            Account acOld = sel.getIdAccount();
            if (passwordNew.equals(confirmPassword)) {
                if (passwordNew.length() < 8) {
                    model.addAttribute("errMessage", "Mật khẩu cần có tối thiểu 8 ký tự!!");
                } else if (passwordNew.length() > 25) {
                    model.addAttribute("errMessage", "Mật khẩu không được quá 25 ký tự!!");
                } else if (this.userDetailsService.renewPassword(acOld, passwordNew) > 0) {
                    r.addFlashAttribute("errMessage", "Tạo mật khẩu thành công!!");
                    return "redirect:/login";
                } else {
                    model.addAttribute("errMessage", "Có lỗi xảy ra tạo mật khẩu không thành công!!");
                }
            } else {
                model.addAttribute("errMessage", "Mật khẩu không khớp!!");
            }
        }
        return "renew-password";
    }

}
