///*
//import javafx.application.Platform;
//import model.drone.Drone;
//import view.drone.DroneViewImpl;
//
//import java.util.Timer;
//import java.util.TimerTask;
//
//public aspect DroneAspect {
//    private boolean isMoveAside; pointcut checkExceptionalConditions() : call (void view.drone.DroneViewImpl.safeLanding());
//
//
//    void around() : checkExceptionalConditions() && if(
//            ((Drone)((DroneViewImpl) thisJoinPoint.getTarget()).getDrone()).getCurrentBattery()>5
//            &&
//            ((Drone)((DroneViewImpl) thisJoinPoint.getTarget()).getDrone()).getDistanceHospitalDestiny() <=60
//            &&
//            ((Drone)((DroneViewImpl) thisJoinPoint.getTarget()).getDrone()).isStrongWind()
//            &&
//            ((Drone)((DroneViewImpl) thisJoinPoint.getTarget()).getDrone()).isAspect()
//            ){
//
//        System.out.println(" Start Aspect around");
//        DroneViewImpl droneView = (DroneViewImpl) thisJoinPoint.getTarget();
//        Drone drone = (Drone) droneView.getDrone();
//
//        System.out.println("drone.isOnWater() "+drone.isOnWater());
//        System.out.println("getDistanceHospitalDestiny() "+drone.getDistanceHospitalDestiny());
//        System.out.println("drone.isStrongWind() "+drone.isStrongWind());
//        System.out.println("drone.isAutomatic() "+drone.isAutomatic());
//
//
//        keepFlying(droneView);
//
//
//        System.out.println("finish Aspect");
//    }
//
//
//    before() : checkExceptionalConditions() && if(
//            ((Drone)((DroneViewImpl) thisJoinPoint.getTarget()).getDrone()).isOnWater()
//            &&
//            ((Drone)((DroneViewImpl) thisJoinPoint.getTarget()).getDrone()).isAspect()
//            ) {
//
//        System.out.println(" Start Aspect around");
//        DroneViewImpl droneView = (DroneViewImpl) thisJoinPoint.getTarget();
//        Drone drone = (Drone) droneView.getDrone();
//
//
//        System.out.println("drone.isOnWater() "+drone.isOnWater());
//        System.out.println("getDistanceHospitalDestiny() "+drone.getDistanceHospitalDestiny());
//        System.out.println("drone.isStrongWind() "+drone.isStrongWind());
//        System.out.println("drone.isAutomatic() "+drone.isAutomatic());
//
//
//        moveASide(droneView);
//
//
//        System.out.println("finish Aspect");
//
//    }
//
//
//    private void moveASide(DroneViewImpl droneView) {
//
//        if(isMoveAside){
//            return;
//        }
//
//        Drone drone = (Drone) droneView.getDrone();
//
//        if(drone.isGoingAutomaticToDestiny()  || drone.isAutomatic()){
//            droneView.stopGoAutomaticDestiny();
//        }
//
//        if(drone.isReturningToHome() || drone.isBadConnection()){
//            droneView.stopReturnToHome();
//        }
//
//
//        System.out.println("Drone[" + drone.getUniqueID() + "] " + "Move aside aspect");
//        droneView.loggerController.print("Drone[" + drone.getUniqueID() + "] " + "Move aside aspect");
//
//
//        */
///*Get off the river*//*
//
//        Timer timer = new Timer();
//
//        TimerTask timerTask = new TimerTask() {
//            @Override
//            public void run() {
//
//                Platform.runLater(() -> {
//                    droneView.flyingUp();
//
//                    droneView.updadePositionDroneView(drone);
//                    droneView.updateItIsOver(drone);
//
//
//
//                    if (!drone.isOnWater()) {
//                        safeLandingAspect(droneView);
//                        isMoveAside=false;
//                        cancel();
//                        return;
//                    }
//                });
//            }
//        };
//
//        timer.scheduleAtFixedRate(timerTask, 0, 1000);
//
//
//    }
//
//    */
///*This specific aspect method was created to avoid infinite loop*//*
//
//    private void safeLandingAspect(DroneViewImpl droneView) {
//        Drone drone = (Drone) droneView.getDrone();
//
//        drone.setIsTookOff(false);
//
//        System.out.println("Drone["+drone.getUniqueID()+"] "+"SafeLand aspect");
//        droneView.loggerController.print("Drone["+drone.getUniqueID()+"] "+"SafeLand aspect");
//
//        droneView.applyStyleLanded();
//
//        System.out.println("Drone["+drone.getUniqueID()+"] "+"Landed aspect");
//        droneView.loggerController.print("Drone["+drone.getUniqueID()+"] "+"Landed aspect");
//
//        shutDown(droneView);
//
//        if(drone.isOnWater()){
//            System.out.println("Drone["+drone.getUniqueID()+"] "+"Drone landed on water aspect");
//            droneView.loggerController.print("Drone["+drone.getUniqueID()+"] "+"Drone landed on water aspect");
//        }else {
//            System.out.println("Drone["+drone.getUniqueID()+"] "+"Drone landed successfully aspect");
//            droneView.loggerController.print("Drone["+drone.getUniqueID()+"] "+"Drone landed successfully aspect");
//        }
//
//    }
//
//    */
///*This particular aspect method was created to differentiate the management*//*
//
//    private void shutDown(DroneViewImpl droneView) {
//        Drone drone = (Drone) droneView.getDrone();
//
//        drone.setStarted(false);
//
//        droneView.removeStyleSelected();
//
//        System.out.println("Drone["+drone.getUniqueID()+"] "+"shutdown aspect");
//        droneView.loggerController.print("Drone["+drone.getUniqueID()+"] "+"shutdown aspect");
//
//    }
//
//    */
///*Continues flying towards the destination hospital*//*
//
//    private void keepFlying(DroneViewImpl droneView) {
//
//        Drone drone = (Drone) droneView.getDrone();
//
//        if(drone.isGoingAutomaticToDestiny()){
//            droneView.stopGoAutomaticDestiny();
//        }
//
//
//        System.out.println("Drone[" + drone.getUniqueID() + "] " + "keep Flying aspect");
//        droneView.loggerController.print("Drone[" + drone.getUniqueID() + "] " + "keep Flying aspect");
//
//
//        Timer timer = new Timer();
//        TimerTask goAutomaticDestinyTimerTask = new TimerTask() {
//            @Override
//            public void run() {
//
//              */
///*  if (!drone.isAutomatic()) {
//                    cancel();
//                    return;
//                }*//*
//
//
//
//
//              if(drone.isManual()){
//                  drone.setIsManual(false);
//              }
//
//                if (drone.isBadConnection()) {
//                    droneView.stopReturnToHome();
//
//                }
//
//                if (drone.getDistanceHospitalDestiny() == 0) {
//                    landing(droneView);
//
//                    shutDown(droneView);
//
//                    System.out.println("Drone["+drone.getUniqueID()+"] "+"Arrived at destination aspect");
//                    droneView.loggerController.print("Drone["+drone.getUniqueID()+"] "+"Arrived at destination aspect");
//                    drone.setIsManual(!drone.isAutomatic());
//                    cancel();
//                    return;
//
//                }
//
//                */
///*Flying towards the destination hospital*//*
//
//                Platform.runLater(() -> {
//                    try {
//
//
//                        int oldI = drone.getCurrentPositionI();
//                        int oldJ = drone.getCurrentPositionJ();
//                        double newDistanceDestiny = 999999;
//                        String mustGO = null;
//
//                        double tempDistance = droneView.distanceDroneWentRight(drone.getDestinyHopistal());
//
//                        if (tempDistance < newDistanceDestiny) {
//                            newDistanceDestiny = tempDistance;
//                            mustGO = "->";
//                        }
//
//                        drone.setCurrentPositionI(oldI);
//                        drone.setCurrentPositionJ(oldJ);
//
//                        tempDistance = droneView.distanceDroneWentLeft(drone.getDestinyHopistal());
//
//                        if (tempDistance < newDistanceDestiny) {
//                            newDistanceDestiny = tempDistance;
//                            mustGO = "<-";
//                        }
//
//                        drone.setCurrentPositionI(oldI);
//                        drone.setCurrentPositionJ(oldJ);
//
//                        tempDistance = droneView.distanceDroneWentUp(drone.getDestinyHopistal());
//
//                        if (tempDistance < newDistanceDestiny) {
//                            newDistanceDestiny = tempDistance;
//                            mustGO = "/\\";
//
//                        }
//
//                        drone.setCurrentPositionI(oldI);
//                        drone.setCurrentPositionJ(oldJ);
//
//                        tempDistance = droneView.distanceDroneWentDown(drone.getDestinyHopistal());
//
//                        if (tempDistance < newDistanceDestiny) {
//                            newDistanceDestiny = tempDistance;
//                            mustGO = "\\/";
//
//                        }
//
//                        drone.setCurrentPositionI(oldI);
//                        drone.setCurrentPositionJ(oldJ);
//
//
//                        if (drone.getDistanceHospitalDestiny() != 0) {
//                            droneView.goTo(mustGO);
//                            droneView.updadePositionDroneView(drone);
//
//                            droneView.updateBattery();
//
//                            droneView.updateItIsOver(drone);
//
//
//                        }
//
//                        if (drone.getDistanceHospitalDestiny() == 0) {
//                            droneView.landing();
//
//                            droneView.shutDown();
//
//                            System.out.println("Drone["+drone.getUniqueID()+"] "+"Arrived at destination aspect");
//                            droneView.loggerController.print("Drone["+drone.getUniqueID()+"] "+"Arrived at destination aspect");
//                            drone.setIsManual(!drone.isAutomatic());
//                            cancel();
//                            return;
//
//                        }
//
//
//                    } catch (Exception e) {
//                        System.out.println();
//                    }
//                });
//            }
//        };
//
//        timer.scheduleAtFixedRate(goAutomaticDestinyTimerTask,0,1000);
//
//    }
//
//    */
///*This particular aspect method was created to differentiate the management*//*
//
//    private void landing(DroneViewImpl droneView) {
//        Drone drone = (Drone) droneView.getDrone();
//
//        drone.setIsTookOff(false);
//
//        System.out.println("Drone["+drone.getUniqueID()+"] "+"Landing aspect");
//        droneView.loggerController.print("Drone["+drone.getUniqueID()+"] "+"Landing aspect");
//
//        droneView.applyStyleLanded();
//
//        System.out.println("Drone["+drone.getUniqueID()+"] "+"Landed aspect");
//        droneView.loggerController.print("Drone["+drone.getUniqueID()+"] "+"Landed aspect");
//    }
//
//
//
//    pointcut applyEconomyMode() : call (void view.drone.DroneViewImpl.applyEconomyMode());
//    void around() : applyEconomyMode() &&
//            if(((Drone)((DroneViewImpl) thisJoinPoint.getTarget()).getDrone()).isAspect())
//            {
//
//
//                System.out.println(" Start Aspect");
//                DroneViewImpl droneView = (DroneViewImpl) thisJoinPoint.getTarget();
//                Drone drone = (Drone) droneView.getDrone();
//                System.out.println("drone.isOnWater() "+drone.isOnWater());
//                System.out.println("getDistanceHospitalDestiny() "+drone.getDistanceHospitalDestiny());
//                System.out.println("drone.isStrongWind() "+drone.isStrongWind());
//                System.out.println("drone.isAutomatic() "+drone.isAutomatic());
//
//                normalMode(droneView);
//
//                System.out.println(" Finish Aspect");
//            }
//
//
//    */
///*Continues in the normal mode of battery consumption*//*
//
//    private void normalMode(DroneViewImpl droneView) {
//        Drone drone = (Drone) droneView.getDrone();
//
//        System.out.println("Drone["+drone.getUniqueID()+"] "+"Continue Normal Mode aspect");
//        droneView.loggerController.print("Drone["+drone.getUniqueID()+"] "+"Continue Normal Mode aspect");
//        drone.setEconomyMode(false);
//
//    }
//
//
//
//
//    pointcut returnToHome() : call (void view.drone.DroneViewImpl.returnToHome());
//    void around() : returnToHome() &&
//            if(
//            (
//            ((Drone)((DroneViewImpl) thisJoinPoint.getTarget()).getDrone()).getDistanceHospitalDestiny()
//            <
//            ((Drone)((DroneViewImpl) thisJoinPoint.getTarget()).getDrone()).getDistanceHospitalSource()
//            )
//            &&
//            ((Drone)((DroneViewImpl) thisJoinPoint.getTarget()).getDrone()).getCurrentBattery()
//            >
//            10
//            &&
//            ((Drone)((DroneViewImpl) thisJoinPoint.getTarget()).getDrone()).isAspect()
//            ) {
//
//        DroneViewImpl droneView = (DroneViewImpl) thisJoinPoint.getTarget();
//
//        glide(droneView);
//
//
//    }
//
//    private void glide(DroneViewImpl droneView) {
//
//        Drone drone = (Drone) droneView.getDrone();
//        System.out.println("Drone["+drone.getUniqueID()+"] "+" Glide aspect");
//        droneView.loggerController.print("Drone["+drone.getUniqueID()+"] "+"Glide aspect");
//
//        if(drone.isGoingAutomaticToDestiny()){
//            droneView.stopGoAutomaticDestiny();
//            drone.setGoingAutomaticToDestiny(false);
//        }
//    }
//}
//*/
