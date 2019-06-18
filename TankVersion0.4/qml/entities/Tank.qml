import Felgo 3.0
import QtQuick 2.0
import "../levels"
import "../scenes"

EntityBase {
    entityType: "tank"
    entityId: "tank"
    variationType: "p1"
    id: tank
    x: originX
    y: originY
    width: 30
    height: 30
    property alias tank: tank
    property alias tankBody: tankBody
    property alias boxCollider: boxCollider
    property double originX
    property double originY

    // the visual body of the tank
    MultiResolutionImage {
      id: tankBody
      anchors.fill:parent
      //anchors.fill: parent
    }

    // holds the physical properties of the tank
    BoxCollider {
      //enabled: !GameInfo.gamePaused
      id: boxCollider
      //anchors.centerIn: parent

      density: 0
      friction: 0.4
      restitution: 0.4
      linearDamping: 100
      bullet: true
      force: Qt.point(controller.xAxis*170*32,-controller.yAxis*170*32)
      bodyType: Body.Dynamic
    }
}
