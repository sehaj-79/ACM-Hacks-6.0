//
//  AR.swift
//  ACM Hacks 6.0
//
//  Created by Shikhar Kumar on 11/02/22.
//

import SwiftUI
import ARKit
import RealityKit
import FocusEntity
import RealityUI

var ARModelStatus:Int = 1
var modelEntity = ModelEntity()
let anchor = AnchorEntity()
var FirstState:Bool = true
var savedModelEntity = ModelEntity()
var Questions : [String] = ["This muscle is not a medical rotator of the shoulder joint?","This muscle is flexor, adductor and medial rotator of shoulder joint?","This bone is the first one to start ossification?"]
var Options = [["Pectoralis Major","Teres Major", "Teres Minor", "Latissimus dorsi"],["Pectorallis Minor","Pectoralis Major", "Teres Minor", "Infraspinatus"], ["Ulna", "Scapula", "Clavicle", "Humerus"]]
//var Answers =


struct AR: View {
    var body: some View {
        //HStack {
            ZStack {
                ARViewContainer()
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    HStack{
                        Button {
                            ARModelStatus = 1
                        } label: {
                            Text("1")
                                .frame(width: 50, height: 50)
                                .background(Color.blue)
                                .foregroundColor(Color.white)
                                .cornerRadius(40)
                        }.padding()
                        Spacer()
                    }
                    HStack{
                        Button {
                            ARModelStatus = 2
                        } label: {
                            Text("2")
                                .frame(width: 50, height: 50)
                                .background(Color.blue)
                                .foregroundColor(Color.white)
                                .cornerRadius(40)
                        }.padding()
                        Spacer()
                    }
                    HStack{
                        Button {
                            ARModelStatus = 3
                        } label: {
                            Text("3")
                                .frame(width: 50, height: 50)
                                .background(Color.blue)
                                .foregroundColor(Color.white)
                                .cornerRadius(40)
                        }.padding()
                        Spacer()
                    }
                }
            }
        }
   // }
}

struct ARViewContainer: UIViewRepresentable {
    
    
    func makeUIView(context: Context) -> ARView {
        
        let view = ARView()
        
        //RealityUI Config
        RealityUI.registerComponents()
        RealityUI.enableGestures(.all, on: view)
        
        //Screen Timeout Off
        UIApplication.shared.isIdleTimerDisabled = true
        
        // Start AR session
        let session = view.session
        let config = ARWorldTrackingConfiguration()
        config.planeDetection = [.horizontal]
        session.run(config)
        
        // Add coaching overlay
        let coachingOverlay = ARCoachingOverlayView()
        coachingOverlay.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        coachingOverlay.session = session
        coachingOverlay.goal = .horizontalPlane
        view.addSubview(coachingOverlay)
        
        
        context.coordinator.view = view
        session.delegate = context.coordinator
        
        
        view.addGestureRecognizer(
            UITapGestureRecognizer(
                target: context.coordinator,
                action: #selector(Coordinator.handleTap)
            )
        )
        
        return view
        
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
    
    class Coordinator: NSObject, ARSessionDelegate {
        weak var view: ARView?
        var focusEntity: FocusEntity?
        
        func session(_ session: ARSession, didAdd anchors: [ARAnchor]) {
            guard let view = self.view else { return }
            debugPrint("Anchors added to the scene: ", anchors)
            self.focusEntity = FocusEntity(on: view, style: .classic(color: .yellow))
        }
        
        @objc func handleTap() {
            guard let view = self.view, let focusEntity = self.focusEntity else { return }
            
            
            if FirstState == true {
                view.scene.anchors.append(anchor)
                
                if ARModelStatus == 1 {
                    modelEntity = try! ModelEntity.loadModel(named: "body")
                    modelEntity.position = focusEntity.position
                }
                else if ARModelStatus == 2{
                    modelEntity = try! ModelEntity.loadModel(named: "skeletal")
                    modelEntity.position = focusEntity.position
                }
                else if ARModelStatus == 3{
                    modelEntity = try! ModelEntity.loadModel(named: "muscular")
                    modelEntity.position = focusEntity.position
                }
                
//                let newSwitch = RUISwitch(
//                    RUI: RUIComponent(respondsToLighting: true),
//                    changedCallback: { mySwitch in
//                        modelEntity.model?.materials = [
//                            SimpleMaterial(
//                                color: mySwitch.isOn ? .green : .red,
//                                isMetallic: false
//                            )]})
//
//
//                newSwitch.scale = [0.1, 0.1, 0.1]
//                //newSwitch.position = focusEntity.position
//                var newSwitchOrientation = simd_quatf()
//                newSwitchOrientation = simd_quatf(angle: 0 ,axis: simd_float3(x: 0,y: 1, z: 0))
//                newSwitch.orientation = newSwitchOrientation
//                anchor.addChild(newSwitch)
                
                
                let boardEntity = try! ModelEntity.loadModel(named: "board")
                boardEntity.position = focusEntity.position + [1,0,-1.05]
                boardEntity.scale = [0.001,0.001,0.001]
                var boardOrientation = simd_quatf()
                boardOrientation = simd_quatf(angle: -0.4 ,axis: simd_float3(x: 0,y: 1, z: 0))
                boardEntity.orientation = boardOrientation
                anchor.addChild(boardEntity)
                
                let pecEntity = try! ModelEntity.loadModel(named: "pec")
                pecEntity.position = focusEntity.position
                modelEntity.scale = [0.005, 0.005, 0.005]
                var pecOrientation = simd_quatf()
                pecOrientation = simd_quatf(angle: 0 ,axis: simd_float3(x: 0,y: 1, z: 0))
                pecEntity.orientation = pecOrientation
                anchor.addChild(pecEntity)
                
                let question = RUIText(with: "This is your Question")
                question.position = focusEntity.position + [1,0.5,-1]
                question.scale = [0.2,0.2,0.2]
                var questionOrientation = simd_quatf()
                questionOrientation = simd_quatf(angle: 2.74 ,axis: simd_float3(x: 0,y: 1, z: 0))
                question.orientation = questionOrientation
                anchor.addChild(question)
                
                
                savedModelEntity.position = focusEntity.position
                FirstState = false
            }
            
            else {
                anchor.removeChild(modelEntity)
                view.scene.anchors.append(anchor)
                
                if ARModelStatus == 1 {
                    modelEntity = try! ModelEntity.loadModel(named: "body")
                    modelEntity.position = savedModelEntity.position
                }
                else if ARModelStatus == 2{
                    modelEntity = try! ModelEntity.loadModel(named: "skeletal")
                    modelEntity.position = savedModelEntity.position
                }
                else if ARModelStatus == 3{
                    modelEntity = try! ModelEntity.loadModel(named: "muscular")
                    modelEntity.position = savedModelEntity.position
                }
                
            }
            
            
          
            
            modelEntity.scale = [0.005, 0.005, 0.005]
            var var_simd_quatf = simd_quatf()
            var_simd_quatf = simd_quatf(angle: 0 ,axis: simd_float3(x: 0,y: 1, z: 0))
            modelEntity.orientation = var_simd_quatf
            anchor.addChild(modelEntity)
            
            
        }
    }
    
}


#if DEBUG
struct AR_Previews : PreviewProvider {
    static var previews: some View {
        AR()
    }
}
#endif
