package com.github.niefy.modules.wx.port;

import com.google.gson.reflect.TypeToken;
import lombok.Data;

import java.io.Serializable;
import java.util.List;

@Data
public class WxUserTag implements Serializable {
    private static final long serialVersionUID = -7722428695667031252L;

    /**
     * 标签id，由分配.
     */
    private Long id;

    /**
     * 标签名，UTF8编码.
     */
    private String name;

    /**
     * 此标签下粉丝数.
     */
    private Integer count;

    public static WxUserTag fromJson(String json) {
        return WxMpGsonBuilder.create().fromJson(
                GsonParser.parse(json).get("tag"),
                WxUserTag.class);
    }

    public static List<WxUserTag> listFromJson(String json) {
        return WxMpGsonBuilder.create().fromJson(
                GsonParser.parse(json).get("tags"),
                new TypeToken<List<WxUserTag>>() {
                }.getType());
    }

    public String toJson() {
        return WxMpGsonBuilder.create().toJson(this);
    }

    @Override
    public String toString() {
        return this.toJson();
    }
}
