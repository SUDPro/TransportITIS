package ru.itis.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.boot.autoconfigure.condition.ConditionalOnExpression;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.*;
import ru.itis.entities.StudentApplication;
import ru.itis.entities.User;
import ru.itis.forms.TripForm;
import ru.itis.security.UserDetailsImpl;
import ru.itis.services.TripApplicationsService;
import ru.itis.services.TripService;
import ru.itis.services.UserService;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

@Controller
public class TripController {

    @Autowired
    UserService userService;

    @Autowired
    TripService tripService;

    @Autowired
    TripApplicationsService service;

    @GetMapping("/new_trip")
    public String getTripPage() {
        return "newTrip";
    }

    @PostMapping("/new_trip")
    public String addTrip(@Valid TripForm tripForm, BindingResult result, ModelMap modelMap) {
        System.out.println("add trip method");
        if (result.hasErrors()) {
            List<String> errors = result
                    .getFieldErrors()
                    .stream()
                    .map(error -> error.getDefaultMessage()).collect(Collectors.toList());
            modelMap.addAttribute("errors", errors);
            return "newTrip";
        }
        tripService.save(tripForm);
        return "redirect:/trips";
    }

    @GetMapping("/trips")
    public String getTripsPage(ModelMap modelMap, Authentication auth, HttpServletRequest request) {
        modelMap.addAttribute("trips", tripService.showOnlyOpenTrips());
        if (auth != null && auth.isAuthenticated()) {
            modelMap.addAttribute("user", ((UserDetailsImpl) (auth.getPrincipal())).getUser());
        }
        return "TripList";
    }

    @GetMapping("/trip/{id}")
    public String getOneTrip(ModelMap modelMap, @PathVariable Long id, Authentication auth) {
        modelMap.addAttribute("user", ((UserDetailsImpl) (auth.getPrincipal())).getUser());
        modelMap.addAttribute("users", service.findAllByTripId(id));
        modelMap.addAttribute("trip", tripService.findById(id));
        return "oneTrip";
    }

    @PostMapping(value = "/trip/{id}", params = {"apply"})
    public String applyAdd(@PathVariable Long id, Authentication auth, ModelMap modelMap) {
        StudentApplication application = StudentApplication.builder()
                .trip(tripService.findById(id))
                .user(((UserDetailsImpl) (auth.getPrincipal())).getUser())
                .build();
        if (service.save(application) != null) {
            modelMap.addAttribute("user", ((UserDetailsImpl) (auth.getPrincipal())).getUser());
            modelMap.addAttribute("users", service.findAllByTripId(id));
            modelMap.addAttribute("trip", tripService.findById(id));
            modelMap.addAttribute("error", service.save(application));
            return "oneTrip";
        }

        return "redirect:/trip/" + id;
    }

    @PostMapping(value = "/trip/{id}", params = {"decline"})
    public String applyDelete(@PathVariable Long id, Authentication auth, ModelMap modelMap) {
        StudentApplication application = StudentApplication.builder()
                .trip(tripService.findById(id))
                .user(((UserDetailsImpl) (auth.getPrincipal())).getUser())
                .build();
        if (!service.delete(application)) {
            modelMap.addAttribute("user", ((UserDetailsImpl) (auth.getPrincipal())).getUser());
            modelMap.addAttribute("users", service.findAllByTripId(id));
            modelMap.addAttribute("trip", tripService.findById(id));
            modelMap.addAttribute("error", "Вы уже отказались от поездки!");
            return "oneTrip";
        }

        return "redirect:/trip/" + id;
    }

    @InitBinder
    public void initBinder(WebDataBinder wb) {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        sdf.setLenient(true);
        wb.registerCustomEditor(Date.class, new CustomDateEditor(sdf, true));
    }
}
