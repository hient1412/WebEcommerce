/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.tmdt.controllers;

import com.tmdt.pojos.Account;
import com.tmdt.pojos.Cart;
import com.tmdt.pojos.Customer;
import com.tmdt.pojos.ShipAdress;
import com.tmdt.service.AccountService;
import com.tmdt.service.CustomerService;
import com.tmdt.service.LocationService;
import com.tmdt.service.OrderDetailService;
import com.tmdt.service.OrderService;
import com.tmdt.service.SellerService;
import com.tmdt.utils.Utils;
import com.tmdt.validator.CustomerValidator;
import com.tmdt.validator.ShipAddressValidator;
import java.util.HashMap;
import java.util.Map;
import javax.servlet.http.HttpSession;
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
    
    @ModelAttribute
    public void common(Model model,  HttpSession s) {
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
        }
        else{
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
    public String orderDetail(Model model, @PathVariable(value = "orderId") int orderId) {
        model.addAttribute("order", this.orderService.getOrderById(orderId));
        model.addAttribute("orderDetail", this.orderDetailService);

        return "customer-order-detail";
    }
    
    @GetMapping("/order-success")
    public String orderSuccess() {
        return "order-success";
    }

}
