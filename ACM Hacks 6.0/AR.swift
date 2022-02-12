////
////  AR.swift
////  ACM Hacks 6.0
////
////  Created by Shikhar Kumar on 11/02/22.
////
//
//import SwiftUI
//import ARKit
//import RealityKit
//import FocusEntity
//import RealityUI
//
//var ARModelStatus:Int = 1
//var modelEntity = ModelEntity()
//let anchor = AnchorEntity()
//var FirstState:Bool = true
//var savedModelEntity = ModelEntity()
//var Questions : [String] = ["This muscle is not a medical\nrotator of the shoulder joint?","This muscle is flexor, adductor and\nmedial rotator of shoulder joint?","This bone is the first one to\nstart ossification?"]
//var Options = [["Pectoralis Major","Teres Major", "Teres Minor", "Latissimus dorsi"],["Pectorallis Minor","Pectoralis Major", "Teres Minor", "Infraspinatus"], ["Ulna", "Scapula", "Humerus", "Clavicle"]]
//var Answers = [2,1,3]
//var QNo : Int = 1
//
//
//struct AR: View {
//    var body: some View {
//        //HStack {
//            ZStack {
//                ARViewContainer()
//                    .edgesIgnoringSafeArea(.all)
//
//                VStack {
//                    HStack{
//                        Button {
//                            ARModelStatus = 1
//                        } label: {
//                            Text("1")
//                                .frame(width: 50, height: 50)
//                                .background(Color.blue)
//                                .foregroundColor(Color.white)
//                                .cornerRadius(40)
//                        }.padding()
//                        Spacer()
//                    }
//                    HStack{
//                        Button {
//                            ARModelStatus = 2
//                        } label: {
//                            Text("2")
//                                .frame(width: 50, height: 50)
//                                .background(Color.blue)
//                                .foregroundColor(Color.white)
//                                .cornerRadius(40)
//                        }.padding()
//                        Spacer()
//                    }
//                    HStack{
//                        Button {
//                            ARModelStatus = 3
//                        } label: {
//                            Text("3")
//                                .frame(width: 50, height: 50)
//                                .background(Color.blue)
//                                .foregroundColor(Color.white)
//                                .cornerRadius(40)
//                        }.padding()
//                        Spacer()
//                    }
//                }
//            }
//        }
//   // }
//}
//
//struct ARViewContainer: UIViewRepresentable {
//
//
//    func makeUIView(context: Context) -> ARView {
//
//        let view = ARView()
//
//        //RealityUI Config
//        RealityUI.registerComponents()
//        RealityUI.enableGestures(.all, on: view)
//
//        //Screen Timeout Off
//        UIApplication.shared.isIdleTimerDisabled = true
//
//        // Start AR session
//        let session = view.session
//        let config = ARWorldTrackingConfiguration()
//        config.planeDetection = [.horizontal]
//        session.run(config)
//
//        // Add coaching overlay
//        let coachingOverlay = ARCoachingOverlayView()
//        coachingOverlay.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//        coachingOverlay.session = session
//        coachingOverlay.goal = .horizontalPlane
//        view.addSubview(coachingOverlay)
//
//
//        context.coordinator.view = view
//        session.delegate = context.coordinator
//
//
//        view.addGestureRecognizer(
//            UITapGestureRecognizer(
//                target: context.coordinator,
//                action: #selector(Coordinator.handleTap)
//            )
//        )
//
//        return view
//
//    }
//
//    func updateUIView(_ uiView: ARView, context: Context) {
//
//    }
//
//    func makeCoordinator() -> Coordinator {
//        Coordinator()
//    }
//
//    class Coordinator: NSObject, ARSessionDelegate {
//        weak var view: ARView?
//        var focusEntity: FocusEntity?
//
//        func session(_ session: ARSession, didAdd anchors: [ARAnchor]) {
//            guard let view = self.view else { return }
//            debugPrint("Anchors added to the scene: ", anchors)
//            self.focusEntity = FocusEntity(on: view, style: .classic(color: .yellow))
//        }
//
//        @objc func handleTap() {
//            guard let view = self.view, let focusEntity = self.focusEntity else { return }
//
//
//            if FirstState == true {
//                view.scene.anchors.append(anchor)
//
//                if ARModelStatus == 1 {
//                    modelEntity = try! ModelEntity.loadModel(named: "body")
//                    modelEntity.position = focusEntity.position
//                }
//                else if ARModelStatus == 2{
//                    modelEntity = try! ModelEntity.loadModel(named: "skeletal")
//                    modelEntity.position = focusEntity.position
//                }
//                else if ARModelStatus == 3{
//                    modelEntity = try! ModelEntity.loadModel(named: "muscular")
//                    modelEntity.position = focusEntity.position
//                }
//
////                let newSwitch = RUISwitch(
////                    RUI: RUIComponent(respondsToLighting: true),
////                    changedCallback: { mySwitch in
////                        modelEntity.model?.materials = [
////                            SimpleMaterial(
////                                color: mySwitch.isOn ? .green : .red,
////                                isMetallic: false
////                            )]})
////
////
////                newSwitch.scale = [0.1, 0.1, 0.1]
////                //newSwitch.position = focusEntity.position
////                var newSwitchOrientation = simd_quatf()
////                newSwitchOrientation = simd_quatf(angle: 0 ,axis: simd_float3(x: 0,y: 1, z: 0))
////                newSwitch.orientation = newSwitchOrientation
////                anchor.addChild(newSwitch)
//
//
//                let boardEntity = try! ModelEntity.loadModel(named: "board")
//                boardEntity.position = focusEntity.position + [1,0,-1.05]
//                boardEntity.scale = [0.0014,0.0012,0.0012]
//                var boardOrientation = simd_quatf()
//                boardOrientation = simd_quatf(angle: 3.14 ,axis: simd_float3(x: 0,y: 1, z: 0))
//                boardEntity.orientation = boardOrientation
//                anchor.addChild(boardEntity)
//
//                let button0 = RUIButton(updateCallback: { myButton in
//                    if Answers[QNo] == 0 {
//                        myButton.buttonColor = .systemGreen
//                    }
//                    else{
//                        myButton.buttonColor = .systemRed
//                    }
//
//                })
//                let button1 = RUIButton(updateCallback: { myButton in
//                    if Answers[QNo] == 1 {
//                        myButton.buttonColor = .systemGreen
//                    }
//                    else{
//                        myButton.buttonColor = .systemRed
//                    }
//
//                })
//                let button2 = RUIButton(updateCallback: { myButton in
//                    if Answers[QNo] == 2 {
//                        myButton.buttonColor = .systemGreen
//                    }
//                    else{
//                        myButton.buttonColor = .systemRed
//                    }
//
//                })
//                let button3 = RUIButton(updateCallback: { myButton in
//                    if Answers[QNo] == 3 {
//                        myButton.buttonColor = .systemGreen
//                    }
//                    else{
//                        myButton.buttonColor = .systemRed
//                    }
//
//                })
//
//                button0.scale = [0.1, 0.1, 0.1]
//                button1.scale = [0.1, 0.1, 0.1]
//                button2.scale = [0.1, 0.1, 0.1]
//                button3.scale = [0.1, 0.1, 0.1]
//
//                button0.position = focusEntity.position + [0.2,0.4,-1]
//                button1.position = focusEntity.position + [1,0.4,-1]
//                button2.position = focusEntity.position + [0.2,0.2,-1]
//                button3.position = focusEntity.position + [1,0.2,-1]
//
//                var bOrientation = simd_quatf()
//                bOrientation = simd_quatf(angle: 3.14 ,axis: simd_float3(x: 0,y: 1, z: 0))
//                button0.orientation = bOrientation
//                button1.orientation = bOrientation
//                button2.orientation = bOrientation
//                button3.orientation = bOrientation
//                anchor.addChild(button0)
//                anchor.addChild(button1)
//                anchor.addChild(button2)
//                anchor.addChild(button3)
//
//
//                let pecEntity = try! ModelEntity.loadModel(named: "pec")
//                pecEntity.position = focusEntity.position
//                modelEntity.scale = [0.005, 0.005, 0.005]
//                var pecOrientation = simd_quatf()
//                pecOrientation = simd_quatf(angle: 0 ,axis: simd_float3(x: 0,y: 1, z: 0))
//                pecEntity.orientation = pecOrientation
//                anchor.addChild(pecEntity)
//
//                let question = RUIText(with: Questions[QNo])
//                question.position = focusEntity.position + [1,0.7,-1]
//                question.scale = [0.175,0.175,0.175]
//                var questionOrientation = simd_quatf()
//                questionOrientation = simd_quatf(angle: 3.14 ,axis: simd_float3(x: 0,y: 1, z: 0))
//                question.orientation = questionOrientation
//                anchor.addChild(question)
//
//                let option = RUIText(with: "\(Options[QNo][0])               \(Options[QNo][1])\n\n\(Options[QNo][2])               \(Options[QNo][3])")
//                option.position = focusEntity.position + [1,0.3,-1]
//                option.scale = [0.15,0.15,0.15]
//                var optionOrientation = simd_quatf()
//                optionOrientation = simd_quatf(angle: 3.14 ,axis: simd_float3(x: 0,y: 1, z: 0))
//                option.orientation = optionOrientation
//                anchor.addChild(option)
//
//
//
//
//                savedModelEntity.position = focusEntity.position
//                FirstState = false
//            }
//
//            else {
//                anchor.removeChild(modelEntity)
//                view.scene.anchors.append(anchor)
//
//                if ARModelStatus == 1 {
//                    modelEntity = try! ModelEntity.loadModel(named: "body")
//                    modelEntity.position = savedModelEntity.position
//                }
//                else if ARModelStatus == 2{
//                    modelEntity = try! ModelEntity.loadModel(named: "skeletal")
//                    modelEntity.position = savedModelEntity.position
//                }
//                else if ARModelStatus == 3{
//                    modelEntity = try! ModelEntity.loadModel(named: "muscular")
//                    modelEntity.position = savedModelEntity.position
//                }
//
//            }
//
//
//
//
//            modelEntity.scale = [0.005, 0.005, 0.005]
//            var var_simd_quatf = simd_quatf()
//            var_simd_quatf = simd_quatf(angle: 0 ,axis: simd_float3(x: 0,y: 1, z: 0))
//            modelEntity.orientation = var_simd_quatf
//            anchor.addChild(modelEntity)
//
//
//        }
//    }
//
//}
//
//
//#if DEBUG
//struct AR_Previews : PreviewProvider {
//    static var previews: some View {
//        AR()
//    }
//}
//#endif
