//
//  ContentView.swift
//  CoreTest2 WatchKit Extension
//
//  Created by 전지민 on 2022/08/31.
//

import SwiftUI
import CoreMotion

struct ContentView: View {
    
    var motionManager = CMMotionManager()
    @State var accelorationX  = 0.0
    @State var accelorationY  = 0.0
    @State var accelorationZ  = 0.0
    
//    static var result: [Double] = [0.0, 0.0, 0.0]
    @State var result = ""
    
    var body: some View {
        VStack {
        
            Text(result)
            Text("Test")
            Text("\(accelorationX)")
            Text("\(accelorationY)")
            Text("\(accelorationZ)")
            
            Button(/*@START_MENU_TOKEN@*/"Button"/*@END_MENU_TOKEN@*/) {
                self.result = motionManage()
            }
        }
        
    }
    
    func motionManage() -> String {
        motionManager.accelerometerUpdateInterval = 0.2
        motionManager.gyroUpdateInterval = 0.2
        
        var string = ""
        
        motionManager.startAccelerometerUpdates(to: OperationQueue.current!) { accelerometerData, error in
            
            string = ""
            if (accelerometerData?.acceleration.x ?? 0.0) - self.accelorationX > 1.0 {
                string += "X+ "
            }else {
                string += "X- "
            }
            if (accelerometerData?.acceleration.y ?? 0.0) - self.accelorationY > 1.0 {
                string += "Y+ "
            } else {
                string += "Y- "
            }
            if (accelerometerData?.acceleration.z ?? 0.0) - self.accelorationZ > 1.0 {
                string += "Z+ "
            } else {
                string += "Z- "
            }
            
            print(string)
            DispatchQueue.main.async {
                result = string
            }
            self.accelorationX = accelerometerData?.acceleration.x ?? 0.0
            self.accelorationY = accelerometerData?.acceleration.y ?? 0.0
            self.accelorationZ = accelerometerData?.acceleration.z ?? 0.0
        }
        
        return string
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
