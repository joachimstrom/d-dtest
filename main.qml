import QtQuick 2.8
import QtQuick.Window 2.2

Window {
    visible: true
    width: 600
    height: 600
    Rectangle{
        height: 100
        width: parent.width
        id: toolBar
    }
    
    property string title
    property int xPos
    property int yPos
    
    Rectangle{
        id: r1
        anchors.top: toolB.bottom
        height: parent.height
        width: parent.width/2
        border.width: 1; border.color: "grey"
        ListView{
            id: lv2
            anchors.fill: parent
            model: mod2
            delegate: l2Delg
            
        }
        Component{
            id: l2Delg
            Rectangle {
                id: draggable
                height: 100
                width: 300
                Text{anchors.centerIn: parent; text: name}
                color: "darkgrey"
                Drag.active: mouseArea.drag.active
                Drag.hotSpot.x: draggable.width
                Drag.hotSpot.y: draggable.height/2
                Drag.dragType: Drag.Automatic 
                Drag.onDragStarted: {
                    draggable.color = "lightgrey"
                    title = name
                }
                Drag.onDragFinished: {
                    draggable.color = "darkgrey"
                    defaultXPos.start()
                    defaultYPos.start()
                }
                PropertyAnimation{
                    id: defaultXPos
                    target: draggable
                    property: "x"
                    to: xPos
                    duration: 1
                }
                PropertyAnimation{
                    id: defaultYPos
                    target: draggable
                    property: "y"
                    to: yPos
                    duration: 1
                }
                
                MouseArea {
                    id: mouseArea
                    anchors.fill: parent
                    onPressed: {
                        lv2.currentIndex = index
                        xPos = draggable.x
                        yPos = draggable.y
                    }
                    onReleased: {
                        lv2.currentIndex = index;
                    }
                    drag.target: draggable
                }
            }
        }
        
    }
    ListModel{
        id: mod2
        ListElement{
            name: "Operator"
        }
        ListElement{
            name: "Electrician"
        }
        ListElement{
            name: "Mechanic"
        }
        ListElement{
            name: "Driver"
        }
    }
    ListModel{
        id: mod
        ListElement{
            name: "Eric"
        }
        ListElement{
            name: "Todd"
        }
        ListElement{
            name: "Tom"
        }
        ListElement{
            name: "Zack"
        }
    }
    Rectangle{
        id: r2
        anchors.top: toolB.bottom
        height: parent.height
        width: parent.width /2
        border.width: 1; border.color: "grey"
        anchors.left: r1.right
        ListView{
            id: lv
            anchors.fill: parent
            model: mod
            delegate: delg
        }
        Component{
            id: delg
            Rectangle{
                id: delRect
                height: 100
                width: 300
                color: dropA.containsDrag?  "lime" : "white"
                Text {anchors.centerIn: parent; text: name}
                MouseArea{
                    anchors.fill: parent
                    onClicked:  lv.currentIndex = index
                    onReleased: lv.currentIndex = index
                }
                
                DropArea{
                    id: dropA
                    anchors.fill: delRect
                    onEntered: {}//do nothing
                    onExited: {}//do nothing
                    onDropped:{
                        console.log(title + " was dropped on " + name)
                    }
                }
            }
        }
    }
    
    
}
