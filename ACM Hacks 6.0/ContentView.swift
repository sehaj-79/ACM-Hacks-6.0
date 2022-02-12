//
//  ContentView.swift
//  ACM Hacks 6.0
//
//  Created by sehejbir bhasin on 11/02/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack{
            Image("background")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .ignoresSafeArea(.all)
            
            VStack {
                ZStack(alignment: .leading) {
                    Image("rectanglebg")
                    HStack {
                        Image("quizimage")
                            .padding()
                            .offset(y: 2.5)
                        Text("Quiz")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .foregroundColor(Color.white)
                    }
                }
                
                ZStack{
                    Image("rectanglebg")
                        .opacity(0.75)
                        .frame(width: 300)
                        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                    HStack{
                        Spacer()
                        Text("All Topics")
                            .font(.headline)
                            .fontWeight(.medium)
                            .foregroundColor(Color.white)
                            .padding()
                        Spacer()
                        Spacer()
                        Text(">")
                            .font(.headline)
                            .fontWeight(.medium)
                            .foregroundColor(Color.white)
                            .padding()
                        Spacer()
                    }
                }.padding(10)
                    .padding(.top,25)
                    .onTapGesture {
                        //NAVIGATE
                    }
                
                ZStack{
                    Image("rectanglebg")
                        .opacity(0.75)
                        .frame(width: 300)
                        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                    HStack{
                        Spacer()
                        Text("Upper Limbs")
                            .font(.headline)
                            .fontWeight(.medium)
                            .foregroundColor(Color.white)
                            .padding()
                        Spacer()
                        Spacer()
                        Text(">")
                            .font(.headline)
                            .fontWeight(.medium)
                            .foregroundColor(Color.white)
                            .padding()
                        Spacer()
                    }
                }.padding(10)
                
                ZStack{
                    Image("rectanglebg")
                        .opacity(0.75)
                        .frame(width: 300)
                        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                    HStack{
                        Spacer()
                        Text("Thorax")
                            .font(.headline)
                            .fontWeight(.medium)
                            .foregroundColor(Color.white)
                            .padding()
                        Spacer()
                        Spacer()
                        Text(">")
                            .font(.headline)
                            .fontWeight(.medium)
                            .foregroundColor(Color.white)
                            .padding()
                        Spacer()
                    }
                }.padding(10)
                
                ZStack{
                    Image("rectanglebg")
                        .opacity(0.75)
                        .frame(width: 300)
                        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                    HStack{
                        Spacer()
                        Text("Abdomen")
                            .font(.headline)
                            .fontWeight(.medium)
                            .foregroundColor(Color.white)
                            .padding()
                        Spacer()
                        Spacer()
                        Text(">")
                            .font(.headline)
                            .fontWeight(.medium)
                            .foregroundColor(Color.white)
                            .padding()
                        Spacer()
                    }
                }.padding(10)
                
                
                
//                ZStack() {
//                    Image("rectanglebg")
//                        .opacity(0.75)
//                        .frame(width: 300)
//                        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
//
//                    HStack {
//                        Spacer()
//                        Text("All Topics")
//                            .font(.headline)
//                            .fontWeight(.medium)
//                            .foregroundColor(Color.white)
//                            .padding()
//                        Spacer()
//                        Spacer()
//                        Text(">")
//                            .font(.headline)
//                            .fontWeight(.medium)
//                            .foregroundColor(Color.white)
//                            .padding()
//                        Spacer()
//                    }
//                }.padding(.top,40)
//                padding(.bottom,10)

//                ZStack() {
//                    Image("rectanglebg")
//                        .opacity(0.75)
//                        .frame(width: 300)
//                        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
//
//                    HStack {
//                        Spacer()
//                        Text("Upper Limbs")
//                            .font(.headline)
//                            .fontWeight(.medium)
//                            .foregroundColor(Color.white)
//                            .padding()
//                        Spacer()
//                        Spacer()
//                        Text(">")
//                            .font(.headline)
//                            .fontWeight(.medium)
//                            .foregroundColor(Color.white)
//                            .padding()
//                        Spacer()
//                    }
//                }.padding(10)
//
//                ZStack() {
//                    Image("rectanglebg")
//                        .opacity(0.75)
//                        .frame(width: 300)
//                        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
//
//                    HStack {
//                        Spacer()
//                        Text("Lower Limbs")
//                            .font(.headline)
//                            .fontWeight(.medium)
//                            .foregroundColor(Color.white)
//                            .padding()
//                        Spacer()
//                        Spacer()
//                        Text(">")
//                            .font(.headline)
//                            .fontWeight(.medium)
//                            .foregroundColor(Color.white)
//                            .padding()
//                        Spacer()
//                    }
//                }.padding(10)


                Spacer()
            }.offset(y: 50)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
    }
}
