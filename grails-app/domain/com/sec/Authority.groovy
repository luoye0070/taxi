package com.sec

class Authority {

    String authority
    String authChinese          //权限汉化
    int state   // 权限级别

    static mapping = {
        cache true
    }

    static constraints = {
        authority blank: false, unique: true,maxSize: 30
        authChinese nullable: true, blank: true,unique: true,maxSize: 50
    }
}
