package Model;

public class Equipments {
    private int equipment_id;
    private String name;
    private double price;
    private int quantity;

    public Equipments() {}

    public Equipments(int equipment_id, String name, double price, int quantity) {
        this.equipment_id = equipment_id;
        this.name = name;
        this.price = price;
        this.quantity = quantity;
    }

    public int getEquipment_id() {
        return equipment_id;
    }

    public void setEquipment_id(int equipment_id) {
        this.equipment_id = equipment_id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }
}
