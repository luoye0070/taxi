package taxi

class Route {
    String fromStation;
    String toStation;
    String name;
    static constraints = {
        fromStation(nullable: false,blank: false,maxSize: 128);
        toStation(nullable: false,blank: false,maxSize: 128);
        name(nullable: false,blank: false,maxSize: 256);
    }
}
