package com.github.niefy.modules.wx.controller;

import com.github.niefy.common.utils.R;
import com.github.niefy.modules.wx.entity.WxUser;
import com.github.niefy.modules.wx.service.WxUserService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.RequiredArgsConstructor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

/**
 * 用户（粉丝）
 */
@RestController
@RequestMapping("/wxUser")
@RequiredArgsConstructor
@Api(tags = {"粉丝"})
public class WxUserController {
    Logger logger = LoggerFactory.getLogger(this.getClass());
    @Autowired
    WxUserService wxUserService;
//    private final WxMpService wxMpService;

    @GetMapping("/getUserInfo")
    @ApiOperation(value = "获取粉丝信息")
    public R getUserInfo(@RequestHeader String appid, @RequestHeader String openid){
        WxUser wxUser = wxUserService.getById(openid);
        return R.ok().put(wxUser);
    }
}
