package com.varentech.referralrewards.controlleradvice;

import com.varentech.referralrewards.repository.PrizeRepository;
import com.varentech.referralrewards.security.DefaultUser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ModelAttribute;

@ControllerAdvice
public class PrizeControllerAdvice {


    @Autowired
    private PrizeRepository prizeRepository;



    @ModelAttribute
    public void loadPrizesAlreadyRedeemed(@AuthenticationPrincipal DefaultUser user, ModelMap model){
        if(user != null){
            model.addAttribute("levelsRedeemed", prizeRepository.getLevelsAlreadyRedeemed(user.getId()));
        }
    }
}
