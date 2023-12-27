//
//  ContentView.swift
//  SwiftUITinderTrip
//
//  Created by Simon Ng on 3/8/2022.
//

import SwiftUI

struct ContentView: View {
  
    var body: some View {
        CardView(image:"yosemite-usa",title:"Yosemita-USA")
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


struct CardView: View{
    let image: String
    let title: String
    var body: some View{
        Image(image)
            .resizable()
            .scaledToFill()
            .frame(minWidth:0, maxWidth: .infinity)
            .cornerRadius(10)
            .padding(.horizontal,15)
            .overlay(alignment: .bottom){
                VStack{
                    Text(title)
                        .font(.system(.headline, design: .rounded))
                        .fontWeight(.bold)
                        .padding(.horizontal, 30)
                        .padding(.vertical,10 )
                        .background(Color.white)
                        
                }
                .padding(.bottom,50)
            }
    }
}


