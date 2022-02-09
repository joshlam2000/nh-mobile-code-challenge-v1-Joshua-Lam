//
//  ClinicianDriveCalculatorView.swift
//  NiceClinicianDriveCalculator
//
//  Created by Josh Lam on 2/6/22.
//

import SwiftUI

struct ClinicianIdealDriveCalculatorView: View {
    
    @StateObject var viewModel = ClinicianIdealDriveCalculatorViewModel()
    
    var body: some View {
        NavigationView {
            Form(content: {
                Section(header: Text("Patient Information (please provide all information below)")) {
                    VStack {
                        TextField("Address Line 1", text: $viewModel.address1)
                            .accessibility(identifier: "calFormAddr1TextField")
                        TextField("City", text: $viewModel.city)
                            .accessibility(identifier: "calFormCityTextField")
                        Picker("State", selection: $viewModel.state) {
                            ForEach(ClinicianIdealDriveCalculatorViewModel.USStates.allCases) {
                                aState in Text(aState.rawValue).tag(aState)
                            }
                        }
                        .accessibility(identifier: "calFormStatePicker")
                        TextField("Zip", text: $viewModel.zip)
                            .accessibility(identifier: "calFormZipTextField")
                        Toggle(isOn:$viewModel.includeLab) {
                            Text("Include Lab")
                        }
                        //.accessibility(identifier: "calFormIncludeLabSwitch")
                    } // end VStack
                } // end Section
                
                Section(header: Text("")) {
                    Button("Get Optimal Clinician") { 
                        viewModel.validateForm()
                        viewModel.isPresented.toggle()
                    }
                    .fullScreenCover(isPresented: $viewModel.isPresented, content: {ClinicianDisplayView(viewModel: ClinicianDisplayViewModel(patient: viewModel.determineMostIdealClinicianForPatient()))})
                    .accessibility(identifier: "calFormOptimalClinicanButton")
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
                    Button("Reset") {
                        viewModel.reset()
                    }
                    .accessibility(identifier: "calFormResetButton")
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
                }
            }) // end Form
                .navigationBarTitle("The Nice Optimal Clinician Finder", displayMode: .inline)
                .onAppear{
                    viewModel.setup()
                }
                .alert(item: $viewModel.appError) { appError in
                    Alert(title: Text("Oops"), message: Text(appError.error.localizedDescription))
                    
                }
        } // end NavigationView
    }
}

struct ClinicianIdealDriveCalculatorView_Previews: PreviewProvider {
    static var previews: some View {
        ClinicianIdealDriveCalculatorView()
    }
}
