//
//  ClinicianDisplayView.swift
//  NiceClinicianDriveCalculator
//
//  Created by Josh Lam on 2/6/22.
//

import SwiftUI


struct ClinicianDisplayView: View {
    @Environment(\.presentationMode) var presentationMode
    var viewModel: ClinicianDisplayViewModel
    var patient: Patient?
    
    var body: some View {
        VStack ( spacing: 20){
            Text("Nice! We Found The Optimal Clinician")
                .bold()
                .padding()
            HStack{
                VStack(alignment: .leading, spacing: 5) {
                    HStack {
                        Text("Optimal Clinician To Send: ")
                            .bold()
                        Text(viewModel.idealClinicianName)
                            .accessibility(identifier: "clinicanViewIdealClinicianText")
                    }
                    HStack {
                        Text("Optimal Driving Distance (miles): ")
                            .bold()
                        Text(String(viewModel.idealDistance))
                            .accessibility(identifier: "clinicanViewIdealDistanceText")
                    }
                    HStack{
                    }
                    Text("Patient Address:")
                        .bold()
                    Text(viewModel.patientAddress)
                        .accessibility(identifier: "clinicanViewPatientAddrText")
                        
                    HStack {
                        Text("Include Lab: ")
                            .bold()
                        Text(viewModel.labInclude())
                            .accessibility(identifier: "clinicanViewLabIncludedText")
                    }
                    
                }.frame (alignment: (.leading))
            }
            Text("In case of emergency please call 911!").bold().background(.red)
            Button("Dismiss") {
                presentationMode.wrappedValue.dismiss()
            }
            .accessibility(identifier: "clinicanViewIdealDismissButton")
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .edgesIgnoringSafeArea(.all)
        .onTapGesture {
            presentationMode.wrappedValue.dismiss()
        }
    }
    
}


//struct ClinicianDisplayView_Previews: PreviewProvider {
//    
//    static var previews: some View {
//        
//    }
//}
