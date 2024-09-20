//
//  LimitInfo.swift
//  caffX Reloaded
//
//  Created by Avyan Mehra on 13/9/24.
//

import SwiftUI

struct LimitInfo: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    Group {
                        Text("**Adults**")
                            .font(.title3)
                        
                        Text("Safe daily limit: Up to **400 mg** of caffeine (**4-5 cups of coffee**).")
                        
                        Text("Health effects: Temporary increases in heart rate, blood pressure, and stomach acid secretion. May act as a diuretic. Common neurologic effects include tremors and heightened anxiety.")
                        
                        Text("Tolerance: Regular use can lead to tolerance, requiring higher doses for the same effect.")
                        
                        Text("Withdrawal: Abrupt cessation may cause headaches, irritability, and drowsiness.")
                    }
                    .padding(.bottom, 10)
                    
                    Group {
                        Text("**Teens (Ages 12-18)**")
                            .font(.title3)
                        
                        Text("Recommended limit: Up to **100 mg** of caffeine (about **1 cup of coffee**, **1-2 cups of tea**, or **2-3 cans of soda**).")
                        
                        Text("Adverse effects: May experience heightened anxiety, diarrhea, and dehydration. Caffeine use can also disrupt sleep quality and duration.")
                        
                        Text("Sensitivity: Adolescents can be more sensitive to caffeine's effects, especially when consumed in the afternoon or evening.")
                    }
                    .padding(.bottom, 10)
                    
                    Group {
                        Text("**Children (Under 12)**")
                            .font(.title3)
                        
                        Text("Safe daily limit: There is **no designated safe threshold** for children under 12.")
                        
                        Text("Caffeine consumption among children: **73% of children** consume caffeine daily (2014 study).")
                    }
                    .padding(.bottom, 10)
                    
                    Group {
                        Text("**Health Risks**")
                            .font(.title3)
                        
                        Text("High levels of caffeine ingestion can cause dangerous heart arrhythmias, hallucinations, or seizures.")
                    }
                    .padding(.bottom, 10)
                    
                    Group {
                        Text("**Onset of Effects**")
                            .font(.title3)
                        
                        Text("Caffeine enters the bloodstream and takes effect within **15 minutes** of consumption.")
                    }
                }
                .padding()
            }
            .navigationTitle("Caffeine Limits")
        }
    }
}

#Preview {
    LimitInfo()
}
