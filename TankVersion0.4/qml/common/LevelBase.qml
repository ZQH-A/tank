import QtQuick 2.0
import Felgo 3.0
import ".."
import "../entities"
//import "../controls"

Item {
  id: levelBaseScene
  // this will be displayed in the GameScene
  property string levelName
  // this is emitted whenever the rectangle has been tapped successfully, the GameScene will listen to this signal and increase the score
  signal rectanglePressed

  //background
  Rectangle {
    anchors.fill: parent
    color: "black"
    visible: true
  }

  Home{
      //z:2
      id: home
      entityId: "home"
      entityType: "home"
      anchors.bottom: levelBaseScene.bottom
      anchors.horizontalCenter: levelBaseScene.horizontalCenter
  }

  Row{
//    anchors.bottom: home.top
//    anchors.horizontalCenter: levelBaseScene.horizontalCenter
    RedWall{
        id:redWall
//        x:parent.x
//        y:parent.y

    }
    RedWall{

    }
    RedWall{

    }
    RedWall{

    }


  }
 Column {
//     anchors.right: home.left
//     anchors.bottom: levelBaseScene.bottom
     RedWall{

     }
     RedWall{

     }

 }
 Column {
//     anchors.left: home.right
//     anchors.bottom: levelBaseScene.bottom
     RedWall{

     }
     RedWall{

     }

 }


    // PLAYER 1
    // player and tank
    Player {
      z: 2
      id: player1
      entityId: "p1"
//      entityType: "player"
//      variationType: "p1"
      tank.entityId: "p1"
//      tank.entityType: "tank"
//      tank.variationType: "p1"
      tank.originX: levelBaseScene.width/2-home.width-redWall.width-10
      tank.originY: levelBaseScene.height-tank.tankBody.height

      //tank.rotation: 0
    }


}
