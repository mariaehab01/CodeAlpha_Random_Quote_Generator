//
//  ContentView.swift
//  Random Quote Generator
//
//  Created by Maria Ehab
//


import SwiftUI

struct ContentView: View {
    @State private var quote: String = "Unlock Your Inspiration Today!"
    
    var body: some View {
        ZStack {
            Image("background")
                .resizable()
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Spacer()
                
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.gray, lineWidth: 2)
                        .frame(width: 302, height: 203)
                       
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.white)
                        .frame(width: 300, height: 200)
                       
                    Text(quote)
                        .font(.title)
                        .foregroundColor(.black)
                        .multilineTextAlignment(.center)
                        .padding()
                        .lineLimit(3)
                        .frame(width: 280)
                }
                
                Text("Tap 'Generate' to get a random quote")
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundColor(Color.white)
                    .padding(.top, 20)
                Spacer()
                
                HStack {
                    Button(action: { generate() }) {
                        Image("Generate")
                            .resizable()
                            .frame(width: 130,height: 50)
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        shareQuote()
                    }) {
                        HStack(spacing: 5) {
                            Image(systemName:"square.and.arrow.up")
                                .font(.title)
                            Text("Share")
                                .font(.headline)
                                .padding(.top, 8.0)
                                
                        }
                        .foregroundColor(.blue)
                        .padding(3)
                        .cornerRadius(10)
                            
                    }
                    .padding()
                }
                .padding(.horizontal, 20)
                
                Spacer()
            }
        }
    }
    
    func generate() {
        QuoteFetcher.fetchRandomQuote { fetchedQuote in
            if let fetchedQuote = fetchedQuote {
                quote = fetchedQuote
            } else {
                quote = "Failed to fetch quote"
            }
        }
    }
    
    func shareQuote() {
        
        let activityViewController = UIActivityViewController(activityItems: [quote], applicationActivities: nil)
        UIApplication.shared.windows.first?.rootViewController?.present(activityViewController, animated: true, completion: nil)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}





