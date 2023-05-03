/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.tmdt.controllers;

import com.tmdt.pojos.Account;
import com.tmdt.pojos.Cancel;
import com.tmdt.pojos.Cart;
import com.tmdt.pojos.Customer;
import com.tmdt.pojos.Image;
import com.tmdt.pojos.Likes;
import com.tmdt.pojos.OrderDetail;
import com.tmdt.pojos.Orders;
import com.tmdt.pojos.Product;
import com.tmdt.pojos.SellerOrder;
import com.tmdt.pojos.ShipAdress;
import com.tmdt.service.AccountService;
import com.tmdt.service.CustomerService;
import com.tmdt.service.LocationService;
import com.tmdt.service.MailService;
import com.tmdt.service.OrderDetailService;
import com.tmdt.service.OrderService;
import com.tmdt.service.ProductService;
import com.tmdt.service.SellerService;
import com.tmdt.utils.Utils;
import com.tmdt.validator.CustomerValidator;
import com.tmdt.validator.ShipAddressValidator;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import net.bytebuddy.utility.RandomString;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.env.Environment;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

/**
 *
 * @author DELL
 */
@Controller
@RequestMapping("/customer")
public class CustomerController {

    @Autowired
    private ProductService productService;
    @Autowired
    private AccountService accountService;
    @Autowired
    private LocationService locationService;
    @Autowired
    private CustomerService customerService;
    @Autowired
    private SellerService sellerService;
    @Autowired
    private CustomerValidator customerValidator;
    @Autowired
    private ShipAddressValidator shipAddressValidator;
    @Autowired
    private Environment env;
    @Autowired
    private OrderService orderService;
    @Autowired
    private OrderDetailService orderDetailService;
    @Autowired
    private MailService mailService;

    @ModelAttribute
    public void common(Model model, HttpSession s) {
        model.addAttribute("cartCounter", Utils.countCart((Map<Integer, Cart>) s.getAttribute("cartProduct")));
    }

    @GetMapping("/edit")
    public String customerEditView(Model model, Authentication authentication, HttpSession s) {
        Account ac = this.accountService.getAcByUsername(authentication.getName());
        model.addAttribute("locations", this.locationService.getLos());
        model.addAttribute("customer", ac.getCustomer());
        return "customer-edit";
    }

    @PostMapping("/edit")
    public String customerEdit(Model model, @ModelAttribute(value = "customer") Customer customer, RedirectAttributes r,
            BindingResult br) {
        model.addAttribute("locations", this.locationService.getLos());
        Customer cusOld = this.customerService.getCusById(customer.getId());
        customerValidator.validate(customer, br);
        if (br.hasErrors()) {
            return "customer-edit";
        } else {
            if (customer.getFile().isEmpty()) {
                customer.setAvatar(cusOld.getAvatar());
            }
            if (!cusOld.getEmail().equals(customer.getEmail())) {
                if (this.customerService.getCusEmail(customer.getEmail()).size() > 0) {
                    model.addAttribute("errMessage", "Email đã tồn tại!!");
                } else {
                    if (this.customerService.updateCustomer(customer) == true) {
                        r.addFlashAttribute("errMessage", "Cập nhật thông tin thành công");
                        return "redirect:/personal";
                    } else {
                        model.addAttribute("errMessage", "Có lỗi xảy ra không thể cập nhật thông tin");
                    }
                }
            } else if (!cusOld.getPhone().equals(customer.getPhone())) {
                if (this.customerService.getCusPhone(customer.getPhone()).size() > 0) {
                    model.addAttribute("errMessage", "Số điện thoại đã tồn tại!!");
                } else {
                    if (this.customerService.updateCustomer(customer) == true) {
                        r.addFlashAttribute("errMessage", "Cập nhật thông tin thành công");
                        return "redirect:/personal";
                    } else {
                        model.addAttribute("errMessage", "Có lỗi xảy ra không thể cập nhật thông tin");
                    }
                }
            } else if (this.customerService.updateCustomer(customer) == true) {
                r.addFlashAttribute("errMessage", "Cập nhật thông tin thành công");
                return "redirect:/personal";
            } else {
                model.addAttribute("errMessage", "Có lỗi xảy ra không thể cập nhật thông tin");
            }
        }
        return "customer-edit";
    }

    @GetMapping("/list-cus-order")
    public String listView(Model model, @RequestParam(required = false) Map<String, String> params, Authentication a, HttpSession s) {
        int page = Integer.parseInt(params.getOrDefault("page", "1"));
        Account ac = this.accountService.getAcByUsername(a.getName());
        int id = ac.getCustomer().getId();
        try {
            Map<String, String> pre = new HashMap<>();
            pre.put("idOrder", params.getOrDefault("idOrder", ""));
            pre.put("namePro", params.getOrDefault("namePro", ""));
            pre.put("nameSel", params.getOrDefault("nameSel", ""));
            pre.put("active", params.getOrDefault("active", ""));
            model.addAttribute("orderDetail", this.orderDetailService);
            model.addAttribute("seller", this.sellerService);
            model.addAttribute("orders", this.orderService.getOrderByCusId(pre, id, page));
            model.addAttribute("counterS", this.orderService.getOrderByCusId(pre, id, 0).size());
            model.addAttribute("count", env.getProperty("page.size"));
            model.addAttribute("pUsdPriceOfProduct", new Utils());
        } catch (NumberFormatException e) {
            model.addAttribute("errMessage", "Không có đơn hàng");
        }
        return "list-cus-order";
    }

    @GetMapping("/ship-address")
    public String shipAddress(Model model, Authentication a, HttpSession s) {
        Account ac = this.accountService.getAcByUsername(a.getName());
        model.addAttribute("listShip", this.customerService.getShipAdress(ac.getCustomer().getId()).size());
        model.addAttribute("customerId", ac.getCustomer().getId());
        return "ship-address";
    }

    @GetMapping("/ship-address-add")
    public String shipAddressAdd(Model model) {
        model.addAttribute("ship", new ShipAdress());
        model.addAttribute("locations", this.locationService.getLos());
        return "ship-address-add";
    }

    @PostMapping("/ship-address-add")
    public String shipAddressAdd(Model model, @ModelAttribute(value = "ship") ShipAdress shipAddress, Authentication a, RedirectAttributes r,
            BindingResult br) {
        model.addAttribute("locations", this.locationService.getLos());
        shipAddress.setIdCustomer(this.accountService.getAcByUsername(a.getName()).getCustomer());
        int counter = this.customerService.getShipAdress(shipAddress.getIdCustomer().getId()).size();
        if (shipAddress.getPriority().equals(1)) {
            if (this.customerService.getShipAdressPriority(1, shipAddress.getIdCustomer().getId()).size() == 1) {
                ShipAdress ship = this.customerService.getShipAdressPriority(1, shipAddress.getIdCustomer().getId()).get(0);
                ship.setPriority(counter + 1);
                this.customerService.updateS(ship);
            }
        } else {
            shipAddress.setPriority(counter + 1);
        }
        shipAddressValidator.validate(shipAddress, br);
        if (br.hasErrors()) {
            return "ship-address-add";
        } else if (this.customerService.addShip(shipAddress) == true) {
            return "redirect:/customer/ship-address";
        }
        return "ship-address-add";
    }

    @GetMapping("/ship-address-edit")
    public String updateShip(Model model, @RequestParam(name = "id") int id) {
        model.addAttribute("locations", this.locationService.getLos());
        ShipAdress sa = this.customerService.getShipById(id);
        model.addAttribute("sa", sa);
        return "ship-address-edit";
    }

    @PostMapping("/ship-address-edit")
    public String updateAccount(Model model, @ModelAttribute(value = "sa") ShipAdress sa, Authentication a,
            RedirectAttributes r, BindingResult br) {
        model.addAttribute("locations", this.locationService.getLos());
        sa.setIdCustomer(this.accountService.getAcByUsername(a.getName()).getCustomer());
        shipAddressValidator.validate(sa, br);
        if (br.hasErrors()) {
            return "ship-address-edit";
        } else {
            if (this.customerService.updateS(sa) == true) {
                r.addFlashAttribute("errMessage", String.format("Chỉnh sửa thành công địa chỉ: '%s'", sa.getAddress()));
                return "redirect:/customer/ship-address";
            } else {
                model.addAttribute("errMessage", "Có lỗi xảy ra không thể chỉnh sửa địa chỉ");
            }
        }
        return "ship-address-edit";
    }

    @GetMapping("/ship-address-delete")
    public String shipAddressdelete(Model model, @RequestParam(name = "id") int id,
            RedirectAttributes r) {
        String errMessage = "";
        ShipAdress sa = this.customerService.getShipById(id);
        if (sa.getPriority() != 1) {
            if (this.customerService.deleteS(sa) == true) {
                errMessage = String.format("Đã xóa thành công địa chỉ: '%s'", sa.getAddress() + " " + sa.getCity().getName());
            } else {
                errMessage = String.format("Có lỗi xảy ra không thể xóa địa chỉ: '%s'", sa.getAddress() + " " + sa.getCity().getName());
            }
        } else {
            errMessage = String.format("Không thể xóa địa chỉ mặc định");
        }
        r.addFlashAttribute("errMessage", errMessage);
        return "redirect:/customer/ship-address";
    }

    @GetMapping("/ship-address-setdefault")
    public String shipAddressSet(Model model, @RequestParam(name = "id") int id,
            RedirectAttributes r) {
        String errMessage = "";
        ShipAdress sa = this.customerService.getShipById(id);
        if (sa.getPriority() != 1) {
            int counter = this.customerService.getShipAdress(sa.getIdCustomer().getId()).size();
            if (this.customerService.getShipAdressPriority(1, sa.getIdCustomer().getId()).size() == 1) {
                ShipAdress ship = this.customerService.getShipAdressPriority(1, sa.getIdCustomer().getId()).get(0);
                ship.setPriority(counter + 1);
                this.customerService.updateS(ship);
            }
            if (this.customerService.setdefaultShip(sa) == 1) {
                if (sa.getPriority() == 1) {
                    errMessage = String.format("Đặt làm địa chỉ mặc định thành công");
                } else {
                    errMessage = String.format("Có lỗi xảy ra khi đặt làm địa chỉ mặc định");
                }
            }
        } else {
            errMessage = String.format("Địa chỉ này đã là địa chỉ mặc định");
        }
        r.addFlashAttribute("errMessage", errMessage);
        return "redirect:/customer/ship-address";
    }

    @GetMapping("/order-detail/{orderId}")
    public String orderDetail(Model model, @PathVariable(value = "orderId") int orderId, HttpSession s) {
        if (this.orderService.getOrderId(orderId).size() > 0) {
            model.addAttribute("order", this.orderService.getOrderById(orderId));
            model.addAttribute("orderDetail", this.orderDetailService);
            model.addAttribute("seller", this.sellerService);
            model.addAttribute("cancel", new Cancel());
            model.addAttribute("pUsdPriceOfProduct", new Utils());
            model.addAttribute("shipAddress", this.customerService);
        } else {
            return "redirect:/customer/list-cus-order";
        }
        return "customer-order-detail";
    }

    @PostMapping("/order-detail/{orderId}")
    public String orderDetailPost(Model model, @PathVariable(value = "orderId") int orderId, Authentication a, @ModelAttribute(value = "cancel") Cancel cancels, RedirectAttributes r) {
        String errMessage = "";
        Orders o = this.orderService.getOrderById(orderId);
        o.setActive(0);
        Account ac = this.accountService.getAcByUsername(a.getName());
        cancels.setIdOrder(o);
        cancels.setIdAccount(ac);
        if (this.orderService.addCancel(cancels) == true) {
            if (this.orderService.updateActive(o) == 1) {
                SimpleDateFormat dt = new SimpleDateFormat("dd/MM/yyyy hh:mm:ss");
                DecimalFormat df = new DecimalFormat("###,###,###,###");
                r.addFlashAttribute("errMessage", String.format("Đã hủy thành công đơn hàng!!"));
                String sendTo = ac.getCustomer().getEmail();
                String subject = "WEBECOMMERCE THÔNG BÁO - HỦY ĐƠN HÀNG THÀNH CÔNG " + RandomString.make(4);
                String content = "<div style=\"text-align:center;\">\n"
                        + "    <div style=\"border: 1px solid;padding: 10px;margin: 10px\">\n"
                        + "        <h3 style=\"color:red\">Đã hủy đơn hàng</h3>\n"
                        + "        <p>vào lúc " + dt.format(cancels.getCancelDate()) + "</p>\n"
                        + "    </div>\n"
                        + "</div>\n"
                        + "\n"
                        + "<div >"
                        + "    <div style=\"border: 1px solid;margin: 10px\">\n"
                        + "        <div style=\"padding:10px\">\n"
                        + "            <div style=\"display: flex;\">"
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
                        + "            </div>"
                        + "<div style=\"margin-bottom:10px\">\n"
                        + "                <div >\n"
                        + "                    <table style=\"width:100%\" >\n";
                for (OrderDetail od : this.orderDetailService.getOrderDetail(o.getId())) {
                    content += "<tbody>\n"
                            + "                            <tr >\n"
                            + "                                <td><img style='width:60px; height:50px;margin-right:10px; border:1px solid' src=\"";
                    List<Image> l = (List<Image>) od.getIdProduct().getImageCollection();
                    content += l.get(0).getImage() + "\"</td><td ><b>" + od.getIdProduct().getName() + "</b></td><td><b>x " + od.getQuantity() + "</b></td>"
                            + "                                <td style='text-align:right'><b> <span style='text-decoration:underline'>đ</span> " + df.format(od.getUnitPrice()) + "</b></td></tr>"
                            + "                        </tbody>\n";
                }
                content += "                    </table>\n"
                        + "                </div>\n"
                        + "            </div> "
                        + "</div>\n"
                        + "    </div>\n"
                        + "</div>\n"
                        + "<div style=\"margin-bottom:10px\">\n"
                        + "    <div style=\"border: 1px solid;margin: 10px;\" >\n"
                        + "        <table style=\"width: 100%;\">\n"
                        + "            <tbody style=\"background-color: #f8f9fa;\">\n"
                        + "               <tr style=\"text-align: right;\">\n"
                        + "                    <td style=\"border: 1px solid #dee2e6; padding: 10px\"><b>Yêu cầu bởi</b></td>\n"
                        + "                    <td style=\"border: 1px solid #dee2e6\">\n";
                if (cancels.getIdAccount().getRole().equals("ROLE_CUSTOMER")) {
                    content += "<span>Người mua</span>";
                } else if (cancels.getIdAccount().getRole().equals("ROLE_SELLER")) {
                    content += "<span>Người bán</span>";
                } else {
                    content += "<span>Admin</span>";
                }

                content += "</td>\n"
                        + "                </tr>\n"
                        + "                <tr style=\"text-align: right;\">\n"
                        + "                    <td style=\"border: 1px solid #dee2e6; padding: 10px\"><b>Yêu cầu vào</b></td>\n"
                        + "                    <td style=\"border: 1px solid #dee2e6; padding: 10px\">" + dt.format(cancels.getCancelDate()) + "</td>\n"
                        + "                </tr>\n"
                        + "                <tr style=\"text-align: right;\">\n"
                        + "                    <td style=\"border: 1px solid #dee2e6; padding: 10px\"><b>Lý do</b></td>\n"
                        + "                    <td style=\"border: 1px solid #dee2e6\"> <span>" + cancels.getCancelDescription() + "</span> </td>\n"
                        + "                </tr>\n"
                        + "                <tr style=\"text-align: right;\">\n"
                        + "                    <td style=\"border: 1px solid #dee2e6; padding: 10px\"><b>Phương thức thanh toán</b></td>\n"
                        + "                    <td style=\"border: 1px solid #dee2e6; padding: 10px\"> \n";

                if (o.getPaymentType() == 1) {
                    content += "<span>Thanh toán tại nhà</span>";
                } else if (o.getPaymentType() == 2) {
                    content += "<span>Thanh toán online</span>";
                }
                content += "                    </td>\n"
                        + "                </tr>\n"
                        + "            </tbody>\n"
                        + "        </table>\n"
                        + "    </div>\n"
                        + "</div>";
                mailService.sendMail(sendTo, subject, content);
                return "redirect:/customer/cancel/" + o.getId();
            } else {
                model.addAttribute("errMessage", String.format("Có lỗi xảy ra không thể hủy đơn hàng"));
            }
        } else {
            model.addAttribute("errMessage", String.format("Có lỗi xảy ra không thể hủy đơn hàng"));
        }

        return "customer-order-detail";
    }

    @GetMapping("/order-success")
    public String orderSuccess() {
        return "order-success";
    }

    @GetMapping("/cancel/{orderId}")
    public String cancel(Model model, @PathVariable(value = "orderId") int orderId) {
        model.addAttribute("orderDetail", this.orderDetailService);
        model.addAttribute("seller", this.sellerService);
        model.addAttribute("order", this.orderService.getOrderById(orderId));
        model.addAttribute("cancel", this.orderService.getCancel(this.orderService.getOrderById(orderId)));
        model.addAttribute("pUsdPriceOfProduct", new Utils());
        return "cancel";
    }

    @GetMapping("/order-detail/{orderId}/confirm")
    public String confirm(Model model, @PathVariable(value = "orderId") int orderId, RedirectAttributes r) {
        Orders o = this.orderService.getOrderById(orderId);
        o.setActive(5);
        if (this.orderService.updateActiveAndReceived(o) == 1) {
            r.addFlashAttribute("errMessage", String.format("Xác nhận đã nhận hàng thành công"));
            return "redirect:/customer/order-detail/" + o.getId();
        } else {
            r.addFlashAttribute("errMessage", String.format("Có lỗi xảy ra không thể xác nhận đã nhận hàng"));
        }
        return "redirect:/customer/order-detail/" + o.getId();
    }

    @GetMapping("/order-detail/{orderId}/buyAgain")
    public String buyAgain(Model model, @PathVariable(value = "orderId") int orderId, RedirectAttributes r) {
        Orders o = this.orderService.getOrderById(orderId);
        Orders o1 = new Orders();
        o1.setActive(1);
        o1.setIdCustomer(o.getIdCustomer());
        o1.setOrderDate(new Date());
        Date requiredDate = new Date();
        requiredDate.setDate(requiredDate.getDate() + 7);
        o1.setRequiredDate(requiredDate);
        o1.setAmount(o.getAmount());
        o1.setShipFee(0);
        o1.setPaymentType(1);
        o1.setIsPayment(0);
        o1.setIdShipAdress(o.getIdShipAdress());
        if (this.orderService.addOrder(o1) == true) {
            List<OrderDetail> od = this.orderDetailService.getOrderDetail(o.getId());
            for (OrderDetail i : od) {
                OrderDetail od11 = new OrderDetail();
                od11.setUnitPrice(i.getUnitPrice());
                od11.setQuantity(i.getQuantity());
                od11.setDiscount(0);
                od11.setIdProduct(i.getIdProduct());
                od11.setIdOrder(o1);
                this.orderDetailService.addOrderD(od11);
            }
            Product p = this.productService.getProductById(od.get(0).getIdProduct().getId());
            SellerOrder so = new SellerOrder();
            so.setIdOrder(o1);
            so.setIdSeller(p.getIdSeller());
            if (this.orderDetailService.addSellerOrder(so) == true) {
                r.addFlashAttribute("errMessage", "Mua thành công!!");
                SimpleDateFormat dt = new SimpleDateFormat("dd/MM/yyyy hh:mm:ss");
                SimpleDateFormat dk = new SimpleDateFormat("dd/MM/yyyy");
                DecimalFormat df = new DecimalFormat("###,###,###,###");

                String sendTo = o1.getIdCustomer().getEmail();
                String subject = "WEBECOMMERCE THÔNG BÁO - ĐẶT HÀNG THÀNH CÔNG " + RandomString.make(4);
                String content = "<div style=\"border:1px solid black;margin-bottom:10px\">\n"
                        + "<div style=\"text-align:center; padding: 0.5rem\">\n"
                        + "    <span style=\"font-size:22px\"><b>CHI TIẾT ĐƠN HÀNG </b></span><br>\n"
                        + "    <span>Mã đơn hàng: " + o1.getId() + "</span><br>\n"
                        + "    <span>Ngày đặt hàng: " + dt.format(o1.getOrderDate()) + "</span><br>\n"
                        + "    <span style=\"color:green\">Trạng thái đơn hàng: ";

                switch (o1.getActive()) {
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
                        content += "Đã hoàn thành (vào lúc : " + dt.format(o1.getOrderReceived()) + ")";
                        break;
                }
                content += "</span>\n"
                        + "    <br><span>Ngày dự kiến giao hàng: " + dk.format(o1.getRequiredDate()) + "<br></span>\n"
                        + "    <br>\n"
                        + "</div>\n"
                        + "</div>\n"
                        + "<div style=\"margin-top: 1rem;\">\n"
                        + "    <div style=\"border: 1px solid black\">\n"
                        + "        <div style=\"padding: 1.5rem\">\n"
                        + "            <b style=\"font-size:22px\">Địa chỉ nhận hàng</b>\n"
                        + "            <div style=\"padding-top: 1rem\">\n"
                        + "                <b> " + o1.getIdShipAdress().getName() + " </b> <span> | </span><label> " + o1.getIdShipAdress().getPhone() + "</label> \n"
                        + "                <p style=\"text-transform: capitalize\">" + o1.getIdShipAdress().getAddress() + "</p> \n"
                        + "                <p><span style=\"text-transform: capitalize\"> " + o1.getIdShipAdress().getWard() + "</span><span style=\"text-transform: capitalize\">, " + o1.getIdShipAdress().getDistrict() + "</span><span>, " + o1.getIdShipAdress().getCity().getName() + " </span>\n"
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
                        + "                        <img style=\"border-radius:50%;width:60px;height:50px\" src=\"" + this.sellerService.getSeller(o1.getId())[1] + "\"></a>\n"
                        + "                    </div>\n"
                        + "                    <div style=\"font-size: 24px;\">\n"
                        + "                        <label>" + this.sellerService.getSeller(o1.getId())[0] + "</label></a>\n"
                        + "                    </div>\n"
                        + "                </div>\n"
                        + "                <div style=\"margin-left:auto;display: flex;\">\n"
                        + "                    <a href=\"http://localhost:8080/WebEcommerce/seller-detail/" + this.sellerService.getSeller(o1.getId())[2] + "\" style=\"text-decoration: none\"><button>Xem shop</button></a>\n"
                        + "                </div>\n"
                        + "            </div>\n"
                        + "<div style=\"margin-bottom:10px\">\n"
                        + "                <div >\n"
                        + "                    <table style=\"width:100%\" >\n";
                for (OrderDetail odetail : this.orderDetailService.getOrderDetail(o1.getId())) {
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
                        + "                    <td style=\"border: 1px solid #dee2e6\"><span style='text-decoration:underline'>đ</span> " + df.format(o1.getAmount()) + "</td>\n"
                        + "                </tr>\n"
                        + "                <tr style=\"text-align: right;\">\n"
                        + "                    <td style=\"border: 1px solid #dee2e6; padding: 10px\"><b>Phí ship</b></td>\n"
                        + "                    <td style=\"border: 1px solid #dee2e6; padding: 10px\"><span style='text-decoration:underline'>đ</span> 0</td>\n"
                        + "                </tr>\n"
                        + "                <tr style=\"text-align: right;\">\n"
                        + "                    <td style=\"border: 1px solid #dee2e6; padding: 10px\"><b>Thành tiền</b></td>\n"
                        + "                    <td style=\"border: 1px solid #dee2e6\"> <span style='text-decoration:underline'>đ</span> " + df.format(o1.getAmount()) + "</td>\n"
                        + "                </tr>\n"
                        + "            </tbody>\n"
                        + "        </table>\n"
                        + "    </div>\n"
                        + "<div style=\"border: 1px solid black\">\n"
                        + "    <div style=\"text-align: right;padding:  0.5rem\">\n"
                        + "         <span style=\"font-weight: 700\">Phương thức thanh toán</span><br>\n";
                if (o1.getPaymentType() == 1) {
                    content += "<span style=\"color: #267bd1\">Thanh toán tại nhà";
                } else if (o1.getPaymentType() == 2) {
                    content += "<span style=\"color: #267bd1\">Thanh toán online";
                }
                content += "</span>\n"
                        + "        </div>\n"
                        + "    </div>\n";
                mailService.sendMail(sendTo, subject, content);
                return "redirect:/customer/list-cus-order";
            }
        } else {
            r.addFlashAttribute("errMessage", String.format("Có lỗi xảy ra không thể mua lại đơn hàng"));
        }

        return "redirect:/customer/list-cus-order";
    }

    @GetMapping("/checkout")
    public String checkout(Model model, Authentication authentication,
            HttpSession session
    ) {
        Account ac = this.accountService.getAcByUsername(authentication.getName());
        model.addAttribute("shipAddress", this.customerService.findShipPriority(ac.getCustomer()));
        model.addAttribute("ac", ac);
        model.addAttribute("pUsdPriceOfProduct", new Utils());
        try {
            model.addAttribute("cus", this.customerService.getCusById(ac.getCustomer().getId()));
        } catch (Exception e) {
            return "redirect:/";
        }

        model.addAttribute("cartCounter", Utils.countCart((Map<Integer, Cart>) session.getAttribute("cartProduct")));
        Map<Integer, Cart> cartProduct = (Map<Integer, Cart>) session.getAttribute("cartProduct");

        if (cartProduct != null) {
            model.addAttribute("cartProducts", cartProduct.values());
        } else {
            model.addAttribute("cartProducts", null);
        }

        model.addAttribute("cartAmount", Utils.cartAmount(cartProduct));
        return "checkout";
    }

    @GetMapping("/liked")
    public String liked(Model model, Authentication a,
            HttpSession s
    ) {
        Account ac = this.accountService.getAcByUsername(a.getName());
        if (ac.getRole().equals(Account.CUSTOMER)) {
            model.addAttribute("listLike", this.customerService.getLikeByCusId(ac.getCustomer().getId()));
            model.addAttribute("productService", this.productService);
            model.addAttribute("pUsdPriceOfProduct", new Utils());
            model.addAttribute("counterS", this.customerService.getLikeByCusId(ac.getCustomer().getId()).size());
            model.addAttribute("count", env.getProperty("page.size"));
        }
        return "liked";
    }

    @GetMapping("/liked/like")
    public String productLike(Model model, RedirectAttributes r,
            @RequestParam(value = "id") int id, Authentication a
    ) {
        String errMessage = "";
        Likes like = new Likes();
        like.setIdProduct(this.productService.getProductById(id));
        like.setIdCustomer(this.accountService.getAcByUsername(a.getName()).getCustomer());
        this.productService.addLike(like);
        return "redirect:/customer/liked";
    }

    @GetMapping("/liked/unlike")
    public String productUnLike(Model model, RedirectAttributes r,
            @RequestParam(value = "id") int id, Authentication a
    ) {
        String errMessage = "";
        Account ac = this.accountService.getAcByUsername(a.getName());
        Likes like = this.productService.getLikeByCusId(id, ac.getCustomer().getId());
        this.productService.delete(like);
        r.addFlashAttribute("errMessage", errMessage);
        return "redirect:/customer/liked";
    }

}
