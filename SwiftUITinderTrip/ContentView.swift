//
//  ContentView.swift
//  SwiftUITinderTrip
//
//  Created by Simon Ng on 3/8/2022.
//

import SwiftUI

struct ContentView: View {
  
    
    var body: some View {
        VStack{
            TopBarMenu()
            CardView(image:"yosemite-usa",title:"Yosemita-USA")
            BottomBarMenu()
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        
        TopBarMenu()
            .previewDisplayName("Top Bar Menu")
        
        BottomBarMenu()
            .previewDisplayName("Bottom Bar Menu")
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


struct TopBarMenu: View{
    var body: some View{
        HStack{
            Image(systemName:"line.horizontal.3")
                .font(.system(size: 30))
            Spacer()
            Image(systemName:"mappin.and.ellipse")
                .font(.system(size:35))
            Spacer()
            Image(systemName:"heart.circle.fill")
                .font(.system(size:30))
        }
        .padding()
    }
}

struct BottomBarMenu: View{
    var body: some View{
        HStack{
            Image(systemName:"xmark")
                .font(.system(size: 30))
                .foregroundColor(.black)
            Spacer()
            Button{
                
            }
        label:{
            Text("Book it now")
                .font(.system(.subheadline,design:.rounded))
                .bold()
                .foregroundColor(.white)
                .padding(.horizontal, 35)
                .padding(.vertical, 15)
                .background(Color.black)
                .cornerRadius(5)
        }
            Spacer()
            Image(systemName:"heart")
                .font(.system(size:30))
                .foregroundColor(.black)
        }
        .padding()
    }
}
