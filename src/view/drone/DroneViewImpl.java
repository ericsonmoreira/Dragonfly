package view.drone;


import controller.LoggerController;
import javafx.scene.Node;
import javafx.scene.control.Label;
import javafx.scene.image.Image;
import javafx.scene.image.ImageView;
import javafx.scene.paint.Color;
import javafx.scene.shape.Rectangle;
import javafx.scene.text.TextAlignment;
import model.drone.Drone;
import view.CellView;
import view.res.EnvironmentView;


public class DroneViewImpl extends DroneView {

    private final EnvironmentView environmentView;
    private final String droneLabel;

    private CellView currentCellView;
  /*  private Drone drone;*/
    public static double WIDTH = 24;
    public static double HEIGHT = 24;


    ImageView imageViewBadConnection = new ImageView(new Image("/view/res/lostConnection.png"));
    ImageView imageViewDrone = new ImageView( new Image("/view/res/notSelectedDrone.png"));
    private LoggerController loggerController = LoggerController.getInstance();
    private Rectangle selectedRetangle;
    // public LoggerController loggerController = LoggerController.getInstance();


    public DroneViewImpl(String uniqueID, String droneLabel, CellView currentCellView) {
        this.uniqueID = uniqueID;
        this.droneLabel = droneLabel;

        imageViewBadConnection.setVisible(false);



        environmentView = currentCellView.getEnvironmentView();
        this.currentCellView = currentCellView;


      /*  double distanceHospitalSource = calculeteDistanceFrom(drone.getSourceHospital());
        double distanceHospitalDestiny = calculeteDistanceFrom(drone.getDestinyHopistal());


        drone.setDistanceHospitalSource(distanceHospitalSource);
        drone.setDistanceHospitalDestiny(distanceHospitalDestiny);*/

        Label label = new Label();
        label.setText(droneLabel);
        label.setTextFill(Color.RED);
        label.setTextAlignment(TextAlignment.CENTER);


        getChildren().addAll(imageViewDrone,label, imageViewBadConnection);

        currentCellView.getChildren().add(this);


    }

    @Override
    public String getDroneLabel() {
        return droneLabel;
    }
    @Override
    public void updadePositionDroneView(Drone drone) {

        if(currentCellView == null){
            return;
        }

        if(currentCellView != null && currentCellView.getChildren()!= null){
            if(currentCellView.getChildren().contains(this)){
                currentCellView.getChildren().remove(this);
            }
        }


        System.out.println((drone.getCurrentPositionI()+" "+drone.getCurrentPositionJ()));
        CellView newCellView = environmentView.getCellFrom(drone.getCurrentPositionI(),drone.getCurrentPositionJ());
        currentCellView = newCellView;

        if(currentCellView != null && currentCellView.getChildren()!= null){
            if(!currentCellView.getChildren().contains(this)){
                currentCellView.getChildren().add(this);
            }
        }



    }

    public Node updateItIsOver(Drone drone) {

        if(currentCellView == null){
            return null;
        }

        drone.getOnTopOfList().clear();



        for(Node node : currentCellView.getChildren()){

            if(node==this){
                continue;
            }

            drone.addOnTopOfDroneList(node);
        }
        if(!drone.getOnTopOfList().isEmpty()){
            //System.out.println(drone.getOnTopOfList().get(drone.getOnTopOfList().size()-1));
        }


        return null;
    }
    @Override
    public void applyStyleLanded() {

       // drone.setIsTookOff(false);
        setScaleX(1);
        setScaleY(1);
    }

    @Override
    public void applyStyleTakeOff() {

       // drone.setIsTookOff(true);
        setScaleX(1.4);
        setScaleY(1.4);
    }

    @Override
    public void applyStyleStarted() {
        imageViewDrone.setImage(new Image("/view/res/selectedDrone.png"));
    }

    @Override
    public void applyStyleShutDown(){
        imageViewDrone.setImage(new Image("/view/res/notSelectedDrone.png"));
    }

    public void applyStyleBadConnection() {
        imageViewBadConnection.setVisible(true);
    }

    public void applyStyleNormalConnection() {
        imageViewBadConnection.setVisible(false);
    }

    @Override
    public void removeStyleSelected(){
        if(selectedRetangle!= null){
            this.getChildren().remove(selectedRetangle);

            selectedRetangle = null;
        }
    }

    @Override
    public void applyStyleSelected() {
        if(selectedRetangle == null){
            selectedRetangle = new Rectangle(30,30);
            selectedRetangle.setFill(Color.TRANSPARENT);
            selectedRetangle.setStrokeWidth(3);
            selectedRetangle.setStroke(Color.BLUE);
            this.getChildren().add(selectedRetangle);

        }

    }


    /*   @Override
       public Object getDrone() {
           return drone;
       }
   */
    @Override
    public Node getNode() {
        return this;
    }



    //todo tlz esse métodos eu tenha que tirar daqui

/*
    public static void cleanDroneViewList() {
        for(DroneView droneView : new ArrayList<>(droneViewList)){
            removeDroneViewFromList(droneView);
        }
    }


    public static List<DroneView> getDroneViewList() {
        return droneViewList;
    }


    public static void removeDroneViewFromList(DroneView droneView) {
        if(droneViewList.contains(droneView)){
            droneViewList.remove(droneView);
        }
    }


    public static void addDroneViewFromList(DroneView droneView) {
        if(!droneViewList.contains(droneView)){
            droneViewList.add(droneView);
        }
    }
*/


    @Override
    public void onChange(Drone drone, String methodName, Object oldValue, Object newValue) {

         if(drone.getUniqueID() != uniqueID){
            return;
        }

        if(methodName.equals("setStarted") && !((Boolean) oldValue) && (Boolean) newValue){

            applyStyleStarted();

            System.out.println("Drone["+getDroneLabel()+"] "+"Start");
            loggerController.print("Drone["+getDroneLabel()+"] "+"Start");

            return;
        }

        if(methodName.equals("setStarted") && ((Boolean) oldValue) && !(Boolean) newValue){

            applyStyleShutDown();

            System.out.println("Drone["+getDroneLabel()+"] "+"Shutdown");
            loggerController.print("Drone["+getDroneLabel()+"] "+"Shutdown");
            return;
        }

        if(methodName.equals("setIsTookOff") && !((Boolean) oldValue) && (Boolean) newValue){

            applyStyleTakeOff();

            System.out.println("Drone["+getDroneLabel()+"] "+"Take Off");
            loggerController.print("Drone["+getDroneLabel()+"] "+"Take Off");

            return;
        }

        if(methodName.equals("setIsTookOff") && ((Boolean) oldValue) && !(Boolean) newValue){

            System.out.println("Drone["+getDroneLabel()+"] "+"Landing");
            loggerController.print("Drone["+getDroneLabel()+"] "+"Landing");

            applyStyleLanded();

            System.out.println("Drone["+getDroneLabel()+"] "+"Landed");
            loggerController.print("Drone["+getDroneLabel()+"] "+"Landed");

            return;
        }

        if(methodName.equals("setIsStarted") && ((Boolean) oldValue) && !(Boolean) newValue){

            removeStyleSelected();

            System.out.println("Drone["+getDroneLabel()+"] "+"shutdown");
            loggerController.print("Drone["+getDroneLabel()+"] "+"shutdown");

            checkAndPrintIfLostDrone(drone);

            return;
        }

        if(methodName.equals("setIsStarted") && !((Boolean) oldValue) && (Boolean) newValue){

            applyStyleStarted();

            System.out.println("Drone["+getDroneLabel()+"] "+"start");
            loggerController.print("Drone["+getDroneLabel()+"] "+"start");

            return;
        }

        if(methodName.equals("setIsSafeland") && !((Boolean) oldValue) && (Boolean) newValue){

            System.out.println("Drone["+getDroneLabel()+"] "+"SafeLand");
            loggerController.print("Drone["+getDroneLabel()+"] "+"SafeLand");

            applyStyleLanded();

            /*System.out.println("Drone["+getDroneLabel()+"] "+"Landed");
            loggerController.print("Drone["+getDroneLabel()+"] "+"Landed");*/


            return;
        }


        if((methodName.equals("setCurrentPositionI") || methodName.equals("setCurrentPositionJ"))
                && ((Integer)oldValue).intValue() != ((Integer)newValue).intValue() ){

            updadePositionDroneView(drone);
            updateItIsOver(drone);


            return;
        }

        if(methodName.equals("setCurrentBattery")
                &&((Double)oldValue).intValue() != ((Double)newValue).intValue()){
            System.out.println("Drone["+getDroneLabel()+"] "+"Current battery: "+drone.getCurrentBattery()+"%");
            loggerController.print("Drone["+getDroneLabel()+"] "+"Current battery: "+drone.getCurrentBattery()+"%");
            return;
        }

        if(methodName.equals("setBadConnection")
                &&!((Boolean) oldValue) && (Boolean) newValue){
             applyStyleBadConnection();
            System.out.println("Drone["+getDroneLabel()+"] "+"Bad Connection");
            loggerController.print("Drone["+getDroneLabel()+"] "+"Bad Connection");

        }

        if(methodName.equals("setBadConnection")
                &&(Boolean) oldValue && !(Boolean) newValue){

             if(drone.isReturningToHome()){
                 return;
             }

            applyStyleNormalConnection();
            System.out.println("Drone["+getDroneLabel()+"] "+"Normal Connection");
            loggerController.print("Drone["+getDroneLabel()+"] "+"Normal Connection");

        }
    }


    public void checkAndPrintIfLostDrone(Drone drone) {

        System.out.println("drone.getDistanceHospitalDestiny():"+ drone.getDistanceHospitalDestiny() );

        if(drone.isReturningToHome() && drone.getDistanceHospitalSource()==0){
            System.out.println("Drone["+getDroneLabel()+"] "+"Return to home completed successfully");
            loggerController.print("Drone["+getDroneLabel()+"] "+"Return to home completed successfully");
            return;
        }
        if(drone.getDistanceHospitalDestiny() == 0){
            System.out.println("Drone["+getDroneLabel()+"] "+"Arrived at destination");
            loggerController.print("Drone["+getDroneLabel()+"] "+"Arrived at destination");
            return;
        }

        if(drone.isGoingManualToDestiny()){
            System.out.println("Drone["+getDroneLabel()+"] "+"Arrived at destination");
            loggerController.print("Drone["+getDroneLabel()+"] "+"Arrived at destination");
            return;
        }

        if(drone.isOnWater()){
            System.out.println("Drone["+getDroneLabel()+"] "+"Drone landed on water");
            loggerController.print("Drone["+getDroneLabel()+"] "+"Drone landed on water");
        }else {
            System.out.println("Drone["+getDroneLabel()+"] "+"Drone landed successfully");
            loggerController.print("Drone["+getDroneLabel()+"] "+"Drone landed successfully");
        }


    }




}
