package com.sec

class EasyTree {
    String text
    String attributes
    String state
    long pid
    String userRole //权限角色   通过这个角色，来确定每个节点对应的角色
    static constraints = {
        text maxSize: 30,blank: true,nullable: true
        attributes maxSize: 100,blank: true,nullable: true
        state maxSize: 20,blank: true,nullable: true
        pid blank: true,nullable: true
        userRole maxSize: 255,blank: true,nullable: true
    }
}
