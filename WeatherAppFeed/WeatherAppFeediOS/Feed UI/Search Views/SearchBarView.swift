//
//  SearchBarView.swift
//  WeatherAppFeediOS
//
//  Created by Khristoffer Julio on 1/17/24.
//

import SwiftUI

struct SearchBarView: View {
    typealias SearchCallBack = ((String) -> Void)
     
    private let searchCallBack: () -> Void
    
    public init(searchCallback: @escaping () -> Void) {
        self.searchCallBack = searchCallback
    }
    
    var body: some View {
        VStack {
            Button(action: {
                searchCallBack()
            }, label: {
                Image(systemName: "location.magnifyingglass")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .foregroundColor(.white.opacity(0.5))
                    .padding()
                    .overlay(
                        Circle().stroke(.white.opacity(0.2), lineWidth: 7)
                    )
                    .background(
                        .black.opacity(0.9)
                    )
                    .clipShape(Circle())
            })
            .contentTransition(.opacity)
        }
        .frame(maxWidth: .infinity, 
               maxHeight: .infinity,
               alignment: .bottomTrailing)
        .padding(.bottom, 100)
        .padding(.trailing, 15)
        .safeAreaPadding()
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
