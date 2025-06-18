/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

import java.sql.Time;
import java.time.LocalDate;

/**
 *
 * @author admin
 */
public class Bookings {
    private int booking_id;
    private int user_id;
    private int court_id;
    private LocalDate date;
    private Time start_time;
    private Time end_time;
    private String status;
    private int rating;
    private double total_price;

    @Override
    public String toString() {
        return "Bookings{" + "booking_id=" + booking_id + ", user_id=" + user_id + ", court_id=" + court_id + ", date=" + date + ", start_time=" + start_time + ", end_time=" + end_time + ", status=" + status + ", rating=" + rating + '}';
    }

    public Bookings() {
    }

    public Bookings(int booking_id, int user_id, int court_id, LocalDate date, Time start_time, Time end_time, String status, int rating, double total_price) {
        this.booking_id = booking_id;
        this.user_id = user_id;
        this.court_id = court_id;
        this.date = date;
        this.start_time = start_time;
        this.end_time = end_time;
        this.status = status;
        this.rating = rating;
        this.total_price = total_price;
    }

    public int getBooking_id() {
        return booking_id;
    }

    public void setBooking_id(int booking_id) {
        this.booking_id = booking_id;
    }

    public int getUser_id() {
        return user_id;
    }

    public void setUser_id(int user_id) {
        this.user_id = user_id;
    }

    public int getCourt_id() {
        return court_id;
    }

    public void setCourt_id(int court_id) {
        this.court_id = court_id;
    }

    public LocalDate getDate() {
        return date;
    }

    public void setDate(LocalDate date) {
        this.date = date;
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

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public double getTotal_price() {
        return total_price;
    }

    public void setTotal_price(double total_price) {
        this.total_price = total_price;
    }

    
    
    public int getRating() {
        return rating;
    }

    public void setRating(int rating) {
        this.rating = rating;
    }

}
