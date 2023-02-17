//
//  ContentView.swift
//  Slot
//
//  Created by Kato Steven Mubiru on 28/12/2022.
//

import SwiftUI

struct ContentView: View {
    
    let symbols = ["gfx-bell", "gfx-cherry", "gfx-coin", "gfx-grape", "gfx-seven", "gfx-strawberry"]
    
    
    @State private var highScore:Int = UserDefaults.standard.integer(forKey: "HighScore")
    @State private var coins: Int = 100
    @State private var bet : Int = 10
    @State private var reels: Array = [0,1,2]
    @State private var showingInfoView: Bool = false
    @State private var isActiveBet10 : Bool = true
    @State private var isActiveBet20 : Bool = false
    @State private var isShowingModal : Bool = false
    @State private var animatingSymbol : Bool = false
    @State private var animatingModal : Bool = false
    //functions
    
    func spinReels(){
       // reels[0] = Int.random(in: 0...symbols.count - 1)
       // reels[1] = Int.random(in: 0...symbols.count - 1)
        //reels[2] = Int.random(in: 0...symbols.count - 1)
        reels = reels.map({_  in
            Int.random(in: 0...symbols.count-1)
        })
        playSound(sound: "spin", type: "mp3")
    }
    func checkWin(){
        if reels[0] == reels[1] && reels[1] == reels[2] && reels[0] == reels[2]{
            playerWins()
            
            if coins > highScore{
                newHighScore()
            }else{
                playSound(sound: "win", type: "mp3")
            }
            
        }else{
            playerLoses()
            
        }
        
    }// check win
    func playerWins(){
        coins = bet * 10
        
        
    }// player wins
    
    func newHighScore(){
        highScore = coins
        UserDefaults.standard.set(highScore, forKey: "HighScore")
        playSound(sound: "high-score", type: "mp3")
        
    }
    func playerLoses(){
        coins -= bet
    }
    func activateBet20(){
        bet = 20
        isActiveBet10 = false
        isActiveBet20 = true
        playSound(sound: "casino-chips", type: "mp3")
    }
    func activateBet10(){
        bet = 10
        isActiveBet20 = false
        isActiveBet10 = true
        playSound(sound: "casino-chips", type: "mp3")
    }
    func isGameOver(){
        if coins <= 0{
            isShowingModal = true
            playSound(sound: "game-over", type: "mp3")
        }
    }
    func resetGame(){
        UserDefaults.standard.set(0, forKey: "HighScore")
        highScore = 0
        coins = 100
        activateBet10()
        playSound(sound: "chimeup", type: "mp3")
        
    }
    
    
    
    var body: some View {
        
        ZStack {
            LinearGradient(gradient:Gradient(colors: [Color("ColorPink") ,Color("ColorPurple")]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .center , spacing: 5) {
                
               LocalView()
                
                Spacer()
                
                HStack {
                    //1st Hstack
                    HStack{
                        
                        Text("Your\nCoins".uppercased())
                            .foregroundColor(.white)
                            .font(.system(size: 10, design: .rounded))
                            .fontWeight(.bold)
                            .multilineTextAlignment(.trailing)
                        Text("\(coins)")
                            .foregroundColor(.white)
                            .fontDesign(.rounded)
                            .fontWeight(.heavy)
                            .font(.title)
                        
                        
                        
                    }// hstack
                    .padding(.vertical, 4)
                    .padding(.horizontal, 16)
                    .frame(minWidth: 128)
                    .background(
                    Capsule()
                        .foregroundColor(Color("ColorBlack"))
                )
                    
                    Spacer()
                    
                    //2nd Hstack
                    HStack{
                        Text("\(highScore)")
                            .foregroundColor(.white)
                            .fontDesign(.rounded)
                            .fontWeight(.heavy)
                            .font(.title)
                        Text("High\nScore".uppercased())
                            .foregroundColor(.white)
                            .font(.system(size: 10, design: .rounded))
                            .fontWeight(.bold)
                            .multilineTextAlignment(.leading)
                      
                        
                        
                        
                    }// hstack
                    .padding(.vertical, 4)
                    .padding(.horizontal, 16)
                    .frame(minWidth: 128)
                    .background(
                    Capsule()
                        .foregroundColor(Color("ColorBlack"))
                )
                }//outer hstack
                
                VStack(alignment: .center, spacing: 0){
                    
                    //reel 1
                    ZStack {
                        RealView()
                        Image(symbols[reels[0]])
                            .resizable()
                            .scaledToFit()
                            .frame(minWidth: 140, idealWidth: 200, maxWidth: 220, minHeight: 130, idealHeight: 190, maxHeight: 200, alignment: .center)
                            .opacity(animatingSymbol ? 1 : 0)
                            .offset(y: animatingSymbol ? 0 : -50)
                            .animation(.easeOut(duration:Double.random(in: 1.5...1.8)))
                            .onAppear {
                                self.animatingSymbol.toggle()
                                    playSound(sound: "riseup", type: "mp3")
                            }
                    }// zstack
                    
                    //reel 2
                    HStack(alignment: .center, spacing: 0){
                        ZStack {
                            RealView()
                            Image(symbols[reels[1]])
                                .resizable()
                                .scaledToFit()
                                .frame(minWidth: 140, idealWidth: 200, maxWidth: 220, minHeight: 130, idealHeight: 190, maxHeight: 200, alignment: .center)
                                .opacity(animatingSymbol ? 1 : 0)
                                .offset(y: animatingSymbol ? 0 : -50)
                                .animation(.easeOut(duration:Double.random(in: 0.9...1.5)))
                                .onAppear {
                                    self.animatingSymbol.toggle()
                                }
                        }// zstack
                        ZStack {
                            RealView()
                            Image(symbols[reels[2]])
                                .resizable()
                                .scaledToFit()
                                .frame(minWidth: 140, idealWidth: 200, maxWidth: 220, minHeight: 130, idealHeight: 190, maxHeight: 200, alignment: .center)
                                .opacity(animatingSymbol ? 1 : 0)
                                .offset(y: animatingSymbol ? 0 : -50)
                                .animation(.easeOut(duration:Double.random(in: 0.4...0.8)))
                                .onAppear {
                                    self.animatingSymbol.toggle()
                                }
                        }// zstack
                        
                        
                    }//end of hstack
                    
                    //reel 3
                    
                    
                    //spin button
                    
                    Button(action:{
                      //spin the wheels
                        withAnimation {
                            self.animatingSymbol = false
                        }// animation
                        self.spinReels()
                        withAnimation {
                            self.animatingSymbol = true
                        }
                        
                        self.checkWin()
                        
                        
                        // game over
                        self.isGameOver()
                    }){
                        Image("gfx-spin")
                            .resizable()
                            .scaledToFit()
                            .frame(minWidth: 140, idealWidth: 200, maxWidth: 220, minHeight: 130, idealHeight: 190, maxHeight: 200, alignment: .center)
                        
                    }
                    
                    
                    
                }// end of vstack//slot machine
                .layoutPriority(2)
                
                Spacer()
                
                HStack{
                    
                    HStack(alignment: .center, spacing: 10) {
                        Button(action:{
                            self.activateBet20()
                        }){
                            Text("20")
                                .fontWeight(.heavy)
                                .foregroundColor(isActiveBet20 ? Color.yellow : Color.white)
                                .font(.title)
                                .fontDesign(.rounded)
                                .frame(width: 90)
                        }
                        .background(
                        Capsule()
                            .fill(LinearGradient(gradient: Gradient(colors: [Color("ColorPink"), Color("ColorPurple")]), startPoint: .top, endPoint: .bottom))
                        )
                        .padding(3)
                        .background(
                            Capsule()
                                .fill(LinearGradient(gradient: Gradient(colors: [Color("ColorPink"), Color("ColorPurple")]), startPoint: .bottom, endPoint: .top))
                    )
                        Image("gfx-casino-chips")
                            .resizable()
                            .scaledToFit()
                            .offset(x : isActiveBet20 ? 0 : 20 )
                            .opacity(isActiveBet20 ? 1 : 0)
                            .frame(height: 64)
                            .animation(.default)
                        
                    }// button Hstack
                    Spacer()
                    
                    HStack(alignment: .center, spacing: 10) {
                        
                        Image("gfx-casino-chips")
                            .resizable()
                            .scaledToFit()
                            .offset(x : isActiveBet10  ? 0 : -20)
                            .opacity(isActiveBet10 ? 1 : 0)
                            .frame(height: 64)
                            .animation(.default)
                        
                        Button(action:{
                            self.activateBet10()
                        }){
                            Text("10")
                                .fontWeight(.heavy)
                                .foregroundColor(isActiveBet10 ? Color.yellow : Color.white)
                                .font(.title)
                                .fontDesign(.rounded)
                                .frame(width: 90)
                        }
                        .background(
                        Capsule()
                            .fill(LinearGradient(gradient: Gradient(colors: [Color("ColorPink"), Color("ColorPurple")]), startPoint: .top, endPoint: .bottom))
                        )
                        .padding(3)
                        .background(
                            Capsule()
                                .fill(LinearGradient(gradient: Gradient(colors: [Color("ColorPink"), Color("ColorPurple")]), startPoint: .bottom, endPoint: .top))
                    )
                        
                        
                    }// button Hstack
                    
                }//hstack
                
                
                
            }// vstack
            .overlay(
            
                Button(action: {
                    
                    self.resetGame()
                    
                }){
                    Image(systemName: "arrow.2.circlepath.circle")
                }
                    .modifier(buttonModifier()),
                alignment: .topLeading
            
            )// end of overlay
            .overlay(
            
                Button(action: {
                    
                    self.showingInfoView = true
                    
                }){
                    Image(systemName: "info.circle")
                }
                    .modifier(buttonModifier()),
                alignment: .topTrailing
            
            )
            
            .padding()
            .frame(maxWidth: 720)
            .blur(radius: $isShowingModal.wrappedValue ? 5 : 0 , opaque: false)
            
            // popup
            if $isShowingModal.wrappedValue{
                ZStack{
                    Color("ColorBlack").edgesIgnoringSafeArea(.all)
                    VStack(spacing : 0){
                        Text("GAME OVER")
                            .font(.title)
                            .fontDesign(.rounded)
                            .fontWeight(.heavy)
                            .padding()
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .cornerRadius(12)
                            .background(Color("ColorPink"))
                            .foregroundColor(.white)
                        
                        Spacer()
                        
                        VStack(alignment: .center, spacing: 16){
                            Image("gfx-seven-reel")
                                .resizable()
                                .scaledToFit()
                                .frame(maxHeight: 70)
                            
                            Text("Bad luck! You lost all of the coins\n Play again 🤝 .")
                                .font(.body)
                                .fontDesign(.rounded)
                                .foregroundColor(.gray)
                                .multilineTextAlignment(.center)
                                .layoutPriority(1)
                            
                            Button {
                                self.animatingModal = false
                                self.isShowingModal = false
                                self.activateBet10()
                                self.coins = 100
                            } label: {
                                
                                Text("NEW GAME")
                                    .fontDesign(.rounded)
                                    .fontWeight(.semibold)
                                    //.foregroundColor(Color("ColorPink"))
                                    .accentColor(Color("ColorPink"))
                                    .padding(.horizontal, 12)
                                    .padding(.vertical,8)
                                    .frame(minWidth: 128)
                                    .background(
                                    Capsule()
                                        .strokeBorder(lineWidth: 1.8)
                                        .foregroundColor(Color("ColorPink"))
                                    )
                            }

                        }
                        Spacer()
                    }
                    .cornerRadius(12)
                    .frame(minWidth: 280, idealWidth: 280, maxWidth:  220, minHeight: 260, idealHeight: 280, maxHeight: 320, alignment: .center)
                    .background {
                        Color.white
                            .cornerRadius(12)
                    }
                    .opacity($animatingModal.wrappedValue ? 1 : 0)
                    .offset(y: $animatingModal.wrappedValue ? 0 : -100)
                    .animation(Animation.spring(response: 0.6, dampingFraction: 1.0 , blendDuration: 1.0))
                    .onAppear {
                        self.animatingModal = true
                    }
                }
            }//if
        }// Zstack
        .sheet(isPresented: $showingInfoView) {
            InfoView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
