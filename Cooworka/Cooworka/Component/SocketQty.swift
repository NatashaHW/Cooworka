//
//  SocketQty.swift
//  Cooworka
//
//  Created by Lucinda Artahni on 20/06/24.
//

import SwiftUI

struct SocketQty: View {
    @State private var selectedButtonIndex: Int? = nil
    let labels: [String] = ["0", "1", "2", "3", ">4"]
    let onSelectionChange: (Int) -> Void
    let onFirstTap: () -> Void
    @State private var hasChanged: Bool = false
    
    var body: some View {
        VStack{
            HStack{
                Text("Jumlah stok kontak per meja")
                    .font(.footnote)
                    .fontWeight(.regular)
                    .padding(.bottom, 10)
                
                Spacer()
            }
            HStack(spacing: 10) {
                ForEach(0..<labels.count, id: \.self) { index in
                    QtyComponent(label: labels[index], isSelected: selectedButtonIndex == index) {
                        if selectedButtonIndex != index {
                            selectedButtonIndex = index
                            onSelectionChange(index)
                            
                            if !hasChanged {
                                onFirstTap()
                                hasChanged = true
                            }
                        }
                    }
                }
            }
        }
        .padding(.vertical, 12)
        
    }
}

#Preview {
    SocketQty { index in
        print("Selected button index: \(index)")
    } onFirstTap: {
        
    }
}
