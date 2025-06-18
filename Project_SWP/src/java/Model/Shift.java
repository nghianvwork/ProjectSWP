/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

import java.sql.Time;

/**
 *
 * @author admin
 */
public class Shift {
     private int shift_id;
    private Time start_time;
    private Time end_time;

    public Shift() {}

    public Shift(int shift_id, Time start_time, Time end_time) {
        this.shift_id = shift_id;
        this.start_time = start_time;
        this.end_time = end_time;
    }

    public int getShift_id() {
        return shift_id;
    }

    public void setShift_id(int shift_id) {
        this.shift_id = shift_id;
    }

    public Time getStart_time() {
        return start_time;
    }

    public void setStart_time(Time start_time) {
        this.start_time = start_time;
    }

    public Time getEnd_time() {
        return end_time;
    }

    public void setEnd_time(Time end_time) {
        this.end_time = end_time;
    }

    @Override
    public String toString() {
        return "Shift{" + "shift_id=" + shift_id + ", start_time=" + start_time + ", end_time=" + end_time + '}';
    }
}
