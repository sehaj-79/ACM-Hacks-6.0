//
//  AR.swift
//  ACM Hacks 6.0
//
//  Created by Shikhar Kumar on 11/02/22.
//

import SwiftUI

struct AR: View {
    var body: some View {
        ZStack {
            ARViewContainer()
                .edgesIgnoringSafeArea(.all)
        }
    }
}

#if DEBUG
struct AR_Previews : PreviewProvider {
    static var previews: some View {
        AR()
    }
}
#endif
