/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

import java.sql.Time;
import java.util.logging.Logger;

/**
 *
 * @author admin
 */
public class Branch {
   
    private int area_id;
    private String name;
    private String location;
    private int manager_id;
    private int  emptyCourt;
    private Time openTime;
    private Time closeTime;
    private String description;
    private String phone_branch;
    private String nameStaff;

    public Branch() {
    }

    public Branch(int area_id, String name, String location, int manager_id, int emptyCourt, Time openTime, Time closeTime, String description, String phone_branch, String nameStaff) {
        this.area_id = area_id;
        this.name = name;
        this.location = location;
        this.manager_id = manager_id;
        this.emptyCourt = emptyCourt;
        this.openTime = openTime;
        this.closeTime = closeTime;
        this.description = description;
        this.phone_branch = phone_branch;
        this.nameStaff = nameStaff;
    }

    @Override
    public String toString() {
        return "Branch{" + "area_id=" + area_id + ", name=" + name + ", location=" + location + ", manager_id=" + manager_id + ", emptyCourt=" + emptyCourt + ", openTime=" + openTime + ", closeTime=" + closeTime + ", description=" + description + ", phone_branch=" + phone_branch + ", nameStaff=" + nameStaff + '}';
    }

    public int getArea_id() {
        return area_id;
    }

    public void setArea_id(int area_id) {
        this.area_id = area_id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public int getManager_id() {
        return manager_id;
    }

    public void setManager_id(int manager_id) {
        this.manager_id = manager_id;
    }

    public int getEmptyCourt() {
        return emptyCourt;
    }

    public void setEmptyCourt(int emptyCourt) {
        this.emptyCourt = emptyCourt;
    }

    public Time getOpenTime() {
        return openTime;
    }

    public void setOpenTime(Time openTime) {
        this.openTime = openTime;
    }

    public Time getCloseTime() {
        return closeTime;
    }

    public void setCloseTime(Time closeTime) {
        this.closeTime = closeTime;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getPhone_branch() {
        return phone_branch;
    }

    public void setPhone_branch(String phone_branch) {
        this.phone_branch = phone_branch;
    }

    public String getNameStaff() {
        return nameStaff;
    }

    public void setNameStaff(String nameStaff) {
        this.nameStaff = nameStaff;
    }

    
    
    
    
    
}
