package com.clothingshop.styleera.model;

import java.time.LocalDateTime;

public class Contact {
    private int id;
    private int user_id;
    private String send_name;
    private String send_email;
    private String content;
    private LocalDateTime send_at;

    public Contact() {}


    public int getId() {
        return id;
    }
    public void setId(int id) {
        this.id = id;
    }

    public int getUser_id() {
        return user_id;
    }
    public void setUser_id(int user_id) {
        this.user_id = user_id;
    }

    public String getSend_name() {
        return send_name;
    }
    public void setSend_name(String send_name) {
        this.send_name = send_name;
    }

    public String getSend_email() {
        return send_email;
    }
    public void setSend_email(String send_email) {
        this.send_email = send_email;
    }

    public String getContent() {
        return content;
    }
    public void setContent(String content) {
        this.content = content;
    }

    public LocalDateTime getSend_at() {
        return send_at;
    }
    public void setSend_at(LocalDateTime send_at) {
        this.send_at = send_at;
    }
}
