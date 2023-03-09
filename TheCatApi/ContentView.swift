//
//  ContentView.swift
//  TheCatApi
//
//  Created by Oscar David Myerston Vega on 8/03/23.
//

import SwiftUI
import Combine

struct ContentView: View {

    @StateObject var viewModel = ViewModelCat(apiCats: ApiCats())

    var body: some View {
        NavigationView{
            VStack {
                List(viewModel.breeds) { breed in
                    VStack {
                        Text(breed.breedName)
                            .frame(alignment: .leading)
                            .fontWeight(.bold)
                            .font(.title)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        ImageBreed(urlString: breed.imageUrl)
                        HStack {
                            Text(breed.origin)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .frame(alignment: .leading)
                                .fontWeight(.bold)
                                .font(.title)
                            Text("\(breed.intelligence)")
                                .frame(maxWidth: .infinity,alignment: .trailing)
                                .frame(alignment: .leading)
                                .fontWeight(.bold)
                                .font(.title)
                        }
                    }
                }
            }
            .padding()
            .task {
                await viewModel.getCats()
            }
            .navigationBarTitle("Catbreeds", displayMode: .inline)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
