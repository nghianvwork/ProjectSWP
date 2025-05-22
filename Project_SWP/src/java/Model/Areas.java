/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

/**
 *
 * @author admin
 */
public class Areas {
    private String area_id;
    private String name;
    private String location;
    private String manager_id;
    private int  emptyCourt;

    public Areas(String area_id, String name, String location, String manager_id, int emptyCourt) {
        this.area_id = area_id;
        this.name = name;
        this.location = location;
        this.manager_id = manager_id;
        this.emptyCourt = emptyCourt;
    }

    public Areas() {
    }

    public String getArea_id() {
        return area_id;
    }

    public void setArea_id(String area_id) {
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

    public String getManager_id() {
        return manager_id;
    }

    public void setManager_id(String manager_id) {
        this.manager_id = manager_id;
    }

    public int getEmptyCourt() {
        return emptyCourt;
    }

    public void setEmptyCourt(int emptyCourt) {
        this.emptyCourt = emptyCourt;
    }

   
    
    
    
}
