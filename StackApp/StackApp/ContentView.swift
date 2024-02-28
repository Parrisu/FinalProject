//
//  ContentView.swift
//  StackApp
//
//  Created by Parris Jones on 2/27/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        ZStack {
            
            Color(.black).ignoresSafeArea()
            
            VStack() {
                
                AsyncImage(url: URL(string: "https://img.freepik.com/free-photo/web-design-concept-with-drawings_1134-77.jpg?size=626&ext=jpg&ga=GA1.1.996327085.1706734954&semt=sph")) { image in
                    image.resizable().aspectRatio(contentMode: .fit).cornerRadius(15)
                } placeholder: {
                    ProgressView()
                }
                HStack {
                    VStack{
                        Text("No rest for the CSS").fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        Text("\"We make it look good\" - Dave").font(.caption)
                    }
                    
                    
                    Spacer()
                    
                    Image("CSS").resizable().frame(width: 20, height:20)
                    Image("HTML").resizable().frame(width: 20, height:20)
                    Image("Rust").resizable().frame(width: 20, height:20)
                    
                    
                }
                
                
                
            }
            .padding()
            .background(Rectangle()
                .foregroundColor(.yellow)
                .cornerRadius(15)
                .shadow(radius: 15)
            
            )
            .padding()
        }
        
        
        
    }
}

#Preview {
    ContentView()
}
