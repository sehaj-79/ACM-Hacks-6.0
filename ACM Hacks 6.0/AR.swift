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

var ARModelStatus:Int = 1
var modelEntity = ModelEntity()
let anchor = AnchorEntity()
var FirstState:Bool = true
var savedModelEntity = ModelEntity()

struct AR: View {
    var body: some View {
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
}

struct ARViewContainer: UIViewRepresentable {
    
    
    func makeUIView(context: Context) -> ARView {
        
        let view = ARView()
        
        //Screen Timeout Off
        UIApplication.shared.isIdleTimerDisabled = true
        
        // Start AR session
        let session = view.session
        let config = ARWorldTrackingConfiguration()
        config.planeDetection = [.horizontal]
        session.run(config)
        
//        // Add coaching overlay
//        let coachingOverlay = ARCoachingOverlayView()
//        coachingOverlay.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//        coachingOverlay.session = session
//        coachingOverlay.goal = .horizontalPlane
//        view.addSubview(coachingOverlay)
        
        
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
