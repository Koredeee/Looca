//
//  StepNavigationView.swift
//  Looca
//
//  Created by Patricia Putri Art Syani on 09/04/25.
//

import SwiftUI
import MapKit

import SwiftUI
import MapKit

struct StepNavigationView: View {
    @State private var directionSteps: [DirectionStep] = []
    @State private var currentStepIndex = 0
    @Binding var showCompletionScreen: Bool
    @Binding var showStepNavigationView: Bool
    
    let canteen: Canteen
    
    var currentStep: DirectionStep {
        directionSteps[currentStepIndex]
    }
    
    var body: some View {
        ZStack {
            Map{
                Annotation("You Are Here" ,coordinate: currentStep.coordinate){
                    Image("loocaPin") // 👈 your custom image from Assets.xcassets
                        .resizable()
                        .frame(width: 69, height: 93)
                        .offset(x: 0, y: 20)
                        
                }
                
            }
            .ignoresSafeArea(edges: .all)
            
            if showStepNavigationView && !directionSteps.isEmpty {
                VStack {
                    Spacer()
                    
                    VStack {
                        HStack {
                            Image(systemName: currentStep.arrow)
                                .resizable()
                                .frame(width: 28, height: 28)
                                .foregroundColor(Color.white)
                            Text("after \(currentStep.afterMeters)")
                                .font(.caption)
                                .foregroundColor(.white.opacity(0.8))
                            
                        }
                        .padding(.bottom, 5)
                        
                        Image(currentStep.image)
                            .resizable()
                            .scaledToFill()
                            .frame(height: 120)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                            .padding(.bottom, 5)
                        
                        HStack {
                            Button(action: {
                                if currentStepIndex > 0 {
                                    withAnimation {
                                        currentStepIndex -= 1
                                    }
                                }
                            }) {
                                Text("< Previously")
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
                                    .foregroundStyle(Color("MainColor"))
                                    .padding()
                                    .frame(maxWidth: .infinity, maxHeight: 40)
                                    .background(Color.white)
                                    .cornerRadius(12)
                            }
                            
                            Button(action: {
                                if currentStepIndex < directionSteps.count - 1 {
                                    withAnimation { currentStepIndex += 1 }
                                } else {
                                    withAnimation {
                                        showCompletionScreen = true
                                        showStepNavigationView = false
                                    }
                                }
                            }) {
                                Text(currentStepIndex < directionSteps.count - 1 ? "Next >" : "Finish")
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
                                    .foregroundStyle(Color("MainColor"))
                                    .padding()
                                    .frame(maxWidth: .infinity, maxHeight: 40)
                                    .background(Color.white)
                                    .cornerRadius(12)
                            }
                        }
                    }
                    .padding()
                    .background(Color("MainColor"))
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .padding()
                }
            }
        }
        .onAppear {
            directionSteps = canteen.directions.map { direction in
                DirectionStep(
                    description: direction.description,
                    afterMeters: "\(direction.afterMeters) meters",
                    image: direction.image,
                    arrow: getArrowIcon(for: direction.description),
                    coordinate: CLLocationCoordinate2D(latitude: direction.latitude, longitude: direction.longitude)
                )
            }
        }
        
    }
    
    func getArrowIcon(for description: String) -> String {
        let lower = description.lowercased()
        if lower.contains("left") {
            return "arrowshape.left.circle.fill"
        } else if lower.contains("right") {
            return "arrowshape.right.circle.fill"
        } else if lower.contains("straight") || lower.contains("forward") {
            return "arrowshape.up.circle.fill"
        } else if lower.contains("back") {
            return "arrowshape.down.circle.fill"
        }
        return "arrowshape.up.circle.fill"
    }
}


//#Preview {
//    StepNavigationView(showCompletionScreen: <#T##Binding<Bool>#>, showStepNavigationView: <#T##Binding<Bool>#>, canteen: <#T##Canteen#>)
//}
