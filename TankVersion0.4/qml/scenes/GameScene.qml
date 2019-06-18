import Felgo 3.0
import QtQuick 2.0
import "../common"
//import "../levels"

SceneBase {
    id:gameScene
       // the filename of the current level gets stored here, it is used for loading the
    property string activeLevelFileName
       //
    property int activeNumPlayers
       // the currently loaded level gets stored here
    property variant activeLevel

 //   property alias controller: controller

    signal backPressed()

       // set the name of the current level, this will cause the Loader to load the corresponding level
    function setLevel(fileName) {
      activeLevelFileName = fileName
    }
    //
    function setPlayer(numPlayers) {
      activeNumPlayers = numPlayers
    }
    // background
    Rectangle {
        anchors.fill: parent.gameWindowAnchorItem
        color: "#47688e"
        Movement{
            z:5
            id:move
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            MultiPointTouchArea {
                anchors.fill: parent
                onPressed: {
                    if((move.width-(move.height/2-touchPoints[0].y)*2)/2<touchPoints[0].x <(move.width-(move.height/2-touchPoints[0].y)*2)/2+2*(move.height/2-touchPoints[0].y) &&touchPoints[0].y<move.height/2)
                        controller.yAxis = 1
                    else if((move.width-(move.height/2-(move.height-touchPoints[0].y))*2)/2<touchPoints[0].x<(move.width-(move.height/2-(move.height-touchPoints[0].y))*2)/2+2*(move.height/2-(move.height-touchPoints[0].y)) &&touchPoints[0].y>move.height/2)
                        controller.yAxis = -1
                    else if(touchPoints[0].x < move.width/2&& (move.height-(move.width/2-touchPoints[0].x)*2)/2<touchPoints[0].y<(move.height-(move.width/2-touchPoints[0].x)*2)/2+2*(move.width/2-touchPoints[0].x))
                        controller.xAxis = -1
                    else (touchPoints[0].x > move.width/2&& (move.height-(move.width/2-(move.width-touchPoints[0].x))*2)/2<touchPoints[0].y<(move.height-(move.width/2-(move.width-touchPoints[0].x))*2)/2+(move.width/2-(move.width-touchPoints[0].x))*2)
                        controller.xAxis = 1
                }
                onUpdated: {
                    if((move.width-(move.height/2-touchPoints[0].y)*2)/2<touchPoints[0].x <(move.width-(move.height/2-touchPoints[0].y)*2)/2+2*(move.height/2-touchPoints[0].y) &&touchPoints[0].y<move.height/2){
                        controller.yAxis = 1;
                    }else if((move.width-(move.height/2-(move.height-touchPoints[0].y))*2)/2<touchPoints[0].x<(move.width-(move.height/2-(move.height-touchPoints[0].y))*2)/2+2*(move.height/2-(move.height-touchPoints[0].y)) &&touchPoints[0].y>move.height/2){
                        controller.yAxis = -1;
                    }else if(touchPoints[0].x < move.width/2&& (move.height-(move.width/2-touchPoints[0].x)*2)/2<touchPoints[0].y<(move.height-(move.width/2-touchPoints[0].x)*2)/2+2*(move.width/2-touchPoints[0].x)){
                        controller.xAxis = -1;
                    }else (touchPoints[0].x > move.width/2&& (move.height-(move.width/2-(move.width-touchPoints[0].x))*2)/2<touchPoints[0].y<(move.height-(move.width/2-(move.width-touchPoints[0].x))*2)/2+(move.width/2-(move.width-touchPoints[0].x))*2)
                        controller.xAxis = 1


                    console.log(touchPoints[0].x,touchPoints[0].y)

                }
                onReleased: controller.xAxis = 0,controller.yAxis = 0
            }
        }
    }


    MenuButton {
        z:1
        text: "Back"
        // anchor the button to the gameWindowAnchorItem to be on the edge of the screen on any device
        anchors.right: gameScene.gameWindowAnchorItem.right
        anchors.rightMargin: 10
        anchors.top: gameScene.gameWindowAnchorItem.top
        anchors.topMargin: 10
        onClicked: {
          backPressed()
          activeLevel = undefined
          activeLevelFileName = ""
        }
    }
    // load levels at runtime
    Loader {
      id: loader
      source: activeLevelFileName !== "" ? "../levels/" + activeLevelFileName : ""
      onLoaded: {
          // since we did not define a width and height in the level item itself, we are doing it here
        item.width = gameScene.width
        item.height = gameScene.height
        item.x=gameScene.width/2 - item.width/2
          // store the loaded level as activeLevel for easier access
        activeLevel = item
      }
    }

    // name of the current level
     Text {
       id:showActiveLevel
       anchors.left: gameScene.gameWindowAnchorItem.left
       anchors.leftMargin: 10
       anchors.top: gameScene.gameWindowAnchorItem.top
       anchors.topMargin: 10
       color: "white"
       font.pixelSize: 20
       text: activeLevel !== undefined ? activeLevel.levelName : ""
     }
     Text {
       anchors.left: gameScene.gameWindowAnchorItem.left
       anchors.leftMargin: 10
       anchors.top: showActiveLevel.bottom
       color: "white"
       font.pixelSize: 20
       text: activeNumPlayers+" Player"
     }


     PhysicsWorld {
       id: physicsWorld
       //gravity: Qt.point(0, 25)
       debugDrawVisible: true // enable this for physics debugging
       z: 1000

     }
     Keys.forwardTo: controller
     TwoAxisController {
       id: controller
       onInputActionPressed: {
//         console.debug("key pressed actionName " + actionName)
         if(actionName == "up") {
           activeLevel.player1.tank.source="../../images/home.png"
//             console.log(activeLevel)
         }
       }
     }
}
