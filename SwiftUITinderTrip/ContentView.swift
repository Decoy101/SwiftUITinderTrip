//
//  ContentView.swift
//  SwiftUITinderTrip
//
//  Created by Simon Ng on 3/8/2022.
//

import SwiftUI

struct ContentView: View {
   @State var cardViews: [CardView] = {
        var views  = [CardView]()
        for index in 0..<2 {
            views.append(CardView(image: trips[index].image,title: trips[index].destination))
        }
        return views
    }()
    
    private func moveCard() {
        cardViews.removeFirst()
        self.lastIndex += 1
        let trip = trips[lastIndex % trips.count]
        let newCardView = CardView(image: trip.image, title: trip.destination) 
        cardViews.append(newCardView)
    }
    
    
    
    private func isTopCard(cardView: CardView) -> Bool {
    guard let index = cardViews.firstIndex(where: { $0.id == cardView.id }) else { return false
    }
        return index == 0
    }
  
    
   
    
    
    @GestureState private var dragState = DragState.inactive
    private let dragThreshold: CGFloat = 80.0
    @State private var lastIndex = 1
    
   
    
    var body: some View {
        VStack{
            TopBarMenu()
            ZStack {
                ForEach(cardViews) { cardView in
                    cardView
                        .zIndex(self.isTopCard(cardView: cardView) ? 1 : 0)
                        .overlay{
                            ZStack{
                                Image(systemName: "x.circle")
                                    .foregroundColor(.white)
                                    .font(.system(size: 100))
                                    .opacity(self.dragState.translation.width < -self.dragThreshold && self.isTopCard(cardView: cardView) ? 1.0 : 0)
                                
                                Image(systemName: "heart.circle")
                                    .foregroundColor(.white)
                                    .font(.system(size: 100))
                                    .opacity(self.dragState.translation.width > self.dragThreshold && self.isTopCard(cardView: cardView) ? 1.0 : 0)
                            }
                        }
                    
                    
                        .offset(x: self.isTopCard(cardView: cardView) ? self.dragState.translation.width : 0, y: self.isTopCard(cardView: cardView) ?  self.dragState.translation.height : 0)
                        .scaleEffect(self.dragState.isDragging && self.isTopCard(cardView: cardView) ? 0.95 : 1.0)
                        .rotationEffect(Angle(degrees: Double(self.isTopCard(cardView: cardView) ? self.dragState.translation.width/10 : 0)))
                        .animation(.interpolatingSpring(stiffness:180, damping: 100), value: self.dragState.translation)
                        .gesture(LongPressGesture(minimumDuration:0.01).sequenced(before: DragGesture())
                            .updating(self.$dragState, body:{(value,state, transaction)in
                                switch value{
                                case .first(true):
                                    state = .pressing
                                case .second(true, let drag):
                                    state = .dragging(translation: drag?.translation ?? .zero)
                                default:
                                    break
                                }
                            })
                                .onEnded({ (value) in
                                    guard case .second(true, let drag?) = value else{
                                        return
                                    }
                                    
                                    if drag.translation.width < -self.dragThreshold ||
                                        drag.translation.width > self.dragThreshold{
                                        self.moveCard()
                                    }
                                    
                                })
                                 
                                 
                        )
                    
                } }
            BottomBarMenu()
                .opacity(dragState.isDragging ? 0.0 : 1.0)
                .animation(.default, value: dragState.isDragging)
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


struct CardView: Identifiable, View{
    let id = UUID()
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

enum DragState{
    case inactive
    case pressing
    case dragging(translation: CGSize)
    
    var translation: CGSize{
        switch self{
        case .inactive, .pressing:
            return .zero
        case .dragging(let translation):
            return translation
        }
    }
    
    var isDragging: Bool {
            switch self {
            case .dragging:
                return true
            case .pressing, .inactive:
                return false
    } }
        var isPressing: Bool {
            switch self {
            case .pressing, .dragging:
                return true
            case .inactive:
                return false
    } }
    
}


