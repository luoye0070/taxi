package taxi

class Route {
    String fromStation;
    String toStation;
    static constraints = {
        fromStation(nullable: false,blank: false,maxSize: 128);
        toStation(nullable: false,blank: false,maxSize: 128);
    }
}
