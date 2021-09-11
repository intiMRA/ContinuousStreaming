//
//  ContentView.swift
//  EndlessStream
//
//  Created by Inti Albuquerque on 11/09/21.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ViewModel()
    var body: some View {
        VStack(spacing: 10) {
            ZStack {
                RoundedRectangle(cornerRadius: 5)
                    .foregroundColor(.textFieldBackground)
                                
                TextField("", text: $viewModel.name)
                    .foregroundColor(.white)
                    .padding(.leading, 10)
                if viewModel.name.isEmpty {
                    Text("Enter a name")
                    .foregroundColor(.white.opacity(0.7))
                }
            }
            .frame(height: 50, alignment: .center)
            
            Button("Submit Name") {
                self.viewModel.submit = ()
            }
            .foregroundColor(.white)
            .padding()
            .background(Color.buttonBackGround)
            .cornerRadius(8)
        }
        .padding(.horizontal, 20)
        .alert(isPresented: $viewModel.showAlert) {
            Alert(title: Text(self.viewModel.alertContent.title), message: Text(self.viewModel.alertContent.message))
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.background)
        .ignoresSafeArea()
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
