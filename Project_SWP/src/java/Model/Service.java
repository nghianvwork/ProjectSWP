package Model;



public class Service {

    private int service_id;

    private String name;

    private double price;

    private String description;

    private String image_url;

    private String status;

    private String service_type;



    public Service() {

    }



    public Service(int service_id, String name, double price, String description, String image_url, String status, String service_type) {

        this.service_id = service_id;

        this.name = name;

        this.price = price;

        this.description = description;

        this.image_url = image_url;

        this.status = status;

        this.service_type = service_type;

    }



    public int getService_id() {

        return service_id;

    }



    public void setService_id(int service_id) {

        this.service_id = service_id;

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



    public String getDescription() {

        return description;

    }



    public void setDescription(String description) {

        this.description = description;

    }



    public String getImage_url() {

        return image_url;

    }



    public void setImage_url(String image_url) {

        this.image_url = image_url;

    }



    public String getStatus() {

        return status;

    }



    public void setStatus(String status) {

        this.status = status;

    }



    public String getService_type() {

        return service_type;

    }



    public void setService_type(String service_type) {

        this.service_type = service_type;

    }



    

    

}