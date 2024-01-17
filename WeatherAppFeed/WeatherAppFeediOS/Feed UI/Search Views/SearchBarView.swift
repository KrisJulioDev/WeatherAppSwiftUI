//
//  SearchBarView.swift
//  WeatherAppFeediOS
//
//  Created by Khristoffer Julio on 1/17/24.
//

import SwiftUI

struct SearchBarView: View {
    @State private var isSearching: Bool = false
    @State private var textInput: String = ""
    @FocusState private var isFocused: Bool
    
    private var heightWidth: CGFloat { 30 }
    
    var body: some View {
        VStack {
            Spacer()
            
            HStack {
                if isSearching {
                    TextField("", text: $textInput)
                        .toolbar {
                            ToolbarItem(placement: .keyboard) {
                                HStack {
                                    TextField("Enter a location", text: $textInput)
                                        .font(.headline)
                                        .multilineTextAlignment(.center)
                                        .foregroundStyle(.primary)
                                        .textFieldStyle(.roundedBorder)
                                        .frame(height: 80)
                                    Button(action: {
                                        toggleStates()
                                    }, label: {
                                        Text("Search")
                                            .foregroundStyle(.gray)
                                            .font(.headline)
                                            .padding(.horizontal, 20)
                                            .padding(.vertical, 10)
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 30).stroke(.gray.opacity(0.25), lineWidth: 7)
                                            )
                                            .background(
                                                .black.opacity(0.9)
                                            )
                                            .clipShape(RoundedRectangle(cornerRadius: 30))
                                    })
                                }
                            }
                        }
                        .focused($isFocused)
                }
                
                Button(action: {
                    withAnimation {
                        toggleStates()
                    }
                }, label: {
                    Image(systemName: "location.magnifyingglass")
                        .resizable()
                        .frame(width: heightWidth, height: heightWidth)
                        .foregroundColor(.orange)
                        .padding()
                        .overlay(
                            Circle().stroke(.orange.opacity(0.25), lineWidth: 7)
                        )
                        .background(
                            .black.opacity(0.9)
                        )
                        .clipShape(Circle())
                })
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
            .padding()
        }
        .safeAreaPadding(.vertical, 80)
        .ignoresSafeArea(.keyboard, edges: .bottom)
    }
    
    private func toggleStates() {
        isSearching.toggle()
        isFocused.toggle()
        textInput = ""
    }
}

#Preview {
    NavigationStack {
        WeatherFeedViewPresenter().compose()
            .navigationTitle("Weather app")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarBackground(.black.opacity(0.05), for: .navigationBar)
    }

}
